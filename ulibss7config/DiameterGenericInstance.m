//
//  DiameterGenericInstance.m
//  ulibss7config
//
//  Created by Andreas Fink on 29.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "DiameterGenericInstance.h"
#import "DiameterGenericSession.h"
#include <sys/stat.h>

#import "DiameterSession_all.h"

#if 0
/* BASE */
#import "DiameterSessionACR.h"
#import "DiameterSessionASR.h"
#import "DiameterSessionCER.h"
#import "DiameterSessionDPR.h"
#import "DiameterSessionDWR.h"
#import "DiameterSessionRAR.h"
#import "DiameterSessionSTR.h"

/* 3GPP */
#import "DiameterSessionAuthentication_Information_Request.h"
#import "DiameterSessionCancel_Location_Request.h"
#import "DiameterSessionDelete_Subscriber_Data_Request.h"
#import "DiameterSessionInsert_Subscriber_Data_Request.h"
#import "DiameterSessionNotify_Request.h"
#import "DiameterSessionPurge_UE_Request.h"
#import "DiameterSessionReset_Request.h"
#import "DiameterSessionUpdate_Location_Request.h"
#endif

@implementation DiameterGenericInstance


- (void) genericInitialisation
{
    _sessions = [[UMSynchronizedDictionary alloc]init];
    _timeoutInSeconds = 80;
    _operationMutex = [[UMMutex alloc]initWithName:@"DiameterGenericInstance_operationMutext"];
    _uidMutex = [[UMMutex alloc]initWithName:@"SS7GenericInstance_uidMutex"];
    _housekeeping_lock = [[UMMutex alloc]initWithName:@"DiameterGenericInstance_housekeepingLock"];
    _houseKeepingTimerRun = [[UMAtomicDate alloc]init];
    _houseKeepingTimer = [[UMTimer alloc]initWithTarget:self
                                               selector:@selector(housekeeping)
                                                 object:NULL
                                                seconds:1.1
                                                   name:@"housekeeping"
                                                repeats:YES
                                        runInForeground:NO];
    [_houseKeepingTimer start];
}

- (DiameterGenericInstance *)init
{
    self = [super init];
    if(self)
    {
        [self genericInitialisation];
    }
    return self;
}

- (DiameterGenericInstance *)initWithAddress:(NSString *)addr
{
    self = [super init];
    if(self)
    {
        [self genericInitialisation];
        _instanceAddress = addr;
    }
    return self;
}

- (DiameterGenericInstance *)initWithTaskQueueMulti:(UMTaskQueueMulti *)tq
{
    self = [super initWithTaskQueueMulti:tq];
    if(self)
    {
        [self genericInitialisation];
    }
    return self;
}


- (NSUInteger)sessionsCount
{
    return _sessions.count;
}

-(void) setConfig:(NSDictionary *)cfg applicationContext:(id)appContext
{
    [self readLayerConfig:cfg];

    if(cfg[@"timeout"])
    {
        _timeoutInSeconds =[cfg[@"timeout"] doubleValue];
    }
    else
    {
        _timeoutInSeconds = 80;
    }
    if(cfg[@"number"])
    {
        _instanceAddress =[cfg[@"number"] stringValue];
    }

    if(cfg[@"timeout-trace-directory"])
    {
        _timeoutTraceDirectory = [cfg[@"timeout-trace-directory"]stringValue];

        if(_timeoutTraceDirectory.length > 0)
        {
            NSError *e=NULL;
            [[NSFileManager defaultManager]createDirectoryAtPath:_timeoutTraceDirectory withIntermediateDirectories:YES attributes:NULL error:&e];
        }
    }

    if(cfg[@"full-trace-directory"])
    {
        _genericTraceDirectory = [cfg[@"full-trace-directory"]stringValue];

        NSLog(@"adding full trace for %@ to %@", [self layerName],_genericTraceDirectory);

        if(_genericTraceDirectory.length > 0)
        {
            NSError *e=NULL;
            [[NSFileManager defaultManager]createDirectoryAtPath:_genericTraceDirectory withIntermediateDirectories:YES attributes:NULL error:&e];
        }
    }

}

- (void)startUp
{
}

- (NSString *)instancePrefix
{
    return @"DM";
}

- (NSString *)getNewUserIdentifier
{
    uint32_t i = [_diameterRouter nextEndToEndIdentifier];
    NSString *uidstr =  [NSString stringWithFormat:@"%08X",i];
    return uidstr;
}

- (DiameterGenericSession *)sessionById:(NSString *)userId
{
    return _sessions[userId];
}

- (void)addSession:(DiameterGenericSession *)t
            userId:(NSString *)uidstr
{
    _sessions[uidstr] = t;
}

- (void) markSessionForTermination:(DiameterGenericSession *)t
{
    [t.historyLog addLogEntry:@"markSessionForTermination"];
    t.hasEnded = YES;
    /* write traces here */
    [_sessions removeObjectForKey:t.userIdentifier];
}


- (UMHTTPAuthenticationStatus)httpAuthenticateRequest:(UMHTTPRequest *)req
                                                realm:(NSString **)realm
{
    UMHTTPAuthenticationStatus status = [self authenticateUser:req.authUsername pass:req.authPassword];
    if(status==UMHTTP_AUTHENTICATION_STATUS_PASSED)
    {
        return status;
    }

    NSDictionary *p = req.params;
    /* this is used if HTTP auth doesnt pass but &user=xxx & &pass=xxx is passed on the URL */
    NSString *user = [p[@"user"] urldecode];
    NSString *pass = [p[@"pass"] urldecode];
    status = [self authenticateUser:user pass:pass];
    if(status == UMHTTP_AUTHENTICATION_STATUS_PASSED)
    {
        req.authUsername = user;
        req.authPassword = pass;
        return status;
    }
    return status;
}

- (UMHTTPAuthenticationStatus)authenticateUser:(NSString *)user pass:(NSString *)pass
{
    UMHTTPAuthenticationStatus status;
#ifdef AUTH_DEBUG
    NSLog(@"DiameterGenericInstance authenticateUser user=%@ pass=%@",user,pass);
#endif
    if(_authDelegate==NULL)
    {
        status = UMHTTP_AUTHENTICATION_STATUS_PASSED;
    }
    else
    {
        status = [_authDelegate authenticateUser:user pass:pass];
    }
#ifdef AUTH_DEBUG
    switch(status)
    {
        case UMHTTP_AUTHENTICATION_STATUS_UNTESTED:
            NSLog(@"UMHTTP_AUTHENTICATION_STATUS_UNTESTED");
            break;
        case UMHTTP_AUTHENTICATION_STATUS_FAILED:
            NSLog(@"UMHTTP_AUTHENTICATION_STATUS_FAILED");
            break;
        case UMHTTP_AUTHENTICATION_STATUS_PASSED:
            NSLog(@"UMHTTP_AUTHENTICATION_STATUS_PASSED");
            break;
        case UMHTTP_AUTHENTICATION_STATUS_NOT_REQUESTED:
            NSLog(@"UMHTTP_AUTHENTICATION_STATUS_NOT_REQUESTED");
            break;
    }
#endif
    return status;
}

- (DiameterGenericSession *)sessionFactory:(NSString *)s
{
    DiameterGenericSession *session=NULL;

#define SESSION( A ,  B)    \
    if([s isEqualToString:  @(A)]) \
    { \
        session = [[ B alloc]initWithInstance:self];\
    }
#include "DiameterSessions/DiameterSession.inc"

#undef SESSION

    return session;
}



- (void)  httpGetPost:(UMHTTPRequest *)req
{
    @autoreleasepool
    {
        /* pages requesting auth will have UMHTTP_AUTHENTICATION_STATUS_FAILED or UMHTTP_AUTHENTICATION_STATUS_PASSED
         pages not requiring auth will have UMHTTP_AUTHENTICATION_STATUS_NOT_REQUESTED */

        if(req.authenticationStatus == UMHTTP_AUTHENTICATION_STATUS_FAILED)
        {
            [req setResponsePlainText:@"not-authorized"];
            [req setRequireAuthentication];
            return;
        }
        /*
         if(![req.connection.socket.connectedRemoteAddress isEqualToString:@"ipv4:localhost"])
         {
         }
         */
        NSDictionary *p = req.params;
        int pcount=0;
        for(NSString *n in p.allKeys)
        {
            if(([n isEqualToString:@"user"])  || ([n isEqualToString:@"pass"]))
            {
                continue;
            }
            pcount++;
        }
        @try
        {
            NSString *path = req.path;
            if([path hasSuffix:@".php"])
            {
                path = [path substringToIndex:path.length - 4];
            }
            if([path hasSuffix:@".html"])
            {
                path = [path substringToIndex:path.length - 5];
            }
            if([path hasSuffix:@"/"])
            {
                path = [path substringToIndex:path.length - 1];
            }

            if([req.path isEqualToString:@"/diameter"])
            {
                [req redirect:@"/diameter/"];
            }
            else if([req.path isEqualToString:@"/diameter/"]
               || [req.path isEqualToString:@"/diameter/index"]
               || [req.path isEqualToString:@"/diameter/index.php"])
            {
                NSString *s = [DiameterGenericInstance webIndex];
                [req setResponseHtmlString:s];
            }
            else if( [req.path hasPrefix:@"/diameter/"])
            {
                NSString *s = [path substringFromIndex:10];
                NSDictionary *p = req.params;
                int pcount=0;
                for(NSString *n in p.allKeys)
                {
                    if(([n isEqualToString:@"user"])  || ([n isEqualToString:@"pass"]))
                    {
                        continue;
                    }
                    pcount++;
                }
                NSArray *sa = [s componentsSeparatedByString:@"?"];
                if(sa.count>1)
                {
                    s = sa[0];
                }
                DiameterGenericSession *session = [self sessionFactory:s];
                if(pcount==0)
                {
                    [req setResponseHtmlString:[session webForm]];
                }
                else
                {
                    [session setHttpRequest:req instance:self];
                    [self queueFromUpper:session];
                }
            }
        }
        @catch(NSException *e)
        {
            NSMutableDictionary *d1 = [[NSMutableDictionary alloc]init];
            if(e.name)
            {
                d1[@"name"] = e.name;
            }
            if(e.reason)
            {
                d1[@"reason"] = e.reason;
            }
            if(e.userInfo)
            {
                d1[@"user-info"] = e.userInfo;
            }
            NSDictionary *d =   @{ @"error" : @{ @"exception": d1 } };
            [req setResponsePlainText:[d jsonString]];
        }
    }
}

- (void)httpRequestTimeout:(UMHTTPRequest *)req
{
    NSDictionary *d = @{ @"error" : @"timeout" };
    [req setResponsePlainText:[d jsonString]];
}

- (NSString *)status
{
    return [NSString stringWithFormat:@"IS:%lu",[_sessions count]];
}

+ (NSString *)webIndex
{
    static NSMutableString *s = NULL;

    if(s)
    {
        return s;
    }
    s = [[NSMutableString alloc]init];
    [DiameterGenericInstance webHeader:s title:@"GSM-API Main Menu"];
    [s appendString:@"<h2>Diameter Menu</h2>\n"];


#define SESSION( A ,  B)  [s appendFormat:@"<LI><a href=\"%s\">%s</a>\n",A,A];
#include "DiameterSessions/DiameterSession.inc"
#undef SESSION

    [s appendString:@"</UL>\n"];
    [s appendString:@"</body>\n"];
    [s appendString:@"</html>\n"];
    return s;
}


+ (void)webHeader:(NSMutableString *)s title:(NSString *)t script:(NSString *)script
{
    [s appendString:@"<html>\n"];
    [s appendString:@"<head>\n"];
    [s appendString:@"    <link rel=\"stylesheet\" href=\"/css/style.css\" type=\"text/css\">\n"];
    [s appendFormat:@"    <title>%@</title>\n",t];
    [s appendString:script];
    [s appendString:@"</head>\n"];
    [s appendString:@"<body>\n"];
}

+ (void)webHeader:(NSMutableString *)s title:(NSString *)t
{
    return [DiameterGenericInstance webHeader:s title:t script:@""];
}

- (NSString *)webScript
{
    return @"";
}

- (void)housekeeping
{
    if([_housekeeping_lock tryLock] == 0)
    {
        NSArray *keys = [_sessions allKeys];
        for(NSString *key in keys)
        {
            DiameterGenericSession *t = _sessions[key];
            if(t.hasEnded)
            {
                [_sessions removeObjectForKey:key];
            }
            if([t isTimedOut])
            {
                [t timeout];
            }
        }
        [_houseKeepingTimerRun touch];
        [_housekeeping_lock unlock];
    }
}

- (void)processIncomingRequestPacket:(UMDiameterPacket *)packet
                              router:(UMDiameterRouter *)router
                                peer:(UMDiameterPeer *)peer
{

}

- (void)processIncomingErrorPacket:(UMDiameterPacket *)packet
                            router:(UMDiameterRouter *)router
                              peer:(UMDiameterPeer *)peer
{
    NSString *key = [DiameterGenericInstance localIdentifierFromEndToEndIdentifier:packet.endToEndIdentifier];
    DiameterGenericSession *session = _sessions[key];
    [session responseError:packet];
}

- (void)processIncomingResponsePacket:(UMDiameterPacket *)packet
                               router:(UMDiameterRouter *)router
                                 peer:(UMDiameterPeer *)peer
{
    packet = [self parsePacket:packet];
    NSString *key = [DiameterGenericInstance localIdentifierFromEndToEndIdentifier:packet.endToEndIdentifier];
    DiameterGenericSession *session = _sessions[key];
    [session responsePacket:packet];
}


- (void)sendOutgoingRequestPacket:(UMDiameterPacket *)packet
                             peer:(UMDiameterPeer *)peer

{
    packet.commandFlags |= DIAMETER_COMMAND_FLAG_REQUEST;
    packet.commandFlags &= ~DIAMETER_COMMAND_FLAG_ERROR;
    [_diameterRouter localSendPacket:packet toPeer:peer];
}

- (void)sendOutgoingErrorPacket:(UMDiameterPacket *)packet peer:(UMDiameterPeer *)peer
{
    packet.commandFlags |= DIAMETER_COMMAND_FLAG_ERROR;
    packet.commandFlags &= ~DIAMETER_COMMAND_FLAG_REQUEST;

    [_diameterRouter localSendPacket:packet toPeer:peer];
}

- (void)sendOutgoingResponsePacket:(UMDiameterPacket *)packet peer:(UMDiameterPeer *)peer
{
    packet.commandFlags &= ~(DIAMETER_COMMAND_FLAG_REQUEST | DIAMETER_COMMAND_FLAG_ERROR);
    [_diameterRouter localSendPacket:packet toPeer:peer];
}

+ (NSString *)localIdentifierFromEndToEndIdentifier:(uint32_t)e2e
{
    return [NSString stringWithFormat:@"%08X@local",e2e];
}

+ (NSString *)remoteIdentifierFromEndToEndIdentifier:(uint32_t)e2e host:(NSString *)host
{
    return [NSString stringWithFormat:@"%08X@%@",e2e,host];
}


-(UMDiameterPacket *)parsePacket:(UMDiameterPacket *)packet
{
    /* here we should convert a generic AVP to a specific AVP */
    return packet;
}

@end




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

#import "DiameterSession3GPP_AIR.h"
#import "DiameterSession3GPP_BIR.h"
#import "DiameterSession3GPP_CLR.h"
#import "DiameterSession3GPP_DSR.h"
#import "DiameterSession3GPP_ECR.h"
#import "DiameterSession3GPP_IDR.h"
#import "DiameterSession3GPP_LCS_PLR.h"
#import "DiameterSession3GPP_LCS_LRR.h"
#import "DiameterSession3GPP_LCS_RIR.h"
#import "DiameterSession3GPP_LIR.h"
#import "DiameterSession3GPP_MAR.h"
#import "DiameterSession3GPP_MPR.h"
#import "DiameterSession3GPP_NIR.h"
#import "DiameterSession3GPP_NOR.h"
#import "DiameterSession3GPP_PNR.h"
#import "DiameterSession3GPP_PPR.h"
#import "DiameterSession3GPP_PUR.h"
#import "DiameterSession3GPP_PUR.h"
#import "DiameterSession3GPP_RIR.h"
#import "DiameterSession3GPP_RSR.h"
#import "DiameterSession3GPP_RTR.h"
#import "DiameterSession3GPP_SAR.h"
#import "DiameterSession3GPP_SNR.h"
#import "DiameterSession3GPP_UAR.h"
#import "DiameterSession3GPP_UDR.h"
#import "DiameterSession3GPP_ULR.h"
#import "DiameterSession3GPP_CIR.h"
#import "DiameterSessionAAR.h"
#import "DiameterSessionACR.h"
#import "DiameterSessionAMR.h"
#import "DiameterSessionASR.h"
#import "DiameterSessionCCR.h"
#import "DiameterSessionCER.h"
#import "DiameterSessionDER.h"
#import "DiameterSessionDPR.h"
#import "DiameterSessionDWR.h"
#import "DiameterSessionHAR.h"
#import "DiameterSessionRER.h"
#import "DiameterSessionSIP_MAR.h"
#import "DiameterSessionSIP_PPR.h"
#import "DiameterSessionSIP_RTR.h"
#import "DiameterSessionSIP_SAR.h"
#import "DiameterSessionSIP_UAR.h"
#import "DiameterSessionSIP_LIR.h"
#import "DiameterSessionSTR.h"
#import "DiameterSession3GPP_SRR.h"


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
    if ([s isEqualToString:@"asr"])
    {
        session = [[DiameterSessionASR alloc]initWithInstance:self];
    }
    else if ([s isEqualToString:@"acr"])
    {
        session = [[DiameterSessionACR alloc]initWithInstance:self];
    }
    else if ([s isEqualToString:@"cer"])
    {
        session = [[DiameterSessionCER alloc]initWithInstance:self];
    }
    else if ([s isEqualToString:@"dwr"])
    {
        session = [[DiameterSessionDWR alloc]initWithInstance:self];
    }
    else if ([s isEqualToString:@"dpr"])
    {
        session = [[DiameterSessionDPR alloc]initWithInstance:self];
    }
    else if ([s isEqualToString:@"rer"])
    {
        session = [[DiameterSessionRER alloc]initWithInstance:self];
    }
    else if ([s isEqualToString:@"str"])
    {
        session = [[DiameterSessionSTR alloc]initWithInstance:self];
    }
    else if ([s isEqualToString:@"aar"])
    {
        session = [[DiameterSessionAAR alloc]initWithInstance:self];
    }
    else if ([s isEqualToString:@"der"])
    {
        session = [[DiameterSessionDER alloc]initWithInstance:self];
    }
    else if ([s isEqualToString:@"ccr"])
    {
        session = [[DiameterSessionCCR alloc]initWithInstance:self];
    }
    else if ([s isEqualToString:@"sip-uar"])
    {
        session = [[DiameterSessionSIP_UAR alloc]initWithInstance:self];
    }
    else if ([s isEqualToString:@"sip-sar"])
    {
        session = [[DiameterSessionSIP_SAR alloc]initWithInstance:self];
    }
    else if ([s isEqualToString:@"sip-lir"])
    {
        session = [[DiameterSessionSIP_LIR alloc]initWithInstance:self];
    }
    else if ([s isEqualToString:@"sip-mar"])
    {
        session = [[DiameterSessionSIP_MAR alloc]initWithInstance:self];
    }
    else if ([s isEqualToString:@"sip-rtr"])
    {
        session = [[DiameterSessionSIP_RTR alloc]initWithInstance:self];
    }
    else if ([s isEqualToString:@"sip-ppr"])
    {
        session = [[DiameterSessionSIP_PPR alloc]initWithInstance:self];
    }
    else if ([s isEqualToString:@"3gpp-uar"])
    {
        session = [[DiameterSession3GPP_UAR alloc]initWithInstance:self];
    }
    else if ([s isEqualToString:@"3gpp-sar"])
    {
        session = [[DiameterSession3GPP_SAR alloc]initWithInstance:self];
    }
    else if ([s isEqualToString:@"3gpp-lir"])
    {
        session = [[DiameterSession3GPP_LIR alloc]initWithInstance:self];
    }
    else if ([s isEqualToString:@"3gpp-mar"])
    {
        session = [[DiameterSession3GPP_MAR alloc]initWithInstance:self];
    }
    else if ([s isEqualToString:@"3gpp-rtr"])
    {
        session = [[DiameterSession3GPP_RTR alloc]initWithInstance:self];
    }
    else if ([s isEqualToString:@"3gpp-ppr"])
    {
        session = [[DiameterSession3GPP_PPR alloc]initWithInstance:self];
    }
    else if ([s isEqualToString:@"3gpp-udr"])
    {
        session = [[DiameterSession3GPP_UDR alloc]initWithInstance:self];
    }
    else if ([s isEqualToString:@"3gpp-pur"])
    {
        session = [[DiameterSession3GPP_PUR alloc]initWithInstance:self];
    }
    else if ([s isEqualToString:@"3gpp-snr"])
    {
        session = [[DiameterSession3GPP_SNR alloc]initWithInstance:self];
    }
    else if ([s isEqualToString:@"3gpp-pnr"])
    {
        session = [[DiameterSession3GPP_PNR alloc]initWithInstance:self];
    }
    else if ([s isEqualToString:@"3gpp-bir"])
    {
        session = [[DiameterSession3GPP_BIR alloc]initWithInstance:self];
    }
    else if ([s isEqualToString:@"3gpp-mpr"])
    {
        session = [[DiameterSession3GPP_MPR alloc]initWithInstance:self];
    }
    else if ([s isEqualToString:@"3gpp-ulr"])
    {
        session = [[DiameterSession3GPP_ULR alloc]initWithInstance:self];
    }
    else if ([s isEqualToString:@"3gpp-clr"])
    {
        session = [[DiameterSession3GPP_CLR alloc]initWithInstance:self];
    }
    else if ([s isEqualToString:@"3gpp-air"])
    {
        session = [[DiameterSession3GPP_AIR alloc]initWithInstance:self];
    }
    else if ([s isEqualToString:@"3gpp-idr"])
    {
        session = [[DiameterSession3GPP_IDR alloc]initWithInstance:self];
    }
    else if ([s isEqualToString:@"3gpp-dsr"])
    {
        session = [[DiameterSession3GPP_DSR alloc]initWithInstance:self];
    }
    /* DUPE
     else if ([s isEqualToString:@"3gpp-pur"])
     {
     session = [[DiameterSession3GPP_PUR alloc]initWithInstance:self];
     }
     */
    else if ([s isEqualToString:@"3gpp-rsr"])
    {
        session = [[DiameterSession3GPP_RSR alloc]initWithInstance:self];
    }
    else if ([s isEqualToString:@"3gpp-nor"])
    {
        session = [[DiameterSession3GPP_NOR alloc]initWithInstance:self];
    }
    else if ([s isEqualToString:@"3gpp-ecr"])
    {
        session = [[DiameterSession3GPP_ECR alloc]initWithInstance:self];
    }
    else if ([s isEqualToString:@"3gpp-lcs-plr"])
    {
        session = [[DiameterSession3GPP_LCS_PLR alloc]initWithInstance:self];
    }
    else if ([s isEqualToString:@"3gpp-lcs-lrr"])
    {
        session = [[DiameterSession3GPP_LCS_LRR alloc]initWithInstance:self];
    }

    else if ([s isEqualToString:@"3gpp-lcs-rir"])
    {
        session = [[DiameterSession3GPP_LCS_RIR alloc]initWithInstance:self];
    }
    else if ([s isEqualToString:@"amr"])
    {
        session = [[DiameterSessionAMR alloc]initWithInstance:self];
    }
    else if ([s isEqualToString:@"har"])
    {
        session = [[DiameterSessionHAR alloc]initWithInstance:self];
    }
    else if ([s isEqualToString:@"3gpp-cir"])
    {
        session = [[DiameterSession3GPP_CIR alloc]initWithInstance:self];
    }
    else if ([s isEqualToString:@"3gpp-rir"])
    {
        session = [[DiameterSession3GPP_RIR alloc]initWithInstance:self];
    }
    else if ([s isEqualToString:@"3gpp-nir"])
    {
        session = [[DiameterSession3GPP_NIR alloc]initWithInstance:self];
    }

    else if ([s isEqualToString:@"3gpp-srr"])
    {
        session = [[DiameterSession3GPP_SRR alloc]initWithInstance:self];
    }

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

            if(   [path isEqualToString:@"/diameter"]
               || [path isEqualToString:@"/diameter/"]
               || [path isEqualToString:@"/diameter/index"])
            {
                NSString *s = [DiameterGenericInstance webIndex];
                [req setResponseHtmlString:s];
            }
            else if( [path hasPrefix:@"/diameter/"])
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
    [s appendString:@"<h3>S6a Interface</h3>\n"];

    [s appendString:@"<UL>\n"];
    [s appendString:@"<LI><a href=\"3gpp-ulr\">3GPP-ULR Update Location</a>\n"];
    [s appendString:@"<LI><a href=\"3gpp-clr\">3GPP-CLR Cancel Location</a>\n"];
    [s appendString:@"<LI><a href=\"3gpp-air\">3GPP-AIR Authentication Information</a>\n"];
    [s appendString:@"<LI><a href=\"3gpp-idr\">3GPP-ISR Insert Subscriber</a>\n"];
    [s appendString:@"<LI><a href=\"3gpp-dsr\">3GPP-DSR Delete Subscriber</a>\n"];
    [s appendString:@"<LI><a href=\"3gpp-pur\">3GPP-PUR Purge</a>\n"];
    [s appendString:@"<LI><a href=\"3gpp-rsr\">3GPP-RSR Reset</a>\n"];
    [s appendString:@"<LI><a href=\"3gpp-nor\">3GPP-NOR Notify</a>\n"];
    [s appendString:@"</UL>\n"];
    
    
    [s appendString:@"<h3>Other Interface</h3>\n"];

    [s appendString:@"<UL>\n"];

    
    [s appendString:@"<LI><a href=\"asr\">ASR Abort Session</a>\n"];
    [s appendString:@"<LI><a href=\"acr\">ACR Abort Session</a>\n"];
    [s appendString:@"<LI><a href=\"cer\">CER Capabilities Exchange</a>\n"];
    [s appendString:@"<LI><a href=\"dwr\">DWR Device Watchdog</a>\n"];
    [s appendString:@"<LI><a href=\"dpr\">DPR Disconnect Peer</a>\n"];
    [s appendString:@"<LI><a href=\"rer\">RER Re Auth</a>\n"];
    [s appendString:@"<LI><a href=\"str\">STR Session Termination</a>\n"];
    [s appendString:@"<LI><a href=\"aar\">AAR</a>\n"];
    [s appendString:@"<LI><a href=\"der\">DER</a>\n"];
    [s appendString:@"<LI><a href=\"ccr\">CCR</a>\n"];
    [s appendString:@"<LI><a href=\"sip-uar\">SIP-UAR</a>\n"];
    [s appendString:@"<LI><a href=\"sip-sar\">SIP-SAR</a>\n"];
    [s appendString:@"<LI><a href=\"sip-lir\">SIP-LIR</a>\n"];
    [s appendString:@"<LI><a href=\"sip-mar\">SIP-MAR</a>\n"];
    [s appendString:@"<LI><a href=\"sip-rtr\">SIP-RTR</a>\n"];
    [s appendString:@"<LI><a href=\"sip-ppr\">SIP-PPR</a>\n"];
    [s appendString:@"<LI><a href=\"3gpp-uar\">3GPP-UAR</a>\n"];
    [s appendString:@"<LI><a href=\"3gpp-sar\">3GPP-SAR</a>\n"];
    [s appendString:@"<LI><a href=\"3gpp-lir\">3GPP-LIR</a>\n"];
    [s appendString:@"<LI><a href=\"3gpp-mar\">3GPP-MAR</a>\n"];
    [s appendString:@"<LI><a href=\"3gpp-rtr\">3GPP-RTR</a>\n"];
    [s appendString:@"<LI><a href=\"3gpp-ppr\">3GPP-PPR</a>\n"];
    [s appendString:@"<LI><a href=\"3gpp-udr\">3GPP-UDR</a>\n"];
    [s appendString:@"<LI><a href=\"3gpp-pur\">3GPP-PUR</a>\n"];
    [s appendString:@"<LI><a href=\"3gpp-snr\">3GPP-SNR</a>\n"];
    [s appendString:@"<LI><a href=\"3gpp-pnr\">3GPP-PNR</a>\n"];
    [s appendString:@"<LI><a href=\"3gpp-bir\">3GPP-BIR</a>\n"];
    [s appendString:@"<LI><a href=\"3gpp-mpr\">3GPP-MPR</a>\n"];

    [s appendString:@"<LI><a href=\"3gpp-ecr\">3GPP-ECR Mobile Equipment Identity Check</a>\n"];
    [s appendString:@"<LI><a href=\"3gpp-lcs-plr\">3GPP-LCS-PLR Provide-Location-Request/</a>\n"];
    [s appendString:@"<LI><a href=\"3gpp-lcs-lrr\">3GPP-LCS-LRR Location-Report-Request/</a>\n"];
    [s appendString:@"<LI><a href=\"3gpp-lcs-rir\">3GPP-LCS-RIR LCS-Routing-Info-Request</a>\n"];
    [s appendString:@"<LI><a href=\"amr\">AMR</a>\n"];
    [s appendString:@"<LI><a href=\"har\">HAR</a>\n"];

    [s appendString:@"<LI><a href=\"3gpp-cir\">3GPP-CIR</a>\n"];
    [s appendString:@"<LI><a href=\"3gpp-rir\">3GPP-RIR</a>\n"];
    [s appendString:@"<LI><a href=\"3gpp-nir\">3GPP-NIR</a>\n"];
    [s appendString:@"<LI><a href=\"3gpp-srr\">3GPP-SRR SendRoutingInfoForSM</a>\n"];
    [s appendString:@"<LI><a href=\"3gpp-udr\">3GPP-UDR User Data Request</a>\n"];

    [s appendString:@"</UL>\n"];
    [s appendString:@"</body>\n"];
    [s appendString:@"</html>\n"];
    return s;
}

+ (void)webHeader:(NSMutableString *)s title:(NSString *)t
{
    [s appendString:@"<html>\n"];
    [s appendString:@"<header>\n"];
    [s appendString:@"    <link rel=\"stylesheet\" href=\"/css/style.css\" type=\"text/css\">\n"];
    [s appendFormat:@"    <title>%@</title>\n",t];
    [s appendString:@"</header>\n"];
    [s appendString:@"<body>\n"];
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
    NSString *key = [DiameterGenericInstance localIdentifierFromEndToEndIdentifier:packet.endToEndIdentifier];
    DiameterGenericSession *session = _sessions[key];
    [session responsePacket:packet];
}


- (void)sendOutgoingRequestPacket:(UMDiameterPacket *)packet peer:(UMDiameterPeer *)peer
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

@end




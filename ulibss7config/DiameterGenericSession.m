//
//  DiameterGenericSession.m
//  ulibss7config
//
//  Created by Andreas Fink on 29.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "DiameterGenericSession.h"
#import "DiameterGenericInstance.h"

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#import "WebMacros.h"

@implementation DiameterGenericSession

- (NSString *)getNewUserIdentifier
{
    return NULL;
}

#pragma mark -
#pragma mark initializer handling

- (void)genericInitialisation:(DiameterGenericInstance *)inst
{
    _gInstance = inst;
    _options = [[NSMutableDictionary alloc]init];
    _sessionName = [[self class] description];
    self.name = _sessionName; /* umtask name */
    _timeoutInSeconds = inst.timeoutInSeconds;
    _startTime = [NSDate date];
    _lastActiveTime = [[UMAtomicDate alloc]initWithDate:_startTime];
    self.logFeed = inst.logFeed;
    _logLevel = UMLOG_MAJOR;
    _operationMutex = [[UMMutex alloc]initWithName:@"DiameterGenericSession_operationMutex"];
    _historyLog = [[UMHistoryLog alloc]init];
    _outputFormat = OutputFormat_json;
}

- (DiameterGenericSession *)init
{
    NSString *s = [NSString stringWithFormat:@"dont call [%@ init]. Call initWithInstance: instead",[[self class]description]];
    NSAssert(0,s);
    return NULL;
}

-(DiameterGenericSession *)initWithInstance:(DiameterGenericInstance *)inst
{
    [_historyLog addLogEntry:@"DiameterGenericSession: initWithInstance"];

    self = [super init];
    if(self)
    {
        [self genericInitialisation:inst];
    }
    return self;
}

-(DiameterGenericSession *)initWithHttpReq:(UMHTTPRequest *)xreq
                                  instance:(DiameterGenericInstance *)inst
{
    [_historyLog addLogEntry:@"DiameterGenericSession: initWithHttpReq"];

    self = [super init];
    if(self)
    {
        _req  = xreq;
        _params = [xreq.params urldecodeStringValues];
        [self genericInitialisation:inst];
        [self setTimeouts];
        [self setOptions];
        [_req makeAsyncWithTimeout:_timeoutInSeconds delegate:_gInstance];
    }
    return self;
}

-(DiameterGenericSession *)setHttpRequest:(UMHTTPRequest *)xreq
                                 instance:(DiameterGenericInstance *)inst
{

    [_historyLog addLogEntry:@"DiameterGenericSession: setHttpRequest"];
    [self genericInitialisation:inst];
    [self setTimeouts];
    [self setOptions];
    _req = xreq;
    _params = [xreq.params urldecodeStringValues];
    [_req makeAsyncWithTimeout:_timeoutInSeconds delegate:_gInstance];
    return self;
}

- (DiameterGenericSession *)initWithQuery:(UMDiameterPacket *)packet
                                      req:(UMHTTPRequest *)xreq
                              commandCode:(uint32_t) cc
                             localAddress:(NSString *)la
                            remoteAddress:(NSString *)ra
                               localRealm:(NSString *)lr
                              remoteRealm:(NSString *)rr
                                 instance:(DiameterGenericInstance *)xInstance
                                  options:(NSDictionary *) xoptions
{
    [_historyLog addLogEntry:@"DiameterGenericSession: initWithQuery"];
    self = [super init];
    if(self)
    {
        [self genericInitialisation:xInstance];
        _commandCode = cc;
        _localRealm = lr;
        _remoteRealm = rr;
        _localAddress = la;
        _remoteAddress = ra;
        _req  = xreq;
        if(xoptions)
        {
            _options = [xoptions mutableCopy];
        }
        else
        {
            _options = [[NSMutableDictionary alloc]init];
        }
        [self setTimeouts];
        [self setOptions];
    }
    return self;
}

- (DiameterGenericSession *)initWithSession:(DiameterGenericSession *)ot
{
    [_historyLog addLogEntry:@"DiameterGenericSession: initWithSession"];

    self = [super init];
    if(self)
    {
        [self genericInitialisation:ot.gInstance];
        _commandCode = ot.commandCode;
        _query = ot.query;
        _gInstance = ot.gInstance;
        _localAddress = ot.localAddress;
        _remoteAddress = ot.remoteAddress;
        _localRealm = ot.localRealm;
        _remoteRealm = ot.remoteRealm;
        _req = ot.req;
        _options = [ot.options mutableCopy];
        _pcap = ot.pcap;
        _startTime = ot.startTime;
        _lastActiveTime = ot.lastActiveTime;
        _timeoutInSeconds = ot.timeoutInSeconds;
        _doEnd = ot.doEnd;
        _incomingOptions = ot.incomingOptions;
        _nowait = ot.nowait;
        _historyLog = ot.historyLog;
        _incoming = ot.incoming;
        _outgoing = ot.outgoing;
        _outputFormat = ot.outputFormat;
        _undefinedSession = NO; /* we get called for overrided object here */
    }
    return self;
}



- (void)markForTermination
{
    [self touch];
    [_historyLog addLogEntry:@"DiameterGenericSession: markForTermination"];
    [_gInstance markSessionForTermination:self];
}

- (void)outputResult2:(UMSynchronizedSortedDictionary *)dict
{
    NSString *json;
    @try
    {
        json = [dict jsonString];
    }
    @catch(id err)
    {
        [self.logFeed majorErrorText:[NSString stringWithFormat:@"DiameterSession: exception: %@",err]];
    }
    if(!json)
    {
        json = [NSString stringWithFormat:@"json-encoding problem %@",dict];
    }
    [_req setResponsePlainText:json];
    [_req resumePendingRequest];
    [self touch];
}



#pragma mark -
#pragma mark helper methods

- (void) handleAddresses
{
    NSDictionary *p = _req.params;

    _localRealm     = [p[@"local-realm"]urldecode];
    _localAddress   = [p[@"local-address"]urldecode];
    _remoteRealm    = [p[@"remote-realm"]urldecode];
    _remoteAddress  = [p[@"remote-address"]urldecode];

    if([_localRealm isEqualToString:@"default"])
    {
        _localRealm = _gInstance.localRealm;
    }
    if([_localAddress isEqualToString:@"default"])
    {
        _localAddress = _gInstance.localAddress;
    }
}


-(void) setTimeouts
{
    NSDictionary *p = _req.params;
    NSString *to = [p[@"timeout"]urldecode];

    if(to.length > 0)
    {
        _timeoutInSeconds = [to doubleValue];
    }
}

- (void) setOptions
{
    NSDictionary *p = _req.params;
    if(_options==NULL)
    {
        @throw(@"options not initialized!");
    }

    if(p[@"nowait"]!=NULL)
    {
        _nowait = [p[@"nowait"] intValue];
    }
}

- (void)submit
{
    if(_nowait)
    {
        [_req setResponsePlainText:@"Sent"];
        [_req resumePendingRequest];
    }
    else
    {
        [_req makeAsyncWithTimeout:_timeoutInSeconds];
    }

    if(_endToEndIdentifier == 0)
    {
        _endToEndIdentifier = [_gInstance.diameterRouter nextEndToEndIdentifier];
    }

    if(_commandCode == 0)
    {
       _commandCode = _query.commandCode;
    }
    _query.endToEndIdentifier = _endToEndIdentifier;
    _userIdentifier = [DiameterGenericInstance localIdentifierFromEndToEndIdentifier:_endToEndIdentifier];
    [_gInstance addSession:self userId:_userIdentifier];
    
    UMDiameterRouter *r = _gInstance.diameterRouter;
    UMDiameterRoute *route = [r findRouteForRealm:p.destinationRealm];
    if(route.peer == NULL)
    {
        route = [r findRouteForHost:p.destinationHost];
    }
    [_gInstance sendOutgoingRequestPacket:_query peer:route.peer];
}

- (void)responsePacket:(UMDiameterPacket *)pkt
{
    UMSynchronizedSortedDictionary *dict = [[UMSynchronizedSortedDictionary alloc]init];
    [self touch];
    dict[@"query"] =  _query.objectValue;
    dict[@"response"] = pkt.objectValue;
    [_operationMutex lock];
    [self outputResult2:dict];
    [self markForTermination];
    [_operationMutex unlock];
}

- (void)responseError:(UMDiameterPacket *)pkt
{
    UMSynchronizedSortedDictionary *dict = [[UMSynchronizedSortedDictionary alloc]init];
    [self touch];
    dict[@"query"] =  _query.objectValue;
    dict[@"error"] = pkt.objectValue;
    [_operationMutex lock];
    [self outputResult2:dict];
    [self markForTermination];
    [_operationMutex unlock];
}

- (void)webException:(NSException *)e
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
    NSString *errString = [d jsonString];
    [_gInstance logMinorError:errString];
    [_req setResponsePlainText:errString];
    [_req resumePendingRequest];
}

- (NSString *)description
{
    NSMutableString *s = [[NSMutableString alloc]init];
    [s appendFormat:@"SS7GenericSession [%p]:\n",self];
    [s appendFormat:@"{\n"];
    [s appendFormat:@"\tsessionName: %@\n",_sessionName];
    [s appendFormat:@"\tuserIdentifier: %@\n",_userIdentifier];
    [s appendFormat:@"\tgInstance: '%@'\n",_gInstance.layerName];
    [s appendFormat:@"\tcommandCode %u\n",(uint32_t)_commandCode];
    [s appendFormat:@"\thttp request %p\n",_req];
    [s appendFormat:@"\tundefinedSession %@\n",_undefinedSession ? @"YES" : @"NO"];
    [s appendFormat:@"}\n"];
    return s;
}


- (void)logWebSession
{
    if(_gInstance.logLevel <= UMLOG_DEBUG)
    {
        NSString *s = [NSString stringWithFormat:@"%@: %@",_sessionName,_req.params ];
        [_gInstance logDebug:s];
    }
}

+ (void)webPageStart:(NSMutableString *)s title:(NSString *)t script:(NSString *)script
{
    [DiameterGenericInstance webHeader:s title:t script:script];
}

+ (void)webFormStart:(NSMutableString *)s title:(NSString *)t script:(NSString *)script
{
    [s appendString:@"\n"];
    [s appendString:@"<a href=\"index.php\">menu</a>\n"];
    [s appendFormat:@"<h2>%@</h2>\n",t];
}

+ (void)webFormStart:(NSMutableString *)s title:(NSString *)t
{
    return [self webFormStart:s title:t script:@""];
}

+ (void)webFormEnd:(NSMutableString *)s
{
    [s appendString:@"<script defer src=\"/js/bundle.js\"></script>"];
}

+ (void)webPageEnd:(NSMutableString *)s
{
    [s appendString:@"</body>\n"];
    [s appendString:@"</html>\n"];
    [s appendString:@"\n"];
}

+ (void)webVariousTitle:(NSMutableString *)s
{
    [s appendString:@"<tr><td colspan=2 class=subtitle>Various Extensions:</td></tr>\n"];
}

+ (void)webVariousOptions:(NSMutableString *)s
{
    /*
    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>tcap-handshake</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"tcap-handshake\" type=\"text\" value=\"0\"> 0 |&nbsp;1</td>\n"];
    [s appendString:@"</tr>\n"];
    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>timeout</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"timeout\" type=\"text\" value=\"30\"> timeout in seconds</td>\n"];
    [s appendString:@"</tr>\n"];
    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>application-context</td>\n"];
    [s appendFormat:@"    <td class=optional><input name=\"application-context\" type=\"text\" value=\"%@\"> %@</td>\n",ac,acn];
    [s appendString:@"</tr>\n"];
    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>keep-sccp-calling-addr</td>\n"];
    [s appendFormat:@"    <td class=optional><input name=\"keep-sccp-calling-addr\" type=\"text\" value=\"0\"> 0&nbsp;|&nbsp;1</td>\n"];
    [s appendString:@"</tr>\n"];
    */
}

- (void)touch
{
    if(_lastActiveTime==NULL)
    {
        _lastActiveTime = [[UMAtomicDate alloc]init];
    }
    else
    {
        [_lastActiveTime touch];
    }
}

- (void)timeout /* gets called when timeouts occur */
{
    [self touch];
    [_historyLog addLogEntry:@"timeout"];
    [self.logFeed infoText:@"timeout"];

    UMSynchronizedSortedDictionary *dict = [[UMSynchronizedSortedDictionary alloc]init];
    dict[@"query"] =  _query.objectValue;
    dict[@"timeout"] = @(YES);
    dict[@"user-identifier"] = _userIdentifier;
    [_operationMutex lock];
    [self outputResult2:dict];
    [self markForTermination];
    [_operationMutex unlock];
}

- (void)writeTraceToDirectory:(NSString *)dir
{
}

- (BOOL)isTimedOut
{
    if(_lastActiveTime == NULL)
    {
        _lastActiveTime = [[UMAtomicDate alloc]init];
    }
    NSTimeInterval duration = [_lastActiveTime age];
    if(duration > _timeoutInSeconds)
    {
        return YES;
    }
    return NO;
}

- (NSString *)webTitle
{
    return @"undefined";
}

- (NSString *)webForm
{
    NSMutableString *s = [[NSMutableString alloc]init];

    [DiameterGenericSession webPageStart:s title: [self webTitle]  script:[self webScript1]];
    [DiameterGenericSession webFormStart:s title: [self webTitle]  script:[self webScript1]];
    [DiameterGenericSession webFormEnd:s];
    [DiameterGenericSession webPageEnd:s];
    return s;
}

- (NSString *)webScript1
{
    NSMutableString *s = [[NSMutableString alloc]init];
    [s appendString:@"<link rel='stylesheet' href='/css/global.css'>\n"];
    [s appendString:@"<link rel='stylesheet' href='/css/bundle.css'>\n"];
    [s appendString:@"<link rel='icon' type='image/png' href='/favicon.png'>\n"];
    [s appendString:[self webScript]];
    return s;
}

- (NSString *)webScript
{
    return @"";
}

- (void)webApplicationParameters:(NSMutableString *)s defaultApplicationId:(uint32_t)dai comment:(NSString *)comment
{
    return [self webApplicationParameters:s defaultApplicationId:dai comment:comment hidden:NO];
}

- (void)webApplicationParameters:(NSMutableString *)s defaultApplicationId:(uint32_t)dai comment:(NSString *)comment hidden:(BOOL)hidden
{
    if(comment==NULL)
    {
        comment = umdiameter_application_id_string(dai);
    }
    if(hidden)
    {
        [s appendFormat:@"<input name=\"application-id\" type=hidden value=%u>\n",dai];
    }
    else
    {
        [s appendString:@"<tr>\n"];
        [s appendString:@"    <td class=mandatory>application-id</td>\n"];
        [s appendFormat:@"    <td class=mandatory><input name=\"application-id\" type=text value=%u>(%@)</td>\n",dai,comment];
        [s appendString:@"</tr>\n"];
    }
}

- (void)webDiameterParameters:(NSMutableString *)s
{
    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>not-implemented</td>\n"];
    [s appendString:@"    <td class=optional>---</td>\n"];
    [s appendString:@"</tr>\n"];
}

+ (void)webDiameterTitle:(NSMutableString *)s
{
    [s appendString:@"<tr><td colspan=2 class=subtitle>Diameter Parameters:</td></tr>\n"];
}

+ (void)webDiameterOptions:(NSMutableString *)s
{
    /*
    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>map-open-destination-msisdn</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"map-open-destination-msisdn\" type=text placeholder=\"+12345678\"> msisdn in map-open destination reference</td>\n"];
    [s appendString:@"</tr>\n"];
    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>map-open-destination-imsi</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"map-open-destination-imsi\" type=text> imsi in map-open destination reference</td>\n"];
    [s appendString:@"</tr>\n"];
    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>map-open-origination-msisdn</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"map-open-origination-msisdn\" type=text placeholder=\"+12345678\"> msisdn in map-open origination reference</td>\n"];
    [s appendString:@"</tr>\n"];
    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>map-open-origination-imsi</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"map-open-origination-imsi\" type=text> imsi in map-open origination reference</td>\n"];
    [s appendString:@"</tr>\n"];
     */
}

- (void)setApplicationId:(UMDiameterPacket *)pkt  default:(UMDiameterApplicationId) def
{
    NSDictionary *p = _req.params;
    NSString *application_id;
    SET_OPTIONAL_CLEAN_PARAMETER(p,application_id,@"application-id");
    if([application_id isEqualToString:@"default"])
    {
        pkt.applicationId = def;
    }
    else if(application_id.length > 0)
    {
        pkt.applicationId = (uint32_t)[application_id integerValue];
    }
    else
    {
        pkt.applicationId = def;
    }
}

- (void)setHostAndRealms:(UMDiameterPacket *)packet fromParams:(NSDictionary *)p
{
    NSString *originHost;
    NSString *originRealm;
    NSString *destinationHost;
    NSString *destinationRealm;
    SET_OPTIONAL_CLEAN_PARAMETER(p,originHost,@"origin-host");
    SET_OPTIONAL_CLEAN_PARAMETER(p,destinationHost,@"destination-host");
    SET_OPTIONAL_CLEAN_PARAMETER(p,originRealm,@"origin-realm");
    SET_OPTIONAL_CLEAN_PARAMETER(p,destinationRealm,@"destination-realm");

    if(originHost.length > 0)
    {
        // { Origin-Host }
        UMDiameterAvpOrigin_Host *avp = [[UMDiameterAvpOrigin_Host alloc]init];
        [avp setFlagMandatory:YES];
        avp.avpData =[originHost dataUsingEncoding:NSUTF8StringEncoding];
        [packet appendAvp:avp];
    }
    // { Origin-Realm }
    if(originRealm.length > 0)
    {
        UMDiameterAvpOrigin_Realm *avp = [[UMDiameterAvpOrigin_Realm alloc]init];
        [avp setFlagMandatory:YES];
        avp.avpData =[originRealm  dataUsingEncoding:NSUTF8StringEncoding];
        [packet appendAvp:avp];
    }

    if(destinationHost.length > 0)
    {
        // { Destination-Host }
        UMDiameterAvpDestination_Host *avp = [[UMDiameterAvpDestination_Host alloc]init];
        [avp setFlagMandatory:YES];
        avp.avpData =[destinationHost dataUsingEncoding:NSUTF8StringEncoding];
        [packet appendAvp:avp];
    }
    // { Restination-Realm }
    if(destinationRealm.length > 0)
    {
        UMDiameterAvpDestination_Realm *avp = [[UMDiameterAvpDestination_Realm alloc]init];
        [avp setFlagMandatory:YES];
        avp.avpData =[destinationRealm  dataUsingEncoding:NSUTF8StringEncoding];
        [packet appendAvp:avp];
    }
}

- (void)setMandatorySessionId:(UMDiameterPacket *)packet fromParams:(NSDictionary *)p
{
    NSString *sessionId;
    SET_MANDATORY_PARAMETER(p,sessionId,@"session-id");

    if(sessionId.length > 0)
    {
        // < Session-Id >
        UMDiameterAvpSession_Id *avp = [[UMDiameterAvpSession_Id alloc]init];
        [avp setFlagMandatory:YES];
        avp.value = sessionId;
        [packet appendAvp:avp];
    }
}
- (void)setSessionId:(UMDiameterPacket *)packet fromParams:(NSDictionary *)p
{
    NSString *sessionId;
    SET_OPTIONAL_CLEAN_PARAMETER(p,sessionId,@"session-id");

    if(sessionId.length > 0)
    {
        // < Session-Id >
        UMDiameterAvpSession_Id *avp = [[UMDiameterAvpSession_Id alloc]init];
        [avp setFlagMandatory:YES];
        avp.value = sessionId;
        [packet appendAvp:avp];
    }
}


- (void)webDiameterOptionalParameter:(NSMutableString *)s name:(NSString *)name
{
    [s appendString:@"<tr>\n"];
    [s appendFormat:@"    <td class=optional>%@</td>\n",name];
    [s appendFormat:@"    <td class=optional><input name=\"%@\" value=\"\"></td>\n",name];
    [s appendString:@"</tr>\n"];
}

- (void)webDiameterParameter:(NSMutableString *)s
                        name:(NSString *)name
                defaultValue:(NSString *)def
                     comment:(NSString *)comment
                    optional:(BOOL)optional
                 conditional:(BOOL)conditional
{
    NSString *css;
    if(optional==NO)
    {
        css = @"mandatory";
    }
    else
    {
        if(conditional)
        {
            css = @"conditional";
        }
        else
        {
            css = @"optional";
        }
    }
    [s appendString:@"<tr>\n"];
    [s appendFormat:@"    <td class=%@>%@</td>\n",css,name];
    [s appendFormat:@"    <td class=%@><input name=\"%@\" value=\"\" value=\"%@\">%@</td>\n",css,name,def,comment];
    [s appendString:@"</tr>\n"];
}


@end



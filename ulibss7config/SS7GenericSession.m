//
//  SS7GenericSession.m
//  ulibss7config
//
//  Created by Andreas Fink on 20.11.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "SS7GenericSession.h"
#import "SS7GenericInstance.h"

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

@implementation SS7GenericSession


- (void)setOperation:(int64_t)xoperation
{
    _opcode = [[UMLayerGSMMAP_OpCode alloc]initWithOperationCode:xoperation];
}

- (void)setOperation2:(int64_t)xoperation
{
    _opcode2 = [[UMLayerGSMMAP_OpCode alloc]initWithOperationCode:xoperation];
}

- (void)setOperation3:(int64_t)xoperation
{
    _opcode3 = [[UMLayerGSMMAP_OpCode alloc]initWithOperationCode:xoperation];
}

- (void)setFirstResponseOperation:(int64_t)xoperation
{
    _firstResponseOpcode = [[UMLayerGSMMAP_OpCode alloc]initWithOperationCode:xoperation];
}
- (void)setFirstInvokeOperation:(int64_t)xoperation
{
    _firstInvokeOpcode = [[UMLayerGSMMAP_OpCode alloc]initWithOperationCode:xoperation];
}

- (int64_t)operation
{
    return _opcode.operation;
}

- (int64_t)operation2
{
    return _opcode2.operation;
}

- (int64_t)operation3
{
    return _opcode3.operation;
}

- (int64_t)firstResponseOperation
{
    return _firstResponseOpcode.operation;
}

- (int64_t)firstInvokeOperation
{
    return _firstInvokeOpcode.operation;
}

- (void)setIncomingDialogPortion:(UMTCAP_asn1_dialoguePortion *)xdialoguePortion
{
    _incomingDialogPortion = xdialoguePortion;
    if([xdialoguePortion isKindOfClass:[UMTCAP_itu_asn1_dialoguePortion class]]) /* if its a ITU dialog */
    {
        UMTCAP_itu_asn1_dialoguePortion *ituDialoguePortion = (UMTCAP_itu_asn1_dialoguePortion *)xdialoguePortion;
        if(ituDialoguePortion.dialogRequest)
        {
            UMTCAP_asn1_objectIdentifier *oi = ituDialoguePortion.dialogRequest.objectIdentifier;
            NSData *d = oi.asn1_data;
            if(d.length == 7)
            {
                const uint8_t *bytes = d.bytes;
                if((bytes[0] == 4) &&
                   (bytes[1] == 0) &&
                   (bytes[2] == 0) &&
                   (bytes[3] == 1) &&
                   (bytes[4] == 0))
                {
                    _appContextByte = bytes[5];
                    _mapVersion = bytes[6];
                }
            }
        }
    }
}

- (UMTCAP_asn1_dialoguePortion *)incomingDialogPortion
{
    return _incomingDialogPortion;
}

- (UMMTP3Variant)mtp3Variant
{
    return _gInstance.gsmMap.tcap.attachedLayer.variant;
}

- (SccpVariant)sccpVariant
{
    return _gInstance.gsmMap.tcap.attachedLayer.sccpVariant;
}

#define VERIFY_MAP(a,b)\
if( a != b) \
{ \
    [self.logFeed minorErrorText:[NSString stringWithFormat: @"ERROR: got MAP=%@ but was expecting MAP=%@",a,b]];\
    return;\
}

#define VERIFY_SESSION(a,b)\
if(a==NULL) \
{   \
    a = b; \
}\
else \
{\
    if(![a isEqualToString:b]) \
    { \
        [self.logFeed minorErrorText:[NSString stringWithFormat:@"ERROR: got SessionID=%@ but was expecting SessionID=%@",a,b]];\
        return;\
    }\
}

#define VERIFY_DIALOG(a,b)\
if(a==NULL) \
{   \
    a = b; \
}\
else \
{\
    NSString *a1 = a.dialogId; \
    NSString *b1 = b.dialogId; \
    if(![a1 isEqualToString:b1]) \
    { \
        [self.logFeed minorErrorText:[NSString stringWithFormat:@"ERROR: got DialogID=%@ but was expecting DialogID=%@",a,b]];\
        return;\
    }\
}

#define VERIFY_UID(a,b)\
if(a == NULL) \
{   \
    a = b; \
}\
else \
{\
    NSString *a1 = a.userIdentifier; \
    NSString *b1 = b.userIdentifier; \
    if(![a1 isEqualToString:b1]) \
    { \
        [self.logFeed minorErrorText:[NSString stringWithFormat:@"ERROR: got UserIdentifier=%@ but was expecting UserIdentifier=%@",a1,b1]];\
        return;\
    }\
}

- (NSString *)getNewUserIdentifier
{
    return NULL;
}

#pragma mark -
#pragma mark initializer handling

- (void)genericInitialisation:(SS7GenericInstance *)inst operation:(int64_t)xoperation;
{
    _userIdentifier = [inst getNewUserIdentifier];
    _components = [[UMSynchronizedArray alloc]init];
    _gInstance = inst;
    _options = [[NSMutableDictionary alloc]init];
    self.operation = xoperation;
    if(xoperation != UMGSMMAP_Opcode_noOpcode)
    {
        _opcode = [[UMLayerGSMMAP_OpCode alloc]initWithOperationCode:xoperation];
    }

    _undefinedSession = YES;
    _sessionName = [[self class] description];
    self.name = _sessionName; /* umtask name */
    _firstInvokeId = AUTO_ASSIGN_INVOKE_ID;
    _timeoutInSeconds = inst.timeoutInSeconds;
    _startTime = [NSDate date];
    _lastActiveTime = [[UMAtomicDate alloc]initWithDate:_startTime];
    self.logFeed = inst.logFeed;
    _logLevel = inst.logLevel; //UMLOG_MAJOR;
    _operationMutex = [[UMMutex alloc]initWithName:@"SS7GenericSession_operationMutex"];
    _historyLog = [[UMHistoryLog alloc]init];
    _outputFormat = OutputFormat_json;
}

- (SS7GenericSession *)init
{
    NSString *s = [NSString stringWithFormat:@"dont call [%@ init]. Call initWithInstance:operation: instead",[[self class]description]];
    NSAssert(0,s);
    return NULL;
}

-(SS7GenericSession *)initWithInstance:(SS7GenericInstance *)inst
                          operation:(int64_t) xoperation
{
    [_historyLog addLogEntry:@"SS7GenericSession: initWithInstance"];

    self = [super init];
    if(self)
    {
        [self genericInitialisation:inst operation:xoperation];
    }
    return self;
}

-(SS7GenericSession *)initWithHttpReq:(UMHTTPRequest *)xreq
                         operation:(int64_t)xoperation
                          instance:(SS7GenericInstance *)inst
{
    [_historyLog addLogEntry:@"SS7GenericSession: initWithHttpReq"];

    self = [super init];
    if(self)
    {
        _req  = xreq;
        [self genericInitialisation:inst operation:xoperation];
        [self setTimeouts];
        [self setOptions];
        [_req makeAsyncWithTimeout:_timeoutInSeconds delegate:_gInstance];
    }
    return self;
}

- (SS7GenericSession *)initWithQuery:(UMASN1Object *)xquery
                   userIdentifier:(NSString *)uid
                              req:(UMHTTPRequest *)xreq
                        operation:(int64_t) xop
                   callingAddress:(SccpAddress *)src
                    calledAddress:(SccpAddress *)dst
                         instance:(SS7GenericInstance *)xInstance
               applicationContext:(UMTCAP_asn1_objectIdentifier *)xapplicationContext
                         userInfo:(UMTCAP_asn1_userInformation *)xuserInfo
                          options:(NSDictionary *) xoptions
{
    [_historyLog addLogEntry:@"SS7GenericSession: initWithQuery"];

    self = [super init];
    if(self)
    {
        [self genericInitialisation:xInstance operation:xop];
        _localAddress = src;
        _remoteAddress = dst;
        _initialLocalAddress = src;
        _initialRemoteAddress = dst;
        _req  = xreq;
        _applicationContext = xapplicationContext;
        _userInfo = xuserInfo;
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

- (SS7GenericSession *)initWithSession:(SS7GenericSession *)ot
{
    [_historyLog addLogEntry:@"SS7GenericSession: InitWithTransaction"];

    self = [super init];
    if(self)
    {
        [self genericInitialisation:ot.gInstance operation:ot.opcode.operation];
        _userIdentifier = ot.userIdentifier;
        _query = ot.query;
        _opcode = ot.opcode;
        _gInstance = ot.gInstance;
        _localAddress = ot.localAddress;
        _remoteAddress = ot.remoteAddress;
        _req = ot.req;
        _options = [ot.options mutableCopy];
        _applicationContext = ot.applicationContext;
        _incomingApplicationContext = ot.incomingApplicationContext;
        _sccp_sent = ot.sccp_sent;
        _sccp_received = ot.sccp_received;
        _sccpDebugEnabled = ot.sccpDebugEnabled;
        _sccpTracefileEnabled = ot.sccpTracefileEnabled;
        _pcap = ot.pcap;
        _startTime = ot.startTime;
        _lastActiveTime = ot.lastActiveTime;
        _timeoutInSeconds = ot.timeoutInSeconds;
        _incoming_map_open = ot.incoming_map_open;
        _dialogId = ot.dialogId;
        _doEnd = ot.doEnd;
        _tcapVariant = ot.tcapVariant;
        _tcapLocalTransactionId = ot.tcapLocalTransactionId;
        _tcapRemoteTransactionId = ot.tcapRemoteTransactionId;
        _incomingOptions = ot.incomingOptions;
        _components = ot.components;
        _nowait = ot.nowait;
        _historyLog = ot.historyLog;
        _incoming = ot.incoming;
        _outgoing = ot.outgoing;
        _outputFormat = ot.outputFormat;

        _calling_ssn = ot->_calling_ssn;
        _called_ssn = ot->_called_ssn;
        _calling_address = ot->_calling_address;
        _called_address = ot->_called_address;
        _calling_tt = ot->_calling_tt;
        _called_tt = ot->_called_tt;

        _undefinedSession = NO; /* we get called for overrided object here */

    }
    return self;
}


#pragma mark -
#pragma mark handle incoming components

-(void) sessionMAP_Invoke_Ind:(UMASN1Object *)param
                       userId:(UMGSMMAP_UserIdentifier *)xuserIdentifier
                       dialog:(UMGSMMAP_DialogIdentifier *)xdialogId
                  transaction:(NSString *)xtcapTransactionId
                       opCode:(UMLayerGSMMAP_OpCode *)xopcode
                     invokeId:(int64_t)xinvokeId
                     linkedId:(int64_t)xlinkedId
                         last:(BOOL)xlast
                      options:(NSDictionary *)xoptions
{
    [_historyLog addLogEntry:@"SS7GenericSession: sessionMAP_Invoke_Ind (should be overriden)"];
    _hasReceivedInvokes++;
    /* this should be overriden */
}

-(void) sessionMAP_Invoke_Ind_Log:(UMASN1Object *)param
                           userId:(UMGSMMAP_UserIdentifier *)xuserIdentifier
                           dialog:(UMGSMMAP_DialogIdentifier *)xdialogId
                      transaction:(NSString *)xtcapTransactionId
                           opCode:(UMLayerGSMMAP_OpCode *)xopcode
                         invokeId:(int64_t)xinvokeId
                         linkedId:(int64_t)xlinkedId
                             last:(BOOL)xlast
                          options:(NSDictionary *)xoptions
{
    UMSynchronizedSortedDictionary *info_sub = [[UMSynchronizedSortedDictionary alloc]init];
    UMSynchronizedSortedDictionary *info = [[UMSynchronizedSortedDictionary alloc]init];
    UMSynchronizedSortedDictionary *comp = [[UMSynchronizedSortedDictionary alloc]init];
    info_sub[@"invokeId"] =  @(xinvokeId);
    if(xlinkedId != TCAP_UNDEFINED_LINKED_ID)
    {
        info_sub[@"linkedId"] = @(xlinkedId);
    }

    if(param.objectName)
    {
        info_sub[param.objectName] =  param.objectValue;
    }

    info[@"invoke"] = info_sub;
    comp[@"rx"] = info;
    [_components addObject:comp];
}

- (void) sessionMAP_ReturnResult_Log:(UMASN1Object *)xparam
                              dialog:(UMGSMMAP_DialogIdentifier *)dialogId
                            invokeId:(int64_t)xinvokeId
                            linkedId:(int64_t)xlinkedId
                              opCode:(UMLayerGSMMAP_OpCode *)xopcode
                                last:(int64_t)xlast
                             options:(NSDictionary *)xoptions
{
    UMSynchronizedSortedDictionary *info_sub = [[UMSynchronizedSortedDictionary alloc]init];
    UMSynchronizedSortedDictionary *info = [[UMSynchronizedSortedDictionary alloc]init];
    UMSynchronizedSortedDictionary *comp = [[UMSynchronizedSortedDictionary alloc]init];
    info_sub[@"invokeId"] =  @(xinvokeId);
    if(xlinkedId != TCAP_UNDEFINED_LINKED_ID)
    {
        info_sub[@"linkedId"] = @(xlinkedId);
    }

    if(xparam.objectName)
    {
        info_sub[xparam.objectName] =  xparam.objectValue;
    }
    if(xlast)
    {
        info[@"ReturnResultLast"] = info_sub;
    }
    else
    {
        info[@"ReturnResultNotLast"] = info_sub;
    }
    comp[@"tx"] = info;
    [_components addObject:comp];
}

-(void) sessionMAP_ReturnResult_Resp:(UMASN1Object *)param
                              userId:(UMGSMMAP_UserIdentifier *)xuserIdentifier
                              dialog:(UMGSMMAP_DialogIdentifier *)xdialogId
                         transaction:(NSString *)xtcapTransactionId
                              opCode:(UMLayerGSMMAP_OpCode *)xopcode
                            invokeId:(int64_t)xinvokeId
                            linkedId:(int64_t)xlinkedId
                                last:(BOOL)xlast
                             options:(NSDictionary *)xoptions
{
    if(_logLevel <=UMLOG_DEBUG)
    {
        [self logDebug:@"sessionMAP_ReturnResult_Resp"];
    }

    [_historyLog addLogEntry:@"SS7GenericSession: sessionMAP_ReturnResult_Resp"];

    VERIFY_UID(_userIdentifier,xuserIdentifier);
    VERIFY_DIALOG(_dialogId,xdialogId);
    VERIFY_SESSION(_tcapLocalTransactionId,xtcapTransactionId);


    SccpAddress *calling = xoptions[@"sccp-calling-address"];
    SccpAddress *called = xoptions[@"sccp-called-address"];
    if(called)
    {
        _localAddress = called;
    }
    if(calling)
    {
        _remoteAddress = calling;
    }
    UMSynchronizedSortedDictionary *info_sub = [[UMSynchronizedSortedDictionary alloc]init];
    UMSynchronizedSortedDictionary *info = [[UMSynchronizedSortedDictionary alloc]init];
    UMSynchronizedSortedDictionary *comp = [[UMSynchronizedSortedDictionary alloc]init];
    info_sub[@"invokeId"] =  @(xinvokeId);
    if(xlinkedId != TCAP_UNDEFINED_LINKED_ID)
    {
        info_sub[@"linkedId"] = @(xlinkedId);
    }

    if(param.objectName)
    {
        info_sub[param.objectName] =  param.objectValue;
    }

    if(xlast==YES)
    {
        info[@"ReturnResultLast"] = info_sub;
    }
    else
    {
        info[@"ReturnResultNotLast"] = info_sub;
    }
    if(_components==NULL)
    {
        _components = [[UMSynchronizedArray alloc]init];
    }
    comp[@"rx"] = info;
    [_components addObject:comp];
    if(_firstResponse==NULL)
    {

    }
}

- (void) sessionMAP_ReturnError_Resp:(UMASN1Object *)param
                              userId:(UMGSMMAP_UserIdentifier *)xuserIdentifier
                              dialog:(UMGSMMAP_DialogIdentifier *)xdialogId
                         transaction:(NSString *)xtcapTransactionId
                              opCode:(UMLayerGSMMAP_OpCode *)xopcode
                            invokeId:(int64_t)xinvokeId
                            linkedId:(int64_t)xlinkedId
                           errorCode:(int64_t)err
                             options:(NSDictionary *)xoptions
{
    if(_logLevel <=UMLOG_DEBUG)
    {
        [self logDebug:@"sessionMAP_ReturnError_Resp"];
    }
    [_historyLog addLogEntry:@"SS7GenericSession: sessionMAP_ReturnError_Resp"];

    VERIFY_UID(_userIdentifier,xuserIdentifier);
    VERIFY_DIALOG(_dialogId,xdialogId);
    VERIFY_SESSION(_tcapLocalTransactionId,xtcapTransactionId);
    SccpAddress *calling = xoptions[@"sccp-calling-address"];
    SccpAddress *called = xoptions[@"sccp-called-address"];
    if(called)
    {
        _localAddress = called;
    }
    if(calling)
    {
        _remoteAddress = calling;
    }

    if(_components==NULL)
    {
        _components = [[UMSynchronizedArray alloc]init];
    }
    UMSynchronizedSortedDictionary *info_sub = [[UMSynchronizedSortedDictionary alloc]init];
    UMSynchronizedSortedDictionary *info = [[UMSynchronizedSortedDictionary alloc]init];
    UMSynchronizedSortedDictionary *comp = [[UMSynchronizedSortedDictionary alloc]init];
    info_sub[@"invokeId"] =  @(xinvokeId);
    if(xlinkedId != TCAP_UNDEFINED_LINKED_ID)
    {
        info_sub[@"linkedId"] = @(xlinkedId);
    }

    if(param.objectName)
    {
        info_sub[param.objectName] =  param.objectValue;
    }
    info_sub[@"tcap-error"] =  @(err);
    NSString *errString = [UMLayerGSMMAP decodeError:(int)err];
    if(errString)
    {
        info_sub[@"error-description"] =  errString;
    }

    info[@"ReturnError"] = info_sub;
    comp[@"rx"] = info;
    [_components addObject:comp];
    [self sessionMAP_Close_Ind:xuserIdentifier options:_options];
}

- (void) sessionMAP_Reject_Resp:(UMASN1Object *)param
                         userId:(UMGSMMAP_UserIdentifier *)xuserIdentifier
                         dialog:(UMGSMMAP_DialogIdentifier *)xdialogId
                    transaction:(NSString *)xtcapTransactionId
                         opCode:(UMLayerGSMMAP_OpCode *)xopcode
                       invokeId:(int64_t)xinvokeId
                       linkedId:(int64_t)xlinkedId
                      errorCode:(int64_t)err
                        options:(NSDictionary *)xoptions
{
    if(_logLevel <=UMLOG_DEBUG)
    {
        [self logDebug:@"sessionMAP_Reject_Resp"];
    }

    [_historyLog addLogEntry:@"SS7GenericSession: sessionMAP_Reject_Resp"];

    VERIFY_UID(_userIdentifier,xuserIdentifier);
    VERIFY_DIALOG(_dialogId,xdialogId);
    VERIFY_SESSION(_tcapLocalTransactionId,xtcapTransactionId);
    SccpAddress *calling = xoptions[@"sccp-calling-address"];
    SccpAddress *called = xoptions[@"sccp-called-address"];
    if(called)
    {
        _localAddress = called;
    }
    if(calling)
    {
        _remoteAddress = calling;
    }

    UMSynchronizedSortedDictionary *info_sub = [[UMSynchronizedSortedDictionary alloc]init];
    UMSynchronizedSortedDictionary *info = [[UMSynchronizedSortedDictionary alloc]init];
    UMSynchronizedSortedDictionary *comp = [[UMSynchronizedSortedDictionary alloc]init];
    info_sub[@"invokeId"] =  @(xinvokeId);
    if(xlinkedId != TCAP_UNDEFINED_LINKED_ID)
    {
        info_sub[@"linkedId"] = @(xlinkedId);
    }

    if(param.objectName)
    {
        info_sub[param.objectName] =  param.objectValue;
    }

    info[@"Reject"] = info_sub;
    comp[@"rx"] = info;
    [_components addObject:comp];
}

- (void) sessionMAP_Close_Req:(UMGSMMAP_UserIdentifier *)xuserIdentifier
                      options:(NSDictionary *)xoptions
{
    if(_logLevel <=UMLOG_DEBUG)
    {
        [self logDebug:@"sessionMAP_Close_Req"];
    }

    VERIFY_UID(_userIdentifier,xuserIdentifier);

    SccpAddress *calling = xoptions[@"sccp-calling-address"];
    SccpAddress *called = xoptions[@"sccp-called-address"];
    if(called)
    {
        _localAddress = called;
    }
    if(calling)
    {
        _remoteAddress = calling;
    }

    [_historyLog addLogEntry:@"SS7GenericSession: sessionMAP_Close_Req"];
    [_gInstance.gsmMap queueMAP_Close_Req:_dialogId
                          callingAddress:NULL
                           calledAddress:NULL
                                 options:@{}
                                  result:NULL
                              diagnostic:NULL];
    @try
    {
        UMSynchronizedSortedDictionary *dict = [[UMSynchronizedSortedDictionary alloc]init];
        dict[@"query"] =  _query.objectValue;
        if(_query2)
        {
            dict[@"query2"] =  _query2.objectValue;
        }
        if(_query3)
        {
            dict[@"query3"] =  _query2.objectValue;
        }
        if(_firstResponse)
        {
            dict[@"first-response"] =  _firstResponse.objectValue;
        }
        if(_components)
        {
            dict[@"responses"] = _components;
        }
        else
        {
            dict[@"responses"] = [[NSArray alloc]init];
        }

        UMSynchronizedSortedDictionary *sccp_info = [[UMSynchronizedSortedDictionary alloc]init];
        if(_remoteAddress)
        {
            sccp_info[@"sccp-remote-address"] = _remoteAddress.objectValue;
        }
        if(_localAddress)
        {
            sccp_info[@"sccp-local-address"] = _localAddress.objectValue;
        }
        dict[@"sccp-info"] = sccp_info;

        if((_sccpDebugEnabled) && (xoptions[@"sccp-pdu"]))
        {
            [_sccp_received addObject:xoptions[@"sccp-pdu"]];
        }
        dict[@"user-identifier"] = _userIdentifier;
        dict[@"map-dialog-id"] = _dialogId;
        dict[@"tcap-transaction-id"] = _tcapLocalTransactionId;
        dict[@"tcap-remote-transaction-id"] = _tcapRemoteTransactionId;
        dict[@"tcap-end-indicator"] = @(YES);
        [self outputResult2:dict];
    }
    @catch(id err)
    {
        [self.logFeed majorErrorText:[NSString stringWithFormat:@"SS7GenericSession: CloseReq exception: %@",err]];
    }
    [self markForTermination];
}

#pragma mark -
#pragma mark Session Handling

- (void) sessionMAP_Open_Ind:(UMGSMMAP_UserIdentifier *)xuserIdentifier
                      dialog:(UMGSMMAP_DialogIdentifier *)xdialogId
                 transaction:(NSString *)xtcapLocalTransactionId
           remoteTransaction:(NSString *)xtcapRemoteTransactionId
                         map:(id<UMLayerGSMMAP_ProviderProtocol>)map
                     variant:(UMTCAP_Variant)xvariant
              callingAddress:(SccpAddress *)src
               calledAddress:(SccpAddress *)dst
             dialoguePortion:(UMTCAP_asn1_dialoguePortion *)xdialoguePortion
                     options:(NSDictionary *)xoptions
{
    if(_logLevel <=UMLOG_DEBUG)
    {
        [self logDebug:@"sessionMAP_Open_Ind"];
    }

    _userIdentifier = xuserIdentifier;
    _remoteAddress = src;
    _localAddress = dst;
    _startTime = [NSDate date];
    _dialogId = xdialogId;
    _tcapVariant = xvariant;
    _tcapLocalTransactionId = xtcapLocalTransactionId;
    _tcapRemoteTransactionId = xtcapRemoteTransactionId;
    _incomingOptions = xoptions;
}

- (void) sessionMAP_Open_Resp:(UMGSMMAP_UserIdentifier *)userIdentifier
                       dialog:(UMGSMMAP_DialogIdentifier *)dialogId
                  transaction:(NSString *)xtcapLocalTransactionId
            remoteTransaction:(NSString *)xtcapRemoteTransactionId
                          map:(id<UMLayerGSMMAP_ProviderProtocol>)map
                      variant:(UMTCAP_Variant)xvariant
               callingAddress:(SccpAddress *)src
                calledAddress:(SccpAddress *)dst
              dialoguePortion:(UMTCAP_asn1_dialoguePortion *)xdialoguePortion
                      options:(NSDictionary *)options
{
    if(_logLevel <=UMLOG_DEBUG)
    {
        [self logDebug:@"sessionMAP_Open_Resp"];
    }
}

-(void)sessionMAP_Delimiter_Ind:(UMGSMMAP_UserIdentifier *)xuserIdentifier
                         dialog:(UMGSMMAP_DialogIdentifier *)xdialogId
                 callingAddress:(SccpAddress *)src
                  calledAddress:(SccpAddress *)dst
                dialoguePortion:(UMTCAP_asn1_dialoguePortion *)xdialoguePortion
                  transactionId:(NSString *)xlocalTransactionId
            remoteTransactionId:(NSString *)xremoteTransactionId
                        options:(NSDictionary *)xoptions
{
    if(_logLevel <=UMLOG_DEBUG)
    {
        [self logDebug:@"sessionMAP_Delimiter_Ind"];
    }

    _localAddress = src;
    _remoteAddress = dst;

    [self touch];
    if(_hasReceivedInvokes==0)
    {
        [_components addObject:@{@"rx" : @"tcap-continue"} ];
        [_gInstance.gsmMap queueMAP_Delimiter_Req:xdialogId
                                  callingAddress:NULL
                                   calledAddress:NULL
                                         options:@{}
                                          result:NULL
                                      diagnostic:NULL];
    }
}

-(void)sessionMAP_Continue_Ind:(UMGSMMAP_UserIdentifier *)userIdentifier
                callingAddress:(SccpAddress *)src
                 calledAddress:(SccpAddress *)dst
               dialoguePortion:(UMTCAP_asn1_dialoguePortion *)xdialoguePortion
                 transactionId:(NSString *)localTransactionId
           remoteTransactionId:(NSString *)remoteTransactionId
                       options:(NSDictionary *)options
{
    if(_logLevel <=UMLOG_DEBUG)
    {
        [self logDebug:@"sessionMAP_Continue_Ind"];
    }

    _localAddress = dst;
    _remoteAddress = src;
    if(_gInstance.logLevel <= UMLOG_DEBUG)
    {
        [self logDebug:@"sessionMAP_Continue_Ind"];
    }
    [self touch];
}

-(void)sessionMAP_Unidirectional_Ind:(NSDictionary *)options
                      callingAddress:(SccpAddress *)src
                       calledAddress:(SccpAddress *)dst
                     dialoguePortion:(UMTCAP_asn1_dialoguePortion *)xdialoguePortion
                       transactionId:(NSString *)localTransactionId
                 remoteTransactionId:(NSString *)remoteTransactionId
{
    if(_gInstance.logLevel <= UMLOG_DEBUG)
    {
        [self logDebug:@"sessionMAP_Unidirectional_Ind"];
    }
    [self touch];
}


-(void)sessionMAP_Close_Ind:(UMGSMMAP_UserIdentifier *)xuserIdentifier
                    options:(NSDictionary *)xoptions
{

    if(_gInstance.logLevel <= UMLOG_DEBUG)
    {
        [self logDebug:@"sessionMAP_Close_Ind"];
    }

    SccpAddress *calling = xoptions[@"sccp-calling-address"];
    SccpAddress *called = xoptions[@"sccp-called-address"];
    if(called)
    {
        _localAddress = called;
    }
    if(calling)
    {
        _remoteAddress = calling;
    }


    [_operationMutex lock];
    UMSynchronizedSortedDictionary *dict = [[UMSynchronizedSortedDictionary alloc]init];
    @try
    {
        VERIFY_UID(_userIdentifier,xuserIdentifier);

        /* now we can finish the HTTP request */
        dict[@"query"] =  _query.objectValue;
        if(_query2)
        {
            dict[@"query2"] =  _query2.objectValue;
        }
        if(_query3)
        {
            dict[@"query3"] =  _query2.objectValue;
        }
        if(_firstResponse)
        {
            dict[@"first-response"] =  _firstResponse.objectValue;
        }
        if(_components)
        {
            dict[@"responses"] = _components;
        }
        else
        {
            dict[@"responses"] = [[NSArray alloc]init];
        }

        UMSynchronizedSortedDictionary *sccp_info = [[UMSynchronizedSortedDictionary alloc]init];
        if(_remoteAddress)
        {
            sccp_info[@"sccp-remote-address"] = _remoteAddress.objectValue;
        }
        if(_localAddress)
        {
            sccp_info[@"sccp-local-address"] = _localAddress.objectValue;
        }
        dict[@"sccp-info"] = sccp_info;

        if((_sccpDebugEnabled) && (xoptions[@"sccp-pdu"]))
        {
            [_sccp_received addObject:xoptions[@"sccp-pdu"]];
        }
        dict[@"user-identifier"] = _userIdentifier;
        dict[@"map-dialog-id"] = _dialogId;
        dict[@"tcap-transaction-id"] = _tcapLocalTransactionId;
        dict[@"tcap-remote-transaction-id"] = _tcapRemoteTransactionId;
        dict[@"tcap-end-indicator"] = @(YES);
        [self outputResult2:dict];
    }
    @catch(NSException *err)
    {
        [self logMajorError:[NSString stringWithFormat:@"Exception during sessionMAP_Close_Ind: %@",err]];
        [self outputResult2:dict];
    }
    @finally
    {
        [self markForTermination];
        [_operationMutex unlock];
    }
    [self touch];
}


- (void)markForTermination
{
    [self touch];
    if(_logLevel <= UMLOG_DEBUG)
    {
        [self logDebug:@"markForTermination"];
    }
    [_historyLog addLogEntry:@"SS7GenericSession: markForTermination"];
    [_gInstance markSessionForTermination:self];
}

- (void)outputResult2:(UMSynchronizedSortedDictionary *)dict
{
    if(_logLevel <= UMLOG_DEBUG)
    {
        [self logDebug:@"outputResult2"];
    }

    NSString *json;
    @try
    {
        json = [dict jsonString];
    }
    @catch(id err)
    {
        [self logMajorError:[NSString stringWithFormat:@"Sending U_Abort due to exception: %@",err]];
    }
    if(!json)
    {
        json = [NSString stringWithFormat:@"json-encoding problem %@",dict];
        [self logMajorError:[NSString stringWithFormat:@"json-encoding problem %@",dict]];
    }
    if(_req==NULL)
    {
        [self logMajorError:@"_req is NULL"];
    }
    [_req setResponsePlainText:json];
    [_req resumePendingRequest];
    [self touch];
}

-(void) sessionMAP_U_Abort_Req:(UMGSMMAP_UserIdentifier *)xuserIdentifier
                       options:(NSDictionary *)options
{
    if(_logLevel <= UMLOG_DEBUG)
    {
        [self logDebug:@"sessionMAP_U_Abort_Req"];
    }

    [_gInstance.gsmMap queueMAP_U_Abort_Req:_dialogId
                                   options:@{}
                                    result:NULL
                                diagnostic:NULL
                                  userInfo:NULL
                                     cause:UMTCAP_pAbortCause_badlyFormattedTransactionPortion];
    [self touch];
    [_historyLog addLogEntry:@"SS7GenericSession: sessionMAP_U_Abort_Req"];
}

-(void)sessionMAP_U_Abort_Ind:(UMGSMMAP_UserIdentifier *)xuserIdentifier
               callingAddress:(SccpAddress *)src
                calledAddress:(SccpAddress *)dst
              dialoguePortion:(UMTCAP_asn1_dialoguePortion *)xdialoguePortion
                transactionId:(NSString *)xlocalTransactionId
          remoteTransactionId:(NSString *)xremoteTransactionId
                      options:(NSDictionary *)xoptions
{
    if(_logLevel <= UMLOG_DEBUG)
    {
        [self logDebug:@"sessionMAP_U_Abort_Ind"];
    }

    [self touch];
    [_historyLog addLogEntry:@"SS7GenericSession: sessionMAP_U_Abort_Ind"];

    [_operationMutex lock];
    @try
    {
        VERIFY_UID(_userIdentifier,xuserIdentifier);
        /***/
        [self.logFeed infoText:@"sessionMAP_U_Abort_Ind"];

        /* now we can finish the HTTP request */

        UMSynchronizedSortedDictionary *dict = [[UMSynchronizedSortedDictionary alloc]init];
        dict[@"query"] =  _query.objectValue;
        if(_logLevel <= UMLOG_DEBUG)
        {
            NSString *s = [NSString stringWithFormat:@"sessionMAP_U_Abort_Ind: dialogPortion: %@ (%@)",xdialoguePortion,[xdialoguePortion className]];
            [self.logFeed infoText:s];
        }
        if(xdialoguePortion !=NULL)
        {
            if([xdialoguePortion isKindOfClass:[UMTCAP_itu_asn1_dialoguePortion class]]) /* if its a ITU dialog */
            {
                UMTCAP_itu_asn1_dialoguePortion *ituDialoguePortion = (UMTCAP_itu_asn1_dialoguePortion *)xdialoguePortion;
                if(ituDialoguePortion.dialogAbort)
                {
                    dict[@"MAP_U_Abort_Ind"] = ituDialoguePortion.dialogAbort.objectValue;
                }
            }
        }
        else
        {
            dict[@"MAP_U_Abort_Ind"] = @(YES);
        }
        /*  if(xdialoguePortion)
         {
         dict[@"dialogue-portion"] = xdialoguePortion;
         }*/
        UMSynchronizedSortedDictionary *sccp_info = [[UMSynchronizedSortedDictionary alloc]init];
        if(_remoteAddress)
        {
            sccp_info[@"sccp-remote-address"] = _remoteAddress.objectValue;
        }
        if(_localAddress)
        {
            sccp_info[@"sccp-local-address"] = _localAddress.objectValue;
        }
        dict[@"sccp-info"] = sccp_info;

        dict[@"user-identifier"] = _userIdentifier;
        dict[@"map-dialog-id"] = _dialogId;
        if(xlocalTransactionId)
        {
            if(_tcapLocalTransactionId==NULL)
            {
                _tcapLocalTransactionId = xlocalTransactionId;
            }
            dict[@"tcap-transaction-id"] = xlocalTransactionId;
        }
        if(xremoteTransactionId)
        {
            if(_tcapRemoteTransactionId==NULL)
            {
                _tcapRemoteTransactionId = xremoteTransactionId;
            }
            dict[@"tcap-remote-transaction-id"] = xremoteTransactionId;
        }
        [self outputResult2:dict];

        [self markForTermination];
    }
    @catch(NSException *err)
    {
        [self logMajorError:[NSString stringWithFormat:@"Exception during sessionMAP_U_Abort_Ind: %@",err]];
        [self markForTermination];
    }
    @finally
    {
        [_operationMutex unlock];
    }
}


-(void)sessionMAP_P_Abort_Ind:(UMGSMMAP_UserIdentifier *)xuserIdentifier
               callingAddress:(SccpAddress *)src
                calledAddress:(SccpAddress *)dst
              dialoguePortion:(UMTCAP_asn1_dialoguePortion *)xdialoguePortion
                transactionId:(NSString *)xlocalTransactionId
          remoteTransactionId:(NSString *)xremoteTransactionId
                      options:(NSDictionary *)xoptions
{
    if(_logLevel <= UMLOG_DEBUG)
    {
        [self logDebug:@"sessionMAP_P_Abort_Ind"];
    }

    [self touch];
    [_historyLog addLogEntry:@"SS7GenericSession: sessionMAP_P_Abort_Ind"];

    [_operationMutex lock];
    @try
    {
        VERIFY_UID(_userIdentifier,xuserIdentifier);
        [self.logFeed infoText:@"MAP_P_Abort_Ind"];

        /* now we can finish the HTTP request */
        UMSynchronizedSortedDictionary *dict = [[UMSynchronizedSortedDictionary alloc]init];
        if(_query)
        {
            dict[@"query"] =  _query.objectValue;
        }
        if(_query2)
        {
            dict[@"query2"] =  _query2.objectValue;
        }
        if(_query3)
        {
            dict[@"query3"] =  _query3.objectValue;
        }
        if(_components)
        {
            dict[@"MAP_P_Abort_Ind"] = _components;
        }
        else
        {
            dict[@"MAP_P_Abort_Ind"] = @"YES";
        }
        UMSynchronizedSortedDictionary *sccp_info = [[UMSynchronizedSortedDictionary alloc]init];
        if(_remoteAddress)
        {
            sccp_info[@"sccp-remote-address"] = _remoteAddress.objectValue;
        }
        if(_localAddress)
        {
            sccp_info[@"sccp-local-address"] = _localAddress.objectValue;
        }
        dict[@"sccp-info"] = sccp_info;

        dict[@"user-identifier"] = _userIdentifier;
        dict[@"map-dialog-id"] = _dialogId;
        if(xlocalTransactionId)
        {
            if(_tcapLocalTransactionId==NULL)
            {
                _tcapLocalTransactionId = xlocalTransactionId;
            }
            dict[@"tcap-transaction-id"] = xlocalTransactionId;
        }
        if(xremoteTransactionId)
        {
            if(_tcapRemoteTransactionId==NULL)
            {
                _tcapRemoteTransactionId = xremoteTransactionId;
            }
            dict[@"tcap-remote-transaction-id"] = xremoteTransactionId;
        }
        [self outputResult2:dict];
    }
    @finally
    {
        [self markForTermination];
        [_operationMutex unlock];
    }
}

-(void) sessionMAP_Notice_Ind:(UMGSMMAP_UserIdentifier *)userIdentifier
                      options:(NSDictionary *)options
{
    if(_logLevel <= UMLOG_DEBUG)
    {
        [self logDebug:@"sessionMAP_Notice_Ind(doing nothing)"];
    }

    [self touch];
    [_historyLog addLogEntry:@"SS7GenericSession: sessionMAP_Notice_Ind(doing nothing)"];
}

-(void) sessionMAP_Notice_Ind:(UMGSMMAP_UserIdentifier *)userIdentifier
            tcapTransactionId:(NSString *)localTransactionId
                       reason:(SCCP_ReturnCause)reason
                      options:(NSDictionary *)options
{
    if(_logLevel <= UMLOG_DEBUG)
    {
        [self logDebug:@"sessionMAP_Notice_Ind with reason"];
    }

    [self touch];
    [_historyLog addLogEntry:@"SS7GenericSession: sessionMAP_Notice_Ind with reason"];
    [self.logFeed infoText:@"MAP_Notice_Ind"];

    [_operationMutex lock];
    @try
    {
        [self.logFeed infoText:@"UDTS"];

        /* now we can finish the HTTP request */
        UMSynchronizedSortedDictionary *dict = [[UMSynchronizedSortedDictionary alloc]init];
        if(_query)
        {
            dict[@"query"] =  _query.objectValue;
        }
        if(_query2)
        {
            dict[@"query2"] =  _query2.objectValue;
        }
        if(_query3)
        {
            dict[@"query3"] =  _query3.objectValue;
        }

        if(_components)
        {
            dict[@"MAP_P_Abort_Ind"] = _components;
        }
        else
        {
            dict[@"MAP_P_Abort_Ind"] = @"YES";
        }
        UMSynchronizedSortedDictionary *sccp_info = [[UMSynchronizedSortedDictionary alloc]init];
        if(_remoteAddress)
        {
            sccp_info[@"sccp-remote-address"] = _remoteAddress.objectValue;
        }
        if(_localAddress)
        {
            sccp_info[@"sccp-local-address"] = _localAddress.objectValue;
        }
        sccp_info[@"sccp-reason"] = @(reason);
        sccp_info[@"sccp-reason-text"] =[UMLayerSCCP reasonString:reason];

        dict[@"sccp-info"] = sccp_info;

        dict[@"user-identifier"] = _userIdentifier;
        dict[@"map-dialog-id"] = _dialogId;
        if(localTransactionId)
        {
            if(_tcapLocalTransactionId==NULL)
            {
                _tcapLocalTransactionId = localTransactionId;
            }
            dict[@"tcap-transaction-id"] = localTransactionId;
        }
        if(_tcapRemoteTransactionId)
        {
            dict[@"tcap-remote-transaction-id"] = _tcapRemoteTransactionId;
        }
        [self outputResult2:dict];
    }
    @catch(NSException *err)
    {
        [self logMajorError:[NSString stringWithFormat:@"Exception during sessionMAP_Notice_Ind: %@",err]];
    }
    @finally
    {
        [self markForTermination];
        [_operationMutex unlock];
    }
}

#pragma mark -
#pragma mark helper methods
- (UMSynchronizedSortedDictionary *)decodeSmsObject:(NSData *)pdu
                                            context:(id)context
{
    return NULL;
}

- (void)sccpTraceSentPdu:(NSData *)data
                 options:(NSDictionary *)options
{

}

- (void)sccpTraceReceivedPdu:(NSData *)data
                     options:(NSDictionary *)options
{

}

- (void)sccpTraceDroppedPdu:(NSData *)data
                    options:(NSDictionary *)options
{
}


- (void)sccpTraceDroppedSccpPacket:(UMSCCP_Packet *)packet
                       options:(NSDictionary *)options
{
}

- (void)sccpTraceReceivedSccpPacket:(UMSCCP_Packet *)packet
                        options:(NSDictionary *)options
{
}

- (void)sccpTraceSentSccpPacket:(UMSCCP_Packet *)packet
                    options:(NSDictionary *)options
{
}




- (void) handleSccpAddressesDefaultCallingSsn:(NSString *)defaultCallingSsn
                             defaultCalledSsn:(NSString *)defaultCalledSsn
                         defaultCallingNumber:(NSString *)defaultCalling
                          defaultCalledNumber:(NSString *)defaultCalled
                      defaultCalledNumberPlan:(int)numberplan
{
    NSDictionary *p = _req.params;

    _calling_ssn     = [p[@"calling-ssn"]urldecode];
    _called_ssn      = [p[@"called-ssn"]urldecode];
    _calling_address = [p[@"calling-address"]urldecode];
    _called_address  = [p[@"called-address"]urldecode];
    _calling_tt      = [p[@"calling-tt"]urldecode];
    _called_tt       = [p[@"called-tt"]urldecode];
    _opc = [p[@"opc"]urldecode];
    _dpc = [p[@"dpc"]urldecode];
    NSString *sls_string = [p[@"sls"]urldecode];
    if(([sls_string isEqualToString:@"default"]) || (sls_string.length == 0))
    {
        _sls = -1;
    }
    else
    {
        _sls = [sls_string intValue] % 16;
    }

    if([_calling_ssn isEqualToString:@"default"])
    {
        _calling_ssn = NULL;
    }
    if([_called_ssn isEqualToString:@"default"])
    {
        _called_ssn = NULL;
    }
    if([_calling_address isEqualToString:@"default"])
    {
        _calling_address = NULL;
    }
    if([_called_address isEqualToString:@"default"])
    {
        _called_address = NULL;
    }
    if([_calling_tt isEqualToString:@"default"])
    {
        _calling_tt = NULL;
    }
    if([_called_tt isEqualToString:@"default"])
    {
        _called_tt = NULL;
    }


    if(([_opc isEqualToString:@"default"]) || (_opc.length == 0))
    {
        _opc = NULL;
    }

    if(([_dpc isEqualToString:@"default"])  || (_dpc.length == 0))
    {
        _dpc = NULL;
    }

    if(_calling_address.length > 0)
    {
        self.localAddress = [[SccpAddress alloc]initWithHumanReadableString:_calling_address variant:self.mtp3Variant];
    }
    else
    {
        self.localAddress = [[SccpAddress alloc]initWithHumanReadableString:defaultCalling variant:self.mtp3Variant];
    }
    if(_called_address.length > 0)
    {
        self.remoteAddress  = [[SccpAddress alloc]initWithHumanReadableString:_called_address variant:self.mtp3Variant];
    }
    else
    {
        self.remoteAddress  = [[SccpAddress alloc]initWithHumanReadableString:defaultCalled variant:self.mtp3Variant];
        self.remoteAddress.npi.npi = numberplan;
    }
    self.localAddress.ai.nationalReservedBit=NO;
    self.localAddress.ai.subSystemIndicator = YES;
    if((_calling_ssn == NULL) || (_calling_ssn.length <=0)  || ([_calling_ssn isEqualToString:@"default"]))
    {
        if(defaultCallingSsn.length <=0)
        {
            self.localAddress.ssn=[[SccpSubSystemNumber alloc]initWithInt:SCCP_SSN_VLR];
        }
        else
        {
            self.localAddress.ssn = [[SccpSubSystemNumber alloc]initWithName:defaultCallingSsn];
        }
    }
    else
    {
        self.localAddress.ssn=[[SccpSubSystemNumber alloc]initWithName:_calling_ssn];

    }
    self.localAddress.tt.tt = 0;


    self.remoteAddress.ai.nationalReservedBit=NO;
    self.remoteAddress.ai.globalTitleIndicator = SCCP_GTI_ITU_NAI_TT_NPI_ENCODING;
    self.remoteAddress.ai.subSystemIndicator = YES;
    self.remoteAddress.ssn.ssn=SCCP_SSN_HLR;
    if((_called_ssn == NULL) || (_called_ssn.length <=0)  || ([_called_ssn isEqualToString:@"default"]))
    {
        if(defaultCalledSsn.length <=0)
        {
            self.remoteAddress.ssn = [[SccpSubSystemNumber alloc]initWithInt:SCCP_SSN_HLR];
        }
        else
        {
            self.remoteAddress.ssn = [[SccpSubSystemNumber alloc]initWithName:defaultCalledSsn];
        }
    }
    else
    {
        self.remoteAddress.ssn=[[SccpSubSystemNumber alloc]initWithName:_called_ssn];
    }
    if(_calling_tt.length > 0)
    {
        self.localAddress.tt = [[SccpTranslationTableNumber alloc]initWithInt:[_calling_tt intValue]];
    }
    else
    {
        self.localAddress.tt = [[SccpTranslationTableNumber alloc]initWithInt:0];
    }
    if(_called_tt.length > 0)
    {
        self.remoteAddress.tt = [[SccpTranslationTableNumber alloc]initWithInt:[_called_tt intValue]];
    }
    else
    {
        self.remoteAddress.tt = [[SccpTranslationTableNumber alloc]initWithInt:0];
    }
}

- (void)setDefaultApplicationContext:(NSString *)def
{
    NSDictionary *p = _req.params;
	if(def.length == 0)
	{
		def = NULL;
	}
    NSString *context = def;
    if (p[@"application-context"])
    {
        context = [p[@"application-context"] stringValue];
    }
    else if([context length]==0)
    {
        context =  NULL;
    }
    else if([context isEqualToString:@"default"])
    {
        context = def;
    }
	if(context.length > 0)
	{
    	_applicationContext =  [[UMTCAP_asn1_objectIdentifier alloc]initWithString:context];
	}
	else
	{
		_applicationContext = NULL;
	}
}

- (void)setUserInfo_MAP_Open
{
    NSDictionary *p = _req.params;

    NSString *mapopen_origination_imsi;
    NSString *mapopen_origination_msisdn;
    NSString *mapopen_destination_imsi;
    NSString *mapopen_destination_msisdn;

    SET_OPTIONAL_CLEAN_PARAMETER(p,mapopen_destination_imsi,@"map-open-destination-imsi");
    SET_OPTIONAL_CLEAN_PARAMETER(p,mapopen_destination_msisdn,@"map-open-destination-msisdn");

    SET_OPTIONAL_CLEAN_PARAMETER(p,mapopen_origination_imsi,@"map-open-origination-imsi");
    SET_OPTIONAL_CLEAN_PARAMETER(p,mapopen_origination_msisdn,@"map-open-origination-msisdn");

    /** MAP OPEN **/
    _userInfo = [[UMTCAP_asn1_userInformation alloc]init];

    UMTCAP_asn1_external *e = [[UMTCAP_asn1_external alloc]init];
    e.objectIdentifier = [[UMTCAP_asn1_objectIdentifier alloc]initWithString:@"04000001010101"];

    if((mapopen_destination_imsi.length == 0) &&
       (mapopen_destination_msisdn.length == 0) &&
       (mapopen_origination_imsi.length == 0) &&
       (mapopen_origination_msisdn.length == 0))

    {
        _userInfo = NULL;
    }

    UMGSMMAP_MAP_OpenInfo *map_open = [[UMGSMMAP_MAP_OpenInfo alloc]init];
    if(mapopen_destination_imsi.length>0)
    {
        map_open.destinationReference = [[UMGSMMAP_AddressString alloc]initWithImsi:mapopen_destination_imsi];
    }
    else if(mapopen_destination_msisdn.length>0)
    {
        map_open.destinationReference = [[UMGSMMAP_AddressString alloc]initWithMsisdn:mapopen_destination_msisdn];
    }

    if(mapopen_origination_imsi.length>0)
    {
        map_open.originationReference = [[UMGSMMAP_AddressString alloc]initWithImsi:mapopen_origination_imsi];
    }
    else if(mapopen_origination_msisdn.length>0)
    {
        map_open.originationReference = [[UMGSMMAP_AddressString alloc]initWithMsisdn:mapopen_origination_msisdn];
    }
    e.externalObject = map_open;
    [_userInfo addIdentification:e];
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

    if (p[@"keep-sccp-calling-addr"])
    {
        if([p[@"keep-sccp-calling-addr"] boolValue])
        {
            _options[@"keep-sccp-calling-addr"] = @(YES);
            _keepOriginalSccpAddressForTcapContinue=YES;
        }
    }

    if (p[@"tcap-handshake"])
    {
        if([p[@"tcap-handshake"] boolValue])
        {
            _options[@"tcap-handshake"] = @(YES);
        }
    }
    if (p[@"sccp-xudt"])
    {
        if([p[@"sccp-xudt"] boolValue])
        {
            _options[@"sccp-xudt"] = @(YES);
        }
    }
    if (p[@"sccp-segment"])
    {
        if([p[@"sccp-segment"] boolValue])
        {
            _options[@"sccp-segment"] = @(YES);
        }
    }
    if (p[@"invoke-count"])
    {
        int i = [p[@"invoke-count"] intValue];
        _options[@"invoke-count"] = @(i);
    }

    if(_opc)
    {
        _options[@"opc"] = _opc;
    }

    if(_dpc)
    {
        _options[@"dpc"] = _dpc;
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
    if(_opc)
    {
        _options[@"opc"] = _opc;
    }
    if(_dpc)
    {
        _options[@"dpc"] = _dpc;
    }
    if(_sls>=0)
    {
        _options[@"mtp3-sls"] = [NSString stringWithFormat:@"%d",_sls];
    }

    _dialogId =  [_gInstance.gsmMap executeMAP_Open_Req_forUser:_gInstance
                                                      variant:TCAP_VARIANT_DEFAULT
                                               callingAddress:_localAddress
                                                calledAddress:_remoteAddress
                                           applicationContext:_applicationContext
                                                     userInfo:_userInfo
                                               userIdentifier:_userIdentifier
                                                      options:_options];
    [_gInstance addSession:self userId:_userIdentifier];
    BOOL useHandshake = [_options[@"tcap-handshake"] boolValue];

    if(useHandshake)
    {
        [_gInstance.gsmMap executeMAP_Delimiter_Req:_dialogId
                                    callingAddress:NULL
                                     calledAddress:NULL
                                           options:_options
                                            result:NULL
                                        diagnostic:NULL];
    }

    if((_firstInvokeOpcode) && (_firstInvoke))
    {
        [_gInstance.gsmMap executeMAP_Invoke_Req:_firstInvoke
                                         dialog:_dialogId
                                       invokeId:AUTO_ASSIGN_INVOKE_ID
                                       linkedId:TCAP_UNDEFINED_LINKED_ID
                                         opCode:_firstInvokeOpcode
                                           last:YES
                                        options:_options];
    }

    if((_firstResponseOpcode) && (_firstResponse))
    {
        [_gInstance.gsmMap executeMAP_ReturnResult_Req:_firstResponse
                                               dialog:_dialogId
                                             invokeId:AUTO_ASSIGN_INVOKE_ID
                                             linkedId:TCAP_UNDEFINED_LINKED_ID
                                               opCode:_firstResponseOpcode
                                                 last:YES
                                              options:_options];
    }
    [_gInstance.gsmMap executeMAP_Invoke_Req:_query
                                     dialog:_dialogId
                                   invokeId:AUTO_ASSIGN_INVOKE_ID
                                   linkedId:TCAP_UNDEFINED_LINKED_ID
                                     opCode:_opcode
                                       last:YES
                                    options:_options];
    if(_query2)
    {
        [_gInstance.gsmMap executeMAP_Invoke_Req:_query2
                                         dialog:_dialogId
                                       invokeId:AUTO_ASSIGN_INVOKE_ID
                                       linkedId:TCAP_UNDEFINED_LINKED_ID
                                         opCode:_opcode2
                                           last:YES
                                        options:_options];

    }
    if(_query3)
    {
        [_gInstance.gsmMap executeMAP_Invoke_Req:_query3
                                         dialog:_dialogId
                                       invokeId:AUTO_ASSIGN_INVOKE_ID
                                       linkedId:TCAP_UNDEFINED_LINKED_ID
                                         opCode:_opcode3
                                           last:YES
                                        options:_options];

    }

    if(!useHandshake)
    {
        [_gInstance.gsmMap executeMAP_Delimiter_Req:_dialogId
                                    callingAddress:NULL
                                     calledAddress:NULL
                                           options:_options
                                            result:NULL
                                        diagnostic:NULL];
    }
}

- (void)submitApplicationContextTest
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
    if(_options==NULL)
    {

    }
    _dialogId =  [_gInstance.gsmMap executeMAP_Open_Req_forUser:_gInstance
                                                      variant:TCAP_VARIANT_DEFAULT
                                               callingAddress:_localAddress
                                                calledAddress:_remoteAddress
                                           applicationContext:_applicationContext
                                                     userInfo:_userInfo
                                               userIdentifier:_userIdentifier
                                                      options:_options];
    [_gInstance addSession:self userId:_userIdentifier];

    [_gInstance.gsmMap executeMAP_Delimiter_Req:_dialogId
                                callingAddress:NULL
                                 calledAddress:NULL
                                       options:_options
                                        result:NULL
                                    diagnostic:NULL];
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
    [s appendFormat:@"\tdialogId: %@\n",_dialogId];
    [s appendFormat:@"\ttcapLocalTransactionId: %@\n",_tcapLocalTransactionId];
    [s appendFormat:@"\ttcapRemoteTransactionId: %@\n",_tcapRemoteTransactionId];
    [s appendFormat:@"\tgInstance: '%@'\n",_gInstance.layerName];
    [s appendFormat:@"\topcode %d\n",(int)_opcode.operation];
    [s appendFormat:@"\tlocalAddress %@\n",_localAddress.description];
    [s appendFormat:@"\tremoteAddress %@\n",_remoteAddress.description];
    [s appendFormat:@"\tinitialLocalAddress %@\n",_initialLocalAddress.description];
    [s appendFormat:@"\tinitialRemoteAddress %@\n",_initialRemoteAddress.description];
    [s appendFormat:@"\thttp request %p\n",_req];
    [s appendFormat:@"\tundefinedSession %@\n",_undefinedSession ? @"YES" : @"NO"];
    [s appendFormat:@"}\n"];
    return s;
}


- (void)logWebSession
{
    if(_gInstance.logLevel <= UMLOG_DEBUG)
    {
        NSString *s = [NSString stringWithFormat:@"%@[%@]: %@",_sessionName,_userIdentifier,_req.params ];
        [_gInstance logDebug:s];
    }
}

- (void)logDebug:(NSString *)str
{
    if(_gInstance.logLevel <= UMLOG_DEBUG)
    {
        NSString *s = [NSString stringWithFormat:@"%@[%@]: %@",_sessionName,_userIdentifier,str];
        [_gInstance logDebug:s];
    }
}

- (void)logInfo:(NSString *)str
{
    if(_gInstance.logLevel <= UMLOG_DEBUG)
    {
        NSString *s = [NSString stringWithFormat:@"%@[%@]: %@",_sessionName,_userIdentifier,str];
        [_gInstance logInfo:s];
    }
}

- (void)logMajorError:(NSString *)str
{
    if(_gInstance.logLevel <= UMLOG_MAJOR)
    {
        NSString *s = [NSString stringWithFormat:@"%@[%@]: %@",_sessionName,_userIdentifier,str];
        [_gInstance logMajorError:s];
    }
}

- (void)logMinorError:(NSString *)str
{
    if(_gInstance.logLevel <= UMLOG_MINOR)
    {
        NSString *s = [NSString stringWithFormat:@"%@[%@]: %@",_sessionName,_userIdentifier,str];
        [_gInstance logMinorError:s];
    }
}

+ (void)webFormStart:(NSMutableString *)s title:(NSString *)t
{
    [SS7GenericInstance webHeader:s title:t];
    [s appendString:@"\n"];
    [s appendString:@"<a href=\"index.php\">menu</a>\n"];
    [s appendFormat:@"<h2>%@</h2>\n",t];
    [s appendString:@"<form method=\"get\">\n"];
    [s appendString:@"<table>\n"];

}

+ (void)webFormEnd:(NSMutableString *)s
{
    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td>&nbsp</td>\n"];
    [s appendString:@"    <td><input type=submit></td>\n"];
    [s appendString:@"</tr>\n"];
    [s appendString:@"</table>\n"];
    [s appendString:@"</form>\n"];
    [s appendString:@"</body>\n"];
    [s appendString:@"</html>\n"];
    [s appendString:@"\n"];
}

+ (void)webMapTitle:(NSMutableString *)s
{
    [s appendString:@"<tr><td colspan=2 class=subtitle>GSMMAP Parameters:</td></tr>\n"];
}

+ (void)webDialogTitle:(NSMutableString *)s
{
    [s appendString:@"<tr><td colspan=2 class=subtitle>Dialogue Parameters:</td></tr>\n"];
}

+ (void)webDialogOptions:(NSMutableString *)s
{
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
}

+ (void)webTcapTitle:(NSMutableString *)s
{
    [s appendString:@"<tr><td colspan=2 class=subtitle>TCAP Parameters:</td></tr>\n"];
}

+ (void)webVariousTitle:(NSMutableString *)s
{
    [s appendString:@"<tr><td colspan=2 class=subtitle>Various Extensions:</td></tr>\n"];
}

+ (void)webTcapOptions:(NSMutableString *)s
            appContext:(NSString *)ac
        appContextName:(NSString *)acn
{
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
}

+ (void)webSccpTitle:(NSMutableString *)s
{
    [s appendString:@"<tr><td colspan=2 class=subtitle>SCCP Parameters:</td></tr>\n"];
}

+ (void)webSccpOptions:(NSMutableString *)s
        callingComment:(NSString *)callingComment
         calledComment:(NSString *)calledComment
            callingSSN:(NSString *)callingSSN
             calledSSN:(NSString *)calledSSN
{
    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>calling-address</td>\n"];
    [s appendFormat:@"    <td class=optional><input name=\"calling-address\" type=\"text\" placeholder=\"+12345678\" value=\"default\"> %@</td>\n",callingComment];
    [s appendString:@"</tr>\n"];
    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>called-address</td>\n"];
    [s appendFormat:@"    <td class=optional><input name=\"called-address\" type=\"text\" placeholder=\"+12345678\" value=\"default\"> %@</td>\n",calledComment];
    [s appendString:@"</tr>\n"];
    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>calling-ssn</td>\n"];
    [s appendFormat:@"    <td class=optional><input name=\"calling-ssn\" type=\"text\" value=\"%@\"></td>\n",callingSSN];
    [s appendString:@"</tr>\n"];
    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>called-ssn</td>\n"];
    [s appendFormat:@"    <td class=optional><input name=\"called-ssn\" type=\"text\" value=\"%@\"></td>\n",calledSSN];
    [s appendString:@"</tr>\n"];
    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>calling-tt</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"calling-tt\" type=\"text\" value=\"0\"></td>\n"];
    [s appendString:@"</tr>\n"];
    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>called-tt</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"called-tt\" type=\"text\" value=\"0\"></td>\n"];
    [s appendString:@"</tr>\n"];
}

+ (void)webMtp3Title:(NSMutableString *)s
{
    [s appendString:@"<tr><td colspan=2 class=subtitle>MTP3 Parameters:</td></tr>\n"];
}

+ (void)webMtp3Options:(NSMutableString *)s
{
    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>opc</td>\n"];
    [s appendFormat:@"    <td class=optional><input name=\"opc\" type=\"text\" placeholder=\"0-000-0\" value=\"default\">originating pointcode</td>\n"];
    [s appendString:@"</tr>\n"];
    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>dpc</td>\n"];
    [s appendFormat:@"    <td class=optional><input name=\"dpc\" type=\"text\" placeholder=\"0-000-0\" value=\"default\">destination pointcode</td>\n"];
    [s appendString:@"</tr>\n"];
    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>sls</td>\n"];
    [s appendFormat:@"    <td class=optional><input name=\"sls\" type=\"text\" placeholder=\"0..15\" value=\"default\">SLS</td>\n"];
    [s appendString:@"</tr>\n"];
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
    [self logInfo:@"timeout"];
    if(_logLevel <=UMLOG_DEBUG)
    {
        [self logDebug:@"timeout"];
    }

    [_historyLog addLogEntry:@"timeout"];
    [self abort];
    [self writeTraceToDirectory:_gInstance.timeoutTraceDirectory];

    UMSynchronizedSortedDictionary *dict = [[UMSynchronizedSortedDictionary alloc]init];
    dict[@"query"] =  _query.objectValue;
    dict[@"timeout"] = @(YES);

    UMSynchronizedSortedDictionary *sccp_info = [[UMSynchronizedSortedDictionary alloc]init];
    if(_remoteAddress)
    {
        sccp_info[@"sccp-remote-address"] = _remoteAddress.objectValue;
    }
    if(_localAddress)
    {
        sccp_info[@"sccp-local-address"] = _localAddress.objectValue;
    }
    dict[@"sccp-info"] = sccp_info;
    dict[@"user-identifier"] = _userIdentifier;
    dict[@"map-dialog-id"] = _dialogId;

    [_operationMutex lock];
    [self outputResult2:dict];
    [self markForTermination];
    [_operationMutex unlock];
}


- (void)writeTraceToDirectory:(NSString *)dir
{
    if(dir)
    {
        NSString *filename = [NSString stringWithFormat:@"%@/%@-%@-%@", dir, _sessionName,
                              _tcapLocalTransactionId, (_tcapRemoteTransactionId ? _tcapRemoteTransactionId : @"none") ];


        NSMutableString *s = [[NSMutableString alloc]init];

        [s appendFormat:@"UserIdentifier: %@\n",_userIdentifier];
        [s appendFormat:@"hasEnded: %@\n",(_hasEnded ? @"YES" : @"NO")];
        [s appendFormat:@"Opcode: %@\n",[_opcode description]];
        [s appendFormat:@"LocalSCCPAddress: %@\n",[_localAddress description]];
        [s appendFormat:@"RemoteSCCPAddress: %@\n",[_remoteAddress description]];
        [s appendFormat:@"StartTime: %@\n",[_startTime description]];
        [s appendFormat:@"LastActive: %@\n",[_lastActiveTime description]];
        [s appendFormat:@"Now: %@\n",[[NSDate date] description]];
        [s appendFormat:@"incomingApplicationContext: %@\n",_incomingApplicationContext];
        [s appendFormat:@"HistoryLog: %@\n",[_historyLog getLogForwardOrder]];


        NSData *data = [s dataUsingEncoding:NSUTF8StringEncoding];
        int fd = open(filename.UTF8String,O_CREAT | O_SYNC | O_WRONLY | O_APPEND,0644);
        if(fd>=0)
        {
            ssize_t bytesWritten = write(fd,(const void *)data.bytes,(ssize_t)data.length);
            if(bytesWritten != (ssize_t)data.length)
            {
                NSLog(@"can not write all data to tracefile %@ Error %d %s",filename,errno,strerror(errno));
            }
        }
        else
        {
            NSLog(@"can not write to tracefile %@. Error %d %s",filename,errno,strerror(errno));
        }
        close(fd);
    }
}

- (void)abortUnknown
{
    if(_logLevel <=UMLOG_DEBUG)
    {
        [self logDebug:@"SS7GenericSession: abortUnknown"];
    }
    [_historyLog addLogEntry:@"SS7GenericSession: abortUnknown"];

    @try
    {
        UMTCAP_asn1_Associate_result *r = [[UMTCAP_asn1_Associate_result alloc]initWithValue:0];
        UMTCAP_asn1_Associate_source_diagnostic *d = [[UMTCAP_asn1_Associate_source_diagnostic alloc]init];
        d.dialogue_service_user =[[UMASN1Integer alloc]initWithValue:0];
        [_gInstance.gsmMap queueMAP_U_Abort_Req:_dialogId
                                       options:@{}
                                        result:r
                                    diagnostic:d
                                      userInfo:NULL
                                         cause:UMTCAP_pAbortCause_unrecognizedMessageType];
        [_gInstance markSessionForTermination:self];
        _hasEnded = YES;
    }
    @catch(NSException *e)
    {
        NSString *s = [NSString stringWithFormat:@"Exception: %@",e.description];
        if(_logLevel <=UMLOG_DEBUG)
        {
            [self logDebug:s];
        }
        [_historyLog addLogEntry:s];
    }
    [_historyLog addLogEntry:@"abort"];
}

- (void)abort
{
    if(_logLevel <=UMLOG_DEBUG)
    {
        [self logDebug:@"SS7GenericSession: abort"];
    }
    [_historyLog addLogEntry:@"SS7GenericSession: abort"];

    @try
    {
        UMTCAP_asn1_Associate_result *r = [[UMTCAP_asn1_Associate_result alloc]initWithValue:0];
        UMTCAP_asn1_Associate_source_diagnostic *d = [[UMTCAP_asn1_Associate_source_diagnostic alloc]init];
        d.dialogue_service_user =[[UMASN1Integer alloc]initWithValue:0];
        [_gInstance.gsmMap queueMAP_U_Abort_Req:_dialogId
                                       options:@{}
                                        result:r
                                    diagnostic:d
                                      userInfo:NULL
                                         cause:UMTCAP_pAbortCause_badlyFormattedTransactionPortion];
        [_gInstance markSessionForTermination:self];
        _hasEnded = YES;
    }
    @catch(NSException *e)
    {
        NSString *s = [NSString stringWithFormat:@"Exception: %@",e.description];
        if(_logLevel <=UMLOG_DEBUG)
        {
            [self logDebug:s];
        }
        [_historyLog addLogEntry:s];
    }
    [_historyLog addLogEntry:@"abort"];
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

- (void)dump:(NSFileHandle *)filehandler
{
    NSMutableString *s = [[NSMutableString alloc]init];
    [s appendFormat:@"    userIdentifier: %@\n",_userIdentifier];
    [s appendFormat:@"    hasEnded: %@\n",(_hasEnded ? @"YES" : @"NO")];
    [s appendFormat:@"    opcode: %@\n",_opcode.description];
    [s appendFormat:@"    localAddress: %@\n",[_localAddress description]];
    [s appendFormat:@"    remoteAddress: %@\n",[_remoteAddress description]];
    [s appendFormat:@"    startTime: %@\n",[_startTime description]];
    [s appendFormat:@"    lastActive: %@\n",[_lastActiveTime description]];
    [s appendFormat:@"    timeout: %8.2lfs\n",_timeoutInSeconds];
    NSDictionary *d = [_applicationContext objectValue];
    [s appendFormat:@"    applicationContext: %@\n",d[@"objectIdentifier"]];
    d = [_incomingApplicationContext objectValue];
    [s appendFormat:@"    incomingApplicationContext: %@\n",d[@"objectIdentifier"]];
    [s appendFormat:@"    doEnd: %@\n",(_doEnd ? @"YES" : @"NO")];
    [s appendFormat:@"    nowait: %@\n",(_nowait ? @"YES" : @"NO")];
    [s appendFormat:@"    undefinedSession: %@\n",(_undefinedSession ? @"YES" : @"NO")];
    [s appendFormat:@"    tcapLocalTransactionId: %@\n",_tcapLocalTransactionId];
    [s appendFormat:@"    tcapRemoteTransactionId: %@\n",_tcapRemoteTransactionId];
    [s appendFormat:@"    sessionName: %@\n",_sessionName];
    [s appendFormat:@"    firstInvokeId: %d\n",_firstInvokeId];
    [s appendFormat:@"    mapVersion: %d\n",_mapVersion];
    [s appendFormat:@"    incoming: %@\n",(_incoming ? @"YES" : @"NO")];
    [s appendFormat:@"    outgoing: %@\n",(_outgoing ? @"YES" : @"NO")];

    [filehandler writeData: [@"-- history log: --\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [filehandler writeData: [s dataUsingEncoding:NSUTF8StringEncoding]];
    [filehandler writeData: [[_historyLog getLogForwardOrder]dataUsingEncoding:NSUTF8StringEncoding]];
    [filehandler writeData: [@"\n-- end of history log --\n" dataUsingEncoding:NSUTF8StringEncoding]];
}

@end


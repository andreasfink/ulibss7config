//
//  SS7GenericInstance.m
//  ulibss7config
//
//  Created by Andreas Fink on 20.11.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//


#import "SS7GenericInstance.h"
#import "SS7GenericSession.h"
#import "SS7GenericInstance_MAP_Invoke_Ind_Task.h"
#import "SS7GenericInstance_MAP_ReturnResult_Resp_Task.h"
#import "SS7GenericInstance_MAP_ReturnError_Resp_Task.h"
#import "SS7GenericInstance_MAP_Reject_Resp_Task.h"
#import "SS7GenericInstance_MAP_Open_Ind_Task.h"
#import "SS7GenericInstance_MAP_Open_Resp_Task.h"
#import "SS7GenericInstance_MAP_Delimiter_Ind_Task.h"
#import "SS7GenericInstance_MAP_Continue_Ind_Task.h"
#import "SS7GenericInstance_MAP_Unidirectional_Ind_Task.h"
#import "SS7GenericInstance_MAP_Close_Ind_Task.h"
#import "SS7GenericInstance_MAP_U_Abort_Ind_Task.h"
#import "SS7GenericInstance_MAP_P_Abort_Ind_Task.h"
#import "SS7GenericInstance_MAP_Notice_Ind_Task.h"
#import <ulibsms/ulibsms.h>

#include <sys/stat.h>

@implementation SS7GenericInstance

- (void) genericInitialisation
{
    _sessions = [[UMSynchronizedDictionary alloc]init];
    _delayedDestroy1 = [[NSMutableArray alloc]init];
    _delayedDestroy2 = [[NSMutableArray alloc]init];
    _delayedDestroy3 = [[NSMutableArray alloc]init];
    _timeoutInSeconds = 80;
    _operationMutex = [[UMMutex alloc]initWithName:@"SS7GenericInstance_operationMutext"];
    _uidMutex = [[UMMutex alloc]initWithName:@"SS7GenericInstance_uidMutex"];
    _housekeeping_lock = [[UMMutex alloc]initWithName:@"SS7GenericInstance_housekeepingLock"];
    _houseKeepingTimerRun = [[UMAtomicDate alloc]init];
    _houseKeepingTimer = [[UMTimer alloc]initWithTarget:self
                                               selector:@selector(housekeeping)
                                                 object:NULL
                                                seconds:2.2
                                                   name:@"housekeeping"
                                                repeats:YES
                                        runInForeground:NO];
    [_houseKeepingTimer start];
}

- (SS7GenericInstance *)initWithNumber:(NSString *)xmscAddress
{
    self = [super init];
    if(self)
    {
        _instanceAddress = xmscAddress;
        [self genericInitialisation];
    }
    return self;
}

- (NSUInteger)sessionsCount
{
    UMAssert(_sessions!=NULL,@"_sessions is null");
    return _sessions.count;
}

- (SS7GenericInstance *)init
{
    self = [super init];
    if(self)
    {
        _sessions = [[UMSynchronizedDictionary alloc]init];
        [self genericInitialisation];
    }
    return self;
}

- (SS7GenericInstance *)initWithTaskQueueMulti:(UMTaskQueueMulti *)tq
{
    
    return [self initWithTaskQueueMulti:tq name:@"genetic-ss7-instance"];
}

- (SS7GenericInstance *)initWithTaskQueueMulti:(UMTaskQueueMulti *)tq name:(NSString *)name
{
    self = [super initWithTaskQueueMulti:tq name:name];
    if(self)
    {
        _sessions = [[UMSynchronizedDictionary alloc]init];
        _timeoutInSeconds = 80;
        _operationMutex = [[UMMutex alloc]initWithName:@"SS7GenericInstance_operationMutex"];
        _uidMutex = [[UMMutex alloc]initWithName:@"SS7GenericInstance_uidMutex"];
        _houseKeepingTimerRun = [[UMAtomicDate alloc]init];
        _houseKeepingTimer = [[UMTimer alloc]initWithTarget:self
                                                   selector:@selector(housekeeping)
                                                     object:NULL
                                                    seconds:1.1 /* every sec */
                                                       name:@"housekeeping"
                                                    repeats:YES
                                            runInForeground:NO];
        [self genericInitialisation];
        [_houseKeepingTimer start];
    }
    return self;
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
            int r = mkdir(_timeoutTraceDirectory.UTF8String,0755);
            if(r<0)
            {
                if (errno!=EEXIST)
                {
                    fprintf(stderr,"Error %d %s: Can not create timeout-trace-directory '%s'\n",errno,strerror(errno),_timeoutTraceDirectory.UTF8String);
                    exit(-1);
                }
            }
        }
    }

    if(cfg[@"full-trace-directory"])
    {
        _genericTraceDirectory = [cfg[@"full-trace-directory"]stringValue];

        NSLog(@"adding full trace for %@ to %@", [self layerName],_genericTraceDirectory);

        if(_genericTraceDirectory.length > 0)
        {
            int r = mkdir(_genericTraceDirectory.UTF8String,0755);
            if(r<0)
            {
                if (errno!=EEXIST)
                {
                    fprintf(stderr,"Error %d %s: Can not create full-trace-directory '%s'\n",errno,strerror(errno),_genericTraceDirectory.UTF8String);
                    exit(-1);
                }
            }
        }
    }

}

- (void)startUp
{
}

- (NSString *)instancePrefix
{
    return @"G";
}

- (UMCamelUserIdentifier *)getNewCamelUserIdentifier
{
    NSString *uidstr;
    int64_t uid;
    static int64_t lastUserId = 1;

    [_uidMutex lock];
    lastUserId = (lastUserId + 1 ) % 0x7FFFFFFF;
    uid = lastUserId;
    [_uidMutex unlock];
    uidstr =  [NSString stringWithFormat:@"%@%08llX",self.instancePrefix,(long long)uid];
    return  [[UMCamelUserIdentifier alloc]initWithString:uidstr];
}

- (UMGSMMAP_UserIdentifier *)getNewUserIdentifier
{
    NSString *uidstr;
    int64_t uid;
    static int64_t lastUserId = 1;

    [_uidMutex lock];
    lastUserId = (lastUserId + 1 ) % 0x7FFFFFFF;
    uid = lastUserId;
    [_uidMutex unlock];
    uidstr =  [NSString stringWithFormat:@"%@%08llX",self.instancePrefix,(long long)uid];

    return  [[UMGSMMAP_UserIdentifier alloc]initWithString:uidstr];;
}

- (SS7GenericSession *)sessionById:(UMGSMMAP_UserIdentifier *)userId
{
    UMAssert(_sessions!=NULL,@"Can not find session. _sessions is null");
    return _sessions[userId.userIdentifier];
}

- (SS7GenericSession *)sessionByCamelId:(UMCamelUserIdentifier *)userId;
{
    UMAssert(_sessions!=NULL,@"Can not find session. _sessions is null");
    return _sessions[userId.userIdentifier];
}


- (void)addSession:(SS7GenericSession *)t userId:(UMGSMMAP_UserIdentifier *)uidstr
{
    UMAssert(_sessions!=NULL,@"Can not add session. _sessions is null");
    UMAssert(uidstr!=NULL,@"Can not add session. uidstr is null");
    UMAssert(t!=NULL,@"Can not add session. t is null");
    _sessions[uidstr.userIdentifier] = t;
}


- (void) markSessionForTermination:(SS7GenericSession *)t reason:(NSString *)reason
{
    [t.historyLog addLogEntry:@"markSessionForTermination"];
    t.hasEnded = YES;
    t.hasEndedReason = reason;
    t.hasEndedTime = [NSDate date];
    if(_genericTraceDirectory)
    {
        [t writeTraceToDirectory:_genericTraceDirectory];
    }
    /* the session is removed by the housekeeping instance */
}

#pragma mark -
#pragma mark handle incoming components and make tasks of it

-(void) queueMAP_Invoke_Ind:(UMASN1Object *)param
                     userId:(UMGSMMAP_UserIdentifier *)userIdentifier
                     dialog:(UMGSMMAP_DialogIdentifier *)dialogId
                transaction:(NSString *)transactionId
                     opCode:(UMLayerGSMMAP_OpCode *)opcode
                   invokeId:(int64_t)invokeId
                   linkedId:(int64_t)linkedId
                       last:(BOOL)last
                    options:(NSDictionary *)options
{
    SS7GenericInstance_MAP_Invoke_Ind_Task *task = [[SS7GenericInstance_MAP_Invoke_Ind_Task alloc]initWithInstance:self
                                                                                                       param:param
                                                                                                      userId:userIdentifier
                                                                                                      dialog:dialogId
                                                                                                 transaction:transactionId
                                                                                                      opCode:opcode
                                                                                                    invokeId:invokeId
                                                                                                    linkedId:linkedId
                                                                                                        last:last
                                                                                                     options:options];
    [self queueFromLower:task];
}

-(void) queueMAP_ReturnResult_Resp:(UMASN1Object *)param
                            userId:(UMGSMMAP_UserIdentifier *)userIdentifier
                            dialog:(UMGSMMAP_DialogIdentifier *)dialogId
                       transaction:(NSString *)transactionId
                            opCode:(UMLayerGSMMAP_OpCode *)opcode
                          invokeId:(int64_t)invokeId
                          linkedId:(int64_t)linkedId
                              last:(BOOL)last
                           options:(NSDictionary *)options
{
    SS7GenericInstance_MAP_ReturnResult_Resp_Task *task = [[SS7GenericInstance_MAP_ReturnResult_Resp_Task alloc]initWithInstance:self
                                                                                                                     param:param
                                                                                                                    userId:userIdentifier
                                                                                                                    dialog:dialogId
                                                                                                               transaction:transactionId
                                                                                                                    opCode:opcode
                                                                                                                  invokeId:invokeId
                                                                                                                  linkedId:linkedId
                                                                                                                      last:last
                                                                                                                   options:options];
    [self queueFromLower:task];
}

- (void) queueMAP_ReturnError_Resp:(UMASN1Object *)param
                            userId:(UMGSMMAP_UserIdentifier *)userIdentifier
                            dialog:(UMGSMMAP_DialogIdentifier *)dialogId
                       transaction:(NSString *)transactionId
                            opCode:(UMLayerGSMMAP_OpCode *)opcode
                          invokeId:(int64_t)invokeId
                          linkedId:(int64_t)linkedId
                         errorCode:(int64_t)errorCode
                           options:(NSDictionary *)options
{
    SS7GenericInstance_MAP_ReturnError_Resp_Task *task = [[SS7GenericInstance_MAP_ReturnError_Resp_Task alloc]initWithInstance:self
                                                                                                                   param:param
                                                                                                                  userId:userIdentifier
                                                                                                                  dialog:dialogId
                                                                                                             transaction:transactionId
                                                                                                                  opCode:opcode
                                                                                                                invokeId:invokeId
                                                                                                                linkedId:linkedId
                                                                                                               errorCode:errorCode
                                                                                                                 options:options];
    [self queueFromLower:task];
}


- (void) queueMAP_Reject_Resp:(UMASN1Object *)param
                       userId:(UMGSMMAP_UserIdentifier *)userIdentifier
                       dialog:(UMGSMMAP_DialogIdentifier *)dialogId
                  transaction:(NSString *)transactionId
                       opCode:(UMLayerGSMMAP_OpCode *)opcode
                     invokeId:(int64_t)invokeId
                     linkedId:(int64_t)linkedId
                    errorCode:(int64_t)errorCode
                      options:(NSDictionary *)options
{
    SS7GenericInstance_MAP_Reject_Resp_Task *task = [[SS7GenericInstance_MAP_Reject_Resp_Task alloc]initWithInstance:self
                                                                                                         param:param
                                                                                                        userId:userIdentifier
                                                                                                        dialog:dialogId
                                                                                                   transaction:transactionId
                                                                                                        opCode:opcode
                                                                                                      invokeId:invokeId
                                                                                                      linkedId:linkedId
                                                                                                     errorCode:errorCode
                                                                                                       options:options];
    [self queueFromLower:task];
}

- (void) queueMAP_Open_Ind:(UMGSMMAP_UserIdentifier *)userIdentifier
                    dialog:(UMGSMMAP_DialogIdentifier *)dialogId
               transaction:(NSString *)tcapTransactionId
         remoteTransaction:(NSString *)tcapRemoteTransactionId
                       map:(id<UMLayerGSMMAP_ProviderProtocol>)map
                   variant:(UMTCAP_Variant)variant
            callingAddress:(SccpAddress *)src
             calledAddress:(SccpAddress *)dst
           dialoguePortion:(UMTCAP_asn1_dialoguePortion *)xdialoguePortion
                   options:(NSDictionary *)options
{
    SS7GenericInstance_MAP_Open_Ind_Task *task = [[SS7GenericInstance_MAP_Open_Ind_Task alloc]initWithInstance:self
                                                                                                  userId:userIdentifier
                                                                                                  dialog:dialogId
                                                                                             transaction:tcapTransactionId
                                                                                       remoteTransaction:tcapRemoteTransactionId
                                                                                                     map:map
                                                                                                 variant:variant
                                                                                          callingAddress:src
                                                                                           calledAddress:dst
                                                                                         dialoguePortion:xdialoguePortion
                                                                                                 options:options];
    [self queueFromLower:task];
}

- (void) queueMAP_Open_Resp:(UMGSMMAP_UserIdentifier *)userIdentifier
                     dialog:(UMGSMMAP_DialogIdentifier *)dialogId
                transaction:(NSString *)tcapLocalTransactionId
          remoteTransaction:(NSString *)tcapRemoteTransactionId
                        map:(id<UMLayerGSMMAP_ProviderProtocol>)map
                    variant:(UMTCAP_Variant)variant
             callingAddress:(SccpAddress *)callingAddress
              calledAddress:(SccpAddress *)calledAddress
            dialoguePortion:(UMTCAP_asn1_dialoguePortion *)dialoguePortion
                    options:(NSDictionary *)options
{
    SS7GenericInstance_MAP_Open_Resp_Task *task = [[SS7GenericInstance_MAP_Open_Resp_Task alloc]initWithInstance:self
                                                                                                    userId:userIdentifier
                                                                                                    dialog:dialogId
                                                                                               transaction:tcapLocalTransactionId
                                                                                         remoteTransaction:tcapRemoteTransactionId
                                                                                                       map:map
                                                                                                   variant:variant
                                                                                            callingAddress:callingAddress
                                                                                             calledAddress:calledAddress
                                                                                           dialoguePortion:dialoguePortion
                                                                                                   options:options];
    [self queueFromLower:task];
}

-(void)queueMAP_Delimiter_Ind:(UMGSMMAP_UserIdentifier *)userIdentifier
                       dialog:(UMGSMMAP_DialogIdentifier *)dialogId
               callingAddress:(SccpAddress *)callingAddress
                calledAddress:(SccpAddress *)calledAddress
              dialoguePortion:(UMTCAP_asn1_dialoguePortion *)dialoguePortion
                transactionId:(NSString *)tcapLocalTransactionId
          remoteTransactionId:(NSString *)tcapRemoteTransactionId
                      options:(NSDictionary *)options
{
    SS7GenericInstance_MAP_Delimiter_Ind_Task *task = [[SS7GenericInstance_MAP_Delimiter_Ind_Task alloc]initWithInstance:self
                                                                                                            userId:userIdentifier
                                                                                                            dialog:dialogId
                                                                                                    callingAddress:callingAddress
                                                                                                     calledAddress:calledAddress
                                                                                                   dialoguePortion:dialoguePortion
                                                                                                       transaction:tcapLocalTransactionId
                                                                                                 remoteTransaction:tcapRemoteTransactionId
                                                                                                           options:options];
    [self queueFromLower:task];
}

-(void)queueMAP_Continue_Ind:(UMGSMMAP_UserIdentifier *)userIdentifier
              callingAddress:(SccpAddress *)callingAddress
               calledAddress:(SccpAddress *)calledAddress
             dialoguePortion:(UMTCAP_asn1_dialoguePortion *)dialoguePortion
               transactionId:(NSString *)tcapLocalTransactionId
         remoteTransactionId:(NSString *)tcapRemoteTransactionId
                     options:(NSDictionary *)options
{
    SS7GenericInstance_MAP_Continue_Ind_Task *task = [[SS7GenericInstance_MAP_Continue_Ind_Task alloc]initWithInstance:self
                                                                                                          userId:userIdentifier
                                                                                                  callingAddress:callingAddress
                                                                                                   calledAddress:calledAddress
                                                                                                 dialoguePortion:dialoguePortion
                                                                                                     transaction:tcapLocalTransactionId
                                                                                               remoteTransaction:tcapRemoteTransactionId
                                                                                                         options:options];
    [self queueFromLower:task];

}

-(void)queueMAP_Unidirectional_Ind:(NSDictionary *)options
                    callingAddress:(SccpAddress *)callingAddress
                     calledAddress:(SccpAddress *)calledAddress
                   dialoguePortion:(UMTCAP_asn1_dialoguePortion *)dialoguePortion
                     transactionId:(NSString *)tcapLocalTransactionId
               remoteTransactionId:(NSString *)tcapRemoteTransactionId
{
    SS7GenericInstance_MAP_Unidirectional_Ind_Task *task = [[SS7GenericInstance_MAP_Unidirectional_Ind_Task alloc]initWithInstance:self
                                                                                                              callingAddress:callingAddress
                                                                                                               calledAddress:calledAddress
                                                                                                             dialoguePortion:dialoguePortion
                                                                                                                 transaction:tcapLocalTransactionId
                                                                                                           remoteTransaction:tcapRemoteTransactionId
                                                                                                                     options:options];
    [self queueFromLower:task];
}


-(void) queueMAP_Close_Ind:(UMGSMMAP_UserIdentifier *)userIdentifier
                   options:(NSDictionary *)options
{
    SS7GenericInstance_MAP_Close_Ind_Task *task = [[SS7GenericInstance_MAP_Close_Ind_Task alloc]initWithInstance:self
                                                                                            userIdentifier:userIdentifier
                                                                                                   options:options];
    [self queueFromLower:task];
}
/*
 -(void) queueMAP_U_Abort_Req:(UMGSMMAP_UserIdentifier *)userIdentifier
 options:(NSDictionary *)options
 {
 SS7GenericInstance_MAP_U_Abort_Req_Task *task = [[SS7GenericInstance_MAP_U_Abort_Req_Task alloc]initWithInstance:self
 userIdentifier:userIdentifier
 options:options];
 [self queueFromLower:task];
 }
 */
-(void)queueMAP_U_Abort_Ind:(UMGSMMAP_UserIdentifier *)userIdentifier
             callingAddress:(SccpAddress *)callingAddress
              calledAddress:(SccpAddress *)calledAddress
            dialoguePortion:(UMTCAP_asn1_dialoguePortion *)dialoguePortion
              transactionId:(NSString *)tcapLocalTransactionId
        remoteTransactionId:(NSString *)tcapRemoteTransactionId
                    options:(NSDictionary *)options
{
    SS7GenericInstance_MAP_U_Abort_Ind_Task *task = [[SS7GenericInstance_MAP_U_Abort_Ind_Task alloc]initWithInstance:self
                                                                                                userIdentifier:userIdentifier
                                                                                                callingAddress:callingAddress
                                                                                                 calledAddress:calledAddress
                                                                                               dialoguePortion:dialoguePortion
                                                                                                   transaction:tcapLocalTransactionId
                                                                                             remoteTransaction:tcapRemoteTransactionId
                                                                                                       options:options];
    [self queueFromLower:task];
}

-(void) queueMAP_P_Abort_Ind:(UMGSMMAP_UserIdentifier *)userIdentifier
              callingAddress:(SccpAddress *)callingAddress
               calledAddress:(SccpAddress *)calledAddress
             dialoguePortion:(UMTCAP_asn1_dialoguePortion *)dialoguePortion
               transactionId:(NSString *)tcapLocalTransactionId
         remoteTransactionId:(NSString *)tcapRemoteTransactionId
                     options:(NSDictionary *)options
{
    SS7GenericInstance_MAP_P_Abort_Ind_Task *task = [[SS7GenericInstance_MAP_P_Abort_Ind_Task alloc]initWithInstance:self
                                                                                                userIdentifier:userIdentifier
                                                                                                callingAddress:callingAddress
                                                                                                 calledAddress:calledAddress
                                                                                               dialoguePortion:dialoguePortion
                                                                                                   transaction:tcapLocalTransactionId
                                                                                             remoteTransaction:tcapRemoteTransactionId
                                                                                                       options:options];
    [self queueFromLower:task];
}



-(void) queueMAP_Notice_Ind:(UMGSMMAP_UserIdentifier *)userIdentifier
          tcapTransactionId:(NSString *)tcapLocalTransactionId
                     reason:(SCCP_ReturnCause)reason
                    options:(NSDictionary *)options
{
    SS7GenericInstance_MAP_Notice_Ind_Task *task = [[SS7GenericInstance_MAP_Notice_Ind_Task alloc]initWithInstance:self
                                                                                              userIdentifier:userIdentifier
                                                                                                 transaction:tcapLocalTransactionId
                                                                                                      reason:reason
                                                                                                     options:options];
    [self queueFromLower:task];
}

#pragma mark -
#pragma mark execution tasks

-(void) executeMAP_Invoke_Ind:(UMASN1Object *)param
                       userId:(UMGSMMAP_UserIdentifier *)userIdentifier
                       dialog:(UMGSMMAP_DialogIdentifier *)dialogId
                  transaction:(NSString *)tcapTransactionId
                       opCode:(UMLayerGSMMAP_OpCode *)opcode
                     invokeId:(int64_t)invokeId
                     linkedId:(int64_t)linkedId
                         last:(BOOL)last
                      options:(NSDictionary *)options
{
    SS7GenericSession *t = [self sessionById:userIdentifier];
    if(t==NULL)
    {
        [self.logFeed minorErrorText:[NSString stringWithFormat:@"incoming executeMAP_Invoke_Ind for unknown userIdentifier %@",userIdentifier]];
        return;
    }
    if(t)
    {
        [t sessionMAP_Invoke_Ind:(UMASN1Object *)param
                          userId:userIdentifier
                          dialog:dialogId
                     transaction:tcapTransactionId
                          opCode:opcode
                        invokeId:invokeId
                        linkedId:linkedId
                            last:last
                         options:options];
    }
}

-(void) sessionMAP_Invoke_Ind:(UMASN1Object *)param
                       userId:(UMGSMMAP_UserIdentifier *)userIdentifier
                       dialog:(UMGSMMAP_DialogIdentifier *)xdialogId
                  transaction:(NSString *)tcapTransactionId
                       opCode:(UMLayerGSMMAP_OpCode *)xopcode
                     invokeId:(int64_t)xinvokeId
                     linkedId:(int64_t)xlinkedId
                         last:(BOOL)xlast
                      options:(NSDictionary *)xoptions
{
    _hasReceivedInvokes++;
    [self.logFeed minorErrorText:[NSString stringWithFormat:@"incoming executeMAP_Invoke_Ind for unknown userIdentifier %@",userIdentifier]];
    return;
}

-(void) executeMAP_ReturnResult_Resp:(UMASN1Object *)param
                              userId:(UMGSMMAP_UserIdentifier *)userIdentifier
                              dialog:(UMGSMMAP_DialogIdentifier *)dialogId
                         transaction:(NSString *)tcapTransactionId
                              opCode:(UMLayerGSMMAP_OpCode *)xopcode
                            invokeId:(int64_t)xinvokeId
                            linkedId:(int64_t)xlinkedId
                                last:(BOOL)xlast
                             options:(NSDictionary *)xoptions
{
    SS7GenericSession *t = [self sessionById:userIdentifier];
    if(t==NULL)
    {
        [self.logFeed minorErrorText:[NSString stringWithFormat:@"incoming MAP_ReturnResult_Resp for unknown userIdentifier %@",userIdentifier]];
        return;
    }
    [t sessionMAP_ReturnResult_Resp:param
                             userId:userIdentifier
                             dialog:dialogId
                        transaction:tcapTransactionId
                             opCode:xopcode
                           invokeId:xinvokeId
                           linkedId:xlinkedId
                               last:xlast
                            options:xoptions];
}

- (void) executeMAP_ReturnError_Resp:(UMASN1Object *)param
                              userId:(UMGSMMAP_UserIdentifier *)userIdentifier
                              dialog:(UMGSMMAP_DialogIdentifier *)dialogId
                         transaction:(NSString *)tcapTransactionId
                              opCode:(UMLayerGSMMAP_OpCode *)xopcode
                            invokeId:(int64_t)xinvokeId
                            linkedId:(int64_t)xlinkedId
                           errorCode:(int64_t)err
                             options:(NSDictionary *)xoptions
{
    SS7GenericSession *t = [self sessionById:userIdentifier];
    if(t==NULL)
    {
        [self.logFeed minorErrorText:[NSString stringWithFormat:@"incoming MAP_ReturnError_Resp for unknown userIdentifier %@",userIdentifier]];
        return;
    }
    [t sessionMAP_ReturnError_Resp:param
                            userId:userIdentifier
                            dialog:dialogId
                       transaction:tcapTransactionId
                            opCode:xopcode
                          invokeId:xinvokeId
                          linkedId:xlinkedId
                         errorCode:err
                           options:xoptions];
}

- (void) executeMAP_Reject_Resp:(UMASN1Object *)param
                         userId:(UMGSMMAP_UserIdentifier *)userIdentifier
                         dialog:(UMGSMMAP_DialogIdentifier *)dialogId
                    transaction:(NSString *)tcapTransactionId
                         opCode:(UMLayerGSMMAP_OpCode *)xopcode
                       invokeId:(int64_t)xinvokeId
                       linkedId:(int64_t)xlinkedId
                      errorCode:(int64_t)err
                        options:(NSDictionary *)xoptions
{
    SS7GenericSession *t = [self sessionById:userIdentifier];
    if(t==NULL)
    {
        [self.logFeed minorErrorText:[NSString stringWithFormat:@"incoming MAP_Reject_Resp for unknown userIdentifier %@",userIdentifier]];
        return;
    }
    [t sessionMAP_Reject_Resp:param
                       userId:userIdentifier
                       dialog:dialogId
                  transaction:tcapTransactionId
                       opCode:xopcode
                     invokeId:xinvokeId
                     linkedId:xlinkedId
                    errorCode:err
                      options:xoptions];
}

- (void) executeMAP_Open_Ind:(UMGSMMAP_UserIdentifier *)userIdentifier
                      dialog:(UMGSMMAP_DialogIdentifier *)dialogId
                 transaction:(NSString *)tcapTransactionId
           remoteTransaction:(NSString *)tcapRemoteTransactionId
                         map:(id<UMLayerGSMMAP_ProviderProtocol>)map
                     variant:(UMTCAP_Variant)xvariant
              callingAddress:(SccpAddress *)src
               calledAddress:(SccpAddress *)dst
             dialoguePortion:(UMTCAP_asn1_dialoguePortion *)xdialoguePortion
                     options:(NSDictionary *)options
{
    [self.logFeed majorErrorText:@"incoming executeMAP_Open_Ind for SS7GenericInstance. Should be overriden by Instance object"];
}

- (void) executeMAP_Open_Resp:(UMGSMMAP_UserIdentifier *)userIdentifier
                       dialog:(UMGSMMAP_DialogIdentifier *)dialogId
                  transaction:(NSString *)tcapTransactionId
            remoteTransaction:(NSString *)tcapRemoteTransactionId
                          map:(id<UMLayerGSMMAP_ProviderProtocol>)map
                      variant:(UMTCAP_Variant)variant
               callingAddress:(SccpAddress *)callingAddress
                calledAddress:(SccpAddress *)calledAddress
              dialoguePortion:(UMTCAP_asn1_dialoguePortion *)dialoguePortion
                      options:(NSDictionary *)options
{
    SS7GenericSession *t = [self sessionById:userIdentifier];
    if(t==NULL)
    {
        [self.logFeed minorErrorText:[NSString stringWithFormat:@"incoming executeMAP_Invoke_Ind for unknown userIdentifier %@",userIdentifier]];
        return;
    }

    t.userIdentifier = userIdentifier;
    t.gInstance = self;

    [t sessionMAP_Open_Resp:userIdentifier
                     dialog:dialogId
                transaction:tcapTransactionId
          remoteTransaction:tcapRemoteTransactionId
                        map:map
                    variant:variant
             callingAddress:callingAddress
              calledAddress:calledAddress
            dialoguePortion:dialoguePortion
                    options:options];
    [self addSession:t userId:userIdentifier];
}


-(void) executeMAP_Delimiter_Ind:(UMGSMMAP_UserIdentifier *)userIdentifier
                          dialog:(UMGSMMAP_DialogIdentifier *)dialogId
                  callingAddress:(SccpAddress *)src
                   calledAddress:(SccpAddress *)dst
                 dialoguePortion:(UMTCAP_asn1_dialoguePortion *)xdialoguePortion
                   transactionId:(NSString *)localTransactionId
             remoteTransactionId:(NSString *)remoteTransactionId
                         options:(NSDictionary *)options
{
    SS7GenericSession *t = [self sessionById:userIdentifier];
    if(t==NULL)
    {
        [self.logFeed minorErrorText:[NSString stringWithFormat:@"incoming MAP_Delimiter_Ind for unknown userIdentifier %@",userIdentifier]];
        return;
    }
}

-(void) executeMAP_Close_Ind:(UMGSMMAP_UserIdentifier *)userIdentifier
                     options:(NSDictionary *)options
{

    SS7GenericSession *t = [self sessionById:userIdentifier];
    if(t==NULL)
    {
        [self.logFeed minorErrorText:[NSString stringWithFormat:@"incoming MAP_Close_Ind for unknown userIdentifier %@",userIdentifier]];
        return;
    }
    [t sessionMAP_Close_Ind:userIdentifier
                    options:options];
}

-(void) executeMAP_U_Abort_Ind:(UMGSMMAP_UserIdentifier *)userIdentifier
                callingAddress:(SccpAddress *)src
                 calledAddress:(SccpAddress *)dst
               dialoguePortion:(UMTCAP_asn1_dialoguePortion *)xdialoguePortion
                 transactionId:(NSString *)localTransactionId
           remoteTransactionId:(NSString *)remoteTransactionId
                       options:(NSDictionary *)options
{
    /****/
    if(self.logLevel <= UMLOG_DEBUG)
    {
        NSString *s = [NSString stringWithFormat:@"executeMAP_U_Abort_Ind: dialogPortion: %@ (%@)",xdialoguePortion,[xdialoguePortion className]];
        [self.logFeed infoText:s];
    }

    SS7GenericSession *t = [self sessionById:userIdentifier];
    if(t==NULL)
    {
        [self.logFeed minorErrorText:[NSString stringWithFormat:@"incoming MAP_U_Abort_Ind for unknown userIdentifier %@",userIdentifier]];
        return;
    }
    [t sessionMAP_U_Abort_Ind:userIdentifier
               callingAddress:src
                calledAddress:dst
              dialoguePortion:xdialoguePortion
                transactionId:localTransactionId
          remoteTransactionId:remoteTransactionId
                      options:options];
    [self markSessionForTermination:t reason:@"u-abort-ind"];
}

-(void)executeMAP_P_Abort_Ind:(UMGSMMAP_UserIdentifier *)userIdentifier
               callingAddress:(SccpAddress *)src
                calledAddress:(SccpAddress *)dst
              dialoguePortion:(UMTCAP_asn1_dialoguePortion *)xdialoguePortion
                transactionId:(NSString *)localTransactionId
          remoteTransactionId:(NSString *)remoteTransactionId
                      options:(NSDictionary *)options
{
    /*****/
    SS7GenericSession *t = [self sessionById:userIdentifier];
    if(t==NULL)
    {
        [self.logFeed minorErrorText:[NSString stringWithFormat:@"incoming MAP_P_Abort_Ind for unknown userIdentifier %@",userIdentifier]];
        return;
    }
    [t sessionMAP_P_Abort_Ind:userIdentifier
               callingAddress:src
                calledAddress:dst
              dialoguePortion:xdialoguePortion
                transactionId:localTransactionId
          remoteTransactionId:remoteTransactionId
                      options:options];
    [self markSessionForTermination:t reason:@"p-abort-ind"];
}


-(void)executeMAP_Notice_Ind:(UMGSMMAP_UserIdentifier *)userIdentifier
           tcapTransactionId:(NSString *)localTransactionId
                      reason:(SCCP_ReturnCause)reason
                     options:(NSDictionary *)options
{
    SS7GenericSession *t = [self sessionById:userIdentifier];
    if(t==NULL)
    {
        [self.logFeed minorErrorText:[NSString stringWithFormat:@"incoming MAP_Notice_Ind for unknown userIdentifier %@",userIdentifier]];
        return;
    }
    [t sessionMAP_Notice_Ind:userIdentifier
           tcapTransactionId:localTransactionId
                      reason:reason
                     options:options];
    [self markSessionForTermination:t reason:@"notice-ind"];
}

-(void)executeMAP_Continue_Ind:(UMGSMMAP_UserIdentifier *)userIdentifier
                callingAddress:(SccpAddress *)src
                 calledAddress:(SccpAddress *)dst
               dialoguePortion:(UMTCAP_asn1_dialoguePortion *)xdialoguePortion
                 transactionId:(NSString *)localTransactionId
           remoteTransactionId:(NSString *)remoteTransactionId
                       options:(NSDictionary *)options;
{
    SS7GenericSession *t = [self sessionById:userIdentifier];
    if(t==NULL)
    {
        [self.logFeed minorErrorText:[NSString stringWithFormat:@"incoming MAP_Continue_Ind for unknown userIdentifier %@",userIdentifier]];
        return;
    }
    [t sessionMAP_Continue_Ind:userIdentifier
                callingAddress:src
                 calledAddress:dst
               dialoguePortion:xdialoguePortion
                 transactionId:localTransactionId
           remoteTransactionId:remoteTransactionId
                       options:options];
}

-(void)executeMAP_Unidirectional_Ind:(NSDictionary *)options
                      callingAddress:(SccpAddress *)src
                       calledAddress:(SccpAddress *)dst
                     dialoguePortion:(UMTCAP_asn1_dialoguePortion *)xdialoguePortion
                       transactionId:(NSString *)localTransactionId
                 remoteTransactionId:(NSString *)remoteTransactionId
{
    [self.logFeed minorErrorText:@"unimplemented MAP_Unidirectional_Ind"];
}

- (UMSynchronizedSortedDictionary *)decodeSmsObject:(NSData *)pdu
                                            context:(id)context
{
    UMSMS *sms = [[UMSMS alloc]init];
    [sms decodePdu:pdu context:context];
    return [sms objectValue];
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
    NSLog(@"SS7GenericInstance authenticateUser user=%@ pass=%@",user,pass);
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

- (void)  httpGetPost:(UMHTTPRequest *)req
{
    @autoreleasepool
    {
        /* pages requesting auth will have UMHTTP_AUTHENTICATION_STATUS_FAILED or UMHTTP_AUTHENTICATION_STATUS_PASSED
         pages not requiring auth will have UMHTTP_AUTHENTICATION_STATUS_NOT_REQUESTED */

        if(req.authenticationStatus == UMHTTP_AUTHENTICATION_STATUS_FAILED)
        {
            [req setResponsePlainText:@"not-authorization-vlr"];
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
            NSString *path = req.url.relativePath;
            if([path hasSuffix:@"/msc/index.php"])
            {
                path = @"/msc";
            }
            else if([path hasSuffix:@"/msc/"])
            {
                path = @"/msc";
            }
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

            if([path isEqualToString:@"/msc"])
            {
                [req setResponseHtmlString:[SS7GenericInstance webIndexForm]];
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

+ (NSString *)webIndexForm
{
    static NSMutableString *s = NULL;

    if(s)
    {
        return s;
    }
    s = [[NSMutableString alloc]init];
    [SS7GenericInstance webHeader:s title:@"GSM-API Main Menu"];
    [s appendString:@"<h2>Generic Menu</h2>\n"];
    [s appendString:@"<UL>\n"];
    [s appendString:@"<LI><a href=\"/hlr/alertServiceCentre\">alertServiceCentre</a>\n"];
    [s appendString:@"</UL>\n"];
    [s appendString:@"</body>\n"];
    [s appendString:@"</html>\n"];
    return s;
}


+ (void)webHeader:(NSMutableString *)s title:(NSString *)t
{
    [s appendString:@"<html>\n"];
    [s appendString:@"<head>\n"];
    [s appendString:@"    <link rel=\"stylesheet\" href=\"/css/style.css\" type=\"text/css\">\n"];
    [s appendFormat:@"    <title>%@</title>\n",t];
    [s appendString:@"</head>\n"];
    [s appendString:@"<body>\n"];
}

- (void)housekeeping
{
    if([_housekeeping_lock tryLock] == 0)
    {
        _delayedDestroy3 = NULL;
        _delayedDestroy3 = _delayedDestroy2;
        _delayedDestroy2 = _delayedDestroy1;
        _delayedDestroy1 = [[NSMutableArray alloc]init];
        NSArray *keys = [_sessions allKeys];
        for(NSString *key in keys)
        {
            SS7GenericSession *t = _sessions[key];
            if(t)
            {
                if(t.hasEnded)
                {
                    [_delayedDestroy1 addObject:t];
                    [_sessions removeObjectForKey:key];
                }
                if([t isTimedOut])
                {
                    [t timeout];
                }
            }
        }
        [_houseKeepingTimerRun touch];
        [_housekeeping_lock unlock];
    }
}

- (void)dump:(NSFileHandle *)filehandler
{
    [super dump:filehandler];

    NSArray *allTransactionIds = [_sessions allKeys];
    for(NSString *tid in allTransactionIds)
    {
        NSMutableString *s = [[NSMutableString alloc]init];
        [s appendString:@"    ----------------------------------------------------------------------------\n"];
        [s appendFormat:@"    Transaction: %@\n",tid];
        [s appendString:@"    ----------------------------------------------------------------------------\n"];
        [filehandler writeData: [s dataUsingEncoding:NSUTF8StringEncoding]];
        SS7GenericSession *t = _sessions[tid];
        [t dump:filehandler];
    }
}

@end


//
//  SS7GenericInstance.h
//  ulibss7config
//
//  Created by Andreas Fink on 20.11.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//


#import <ulib/ulib.h>
#import <ulibgt/ulibgt.h>
#import <ulibsccp/ulibsccp.h>
#import <ulibtcap/ulibtcap.h>
#import <ulibgsmmap/ulibgsmmap.h>
#import "UMSS7ConfigObject.h"
#import "SS7UserAuthenticateProtocol.h"

@class SS7GenericSession;

@interface SS7GenericInstance : UMLayer<UMLayerGSMMAP_UserProtocol,
                                UMHTTPServerHttpGetPostDelegate,
                                UMHTTPRequest_TimeoutProtocol
/* AuthenticationDelegateProtocol */>
{
    NSString                    *_instanceAddress;
    UMSynchronizedDictionary    *_sessions;
    UMLayerGSMMAP               *_gsmMap;
    NSTimeInterval              _timeoutInSeconds;
    UMMutex                     *_uidMutex;
    UMMutex                     *_operationMutex;
    NSString                    *_timeoutTraceDirectory;
    NSString                    *_genericTraceDirectory;
    UMTimer                     *_houseKeepingTimer;
    UMMutex                     *_housekeeping_lock;
    UMAtomicDate                *_houseKeepingTimerRun;
    UMHTTPClient                *_webClient;
    id<SS7UserAuthenticateProtocol> _authDelegate;
    NSMutableArray              *_delayedDestroy1;
    NSMutableArray              *_delayedDestroy2;
    NSMutableArray              *_delayedDestroy3;
}

@property(readwrite,strong) UMLayerGSMMAP *gsmMap;
@property(readwrite,strong) NSString *instanceAddress;
@property(readwrite,assign) NSTimeInterval timeoutInSeconds;
@property(readwrite,strong) NSString *timeoutTraceDirectory;
@property(readwrite,strong) NSString *genericTraceDirectory;
@property(readwrite,strong) UMAtomicDate *houseKeepingTimerRun;
@property(readwrite,strong) UMHTTPClient *webClient;
@property(readwrite,strong) id<SS7UserAuthenticateProtocol>    authDelegate;


- (SS7GenericInstance *)initWithNumber:(NSString *)iAddress;
- (SS7GenericInstance *)initWithTaskQueueMulti:(UMTaskQueueMulti *)tq name:(NSString *)name;

- (NSString *)status;
- (void) setConfig:(NSDictionary *)cfg applicationContext:(id)appContext;


- (UMGSMMAP_UserIdentifier *)getNewUserIdentifier;
- (SS7GenericSession *)sessionById:(UMGSMMAP_UserIdentifier *)userId;
- (void)addSession:(SS7GenericSession *)t userId:(UMGSMMAP_UserIdentifier *)uidstr;
- (void) markSessionForTermination:(SS7GenericSession *)t reason:(NSString *)reason;
+ (NSString *)webIndexForm;

+ (void)webHeader:(NSMutableString *)s title:(NSString *)t;
- (UMHTTPAuthenticationStatus)httpAuthenticateRequest:(UMHTTPRequest *)req
                                                realm:(NSString **)realm;
- (UMHTTPAuthenticationStatus)authenticateUser:(NSString *)user pass:(NSString *)pass;
- (NSUInteger)sessionsCount;
- (void)housekeeping;


-(void) queueMAP_Invoke_Ind:GSMMAP_INVOKE_INDICATION_PARAMETERS;
-(void) queueMAP_ReturnResult_Resp:(UMASN1Object *)param
                            userId:(UMGSMMAP_UserIdentifier *)userIdentifier
                            dialog:(UMGSMMAP_DialogIdentifier *)dialogId
                       transaction:(NSString *)tcapTransactionId
                            opCode:(UMLayerGSMMAP_OpCode *)xopcode
                          invokeId:(int64_t)xinvokeId
                          linkedId:(int64_t)xlinkedId
                              last:(BOOL)xlast
                           options:(NSDictionary *)xoptions;


- (void) queueMAP_ReturnError_Resp:(UMASN1Object *)param
                            userId:(UMGSMMAP_UserIdentifier *)userIdentifier
                            dialog:(UMGSMMAP_DialogIdentifier *)dialogId
                       transaction:(NSString *)tcapTransactionId
                            opCode:(UMLayerGSMMAP_OpCode *)xopcode
                          invokeId:(int64_t)xinvokeId
                          linkedId:(int64_t)xlinkedId
                         errorCode:(int64_t)err
                           options:(NSDictionary *)xoptions;

- (void) queueMAP_Reject_Resp:(UMASN1Object *)param
                       userId:(UMGSMMAP_UserIdentifier *)userIdentifier
                       dialog:(UMGSMMAP_DialogIdentifier *)dialogId
                  transaction:(NSString *)tcapTransactionId
                       opCode:(UMLayerGSMMAP_OpCode *)xopcode
                     invokeId:(int64_t)xinvokeId
                     linkedId:(int64_t)xlinkedId
                    errorCode:(int64_t)err
                      options:(NSDictionary *)xoptions;

#pragma mark -
#pragma mark Session Handling

- (void) queueMAP_Open_Ind:(UMGSMMAP_UserIdentifier *)userIdentifier
                    dialog:(UMGSMMAP_DialogIdentifier *)dialogId
               transaction:(NSString *)tcapTransactionId
         remoteTransaction:(NSString *)tcapRemoteTransactionId
                       map:(id<UMLayerGSMMAP_ProviderProtocol>)map
                   variant:(UMTCAP_Variant)xvariant
            callingAddress:(SccpAddress *)src
             calledAddress:(SccpAddress *)dst
           dialoguePortion:(UMTCAP_asn1_dialoguePortion *)xdialoguePortion
                   options:(NSDictionary *)options;

- (void)queueMAP_Open_Resp:(UMGSMMAP_UserIdentifier *)uidstr
                    dialog:(UMGSMMAP_DialogIdentifier *)dialogId
               transaction:(NSString *)tcapTransactionId
         remoteTransaction:(NSString *)tcapRemoteTransactionId
                       map:(id<UMLayerGSMMAP_ProviderProtocol>)map
                   variant:(UMTCAP_Variant)xvariant
            callingAddress:(SccpAddress *)src
             calledAddress:(SccpAddress *)dst
           dialoguePortion:(UMTCAP_asn1_dialoguePortion *)xdialoguePortion
                   options:(NSDictionary *)xoptions;

-(void)queueMAP_Delimiter_Ind:(UMGSMMAP_UserIdentifier *)userIdentifier
                       dialog:(UMGSMMAP_DialogIdentifier *)dialogId
               callingAddress:(SccpAddress *)src
                calledAddress:(SccpAddress *)dst
              dialoguePortion:(UMTCAP_asn1_dialoguePortion *)xdialoguePortion
                transactionId:(NSString *)localTransactionId
          remoteTransactionId:(NSString *)remoteTransactionId
                      options:(NSDictionary *)options;

-(void)queueMAP_Continue_Ind:(UMGSMMAP_UserIdentifier *)userIdentifier
              callingAddress:(SccpAddress *)src
               calledAddress:(SccpAddress *)dst
             dialoguePortion:(UMTCAP_asn1_dialoguePortion *)xdialoguePortion
               transactionId:(NSString *)localTransactionId
         remoteTransactionId:(NSString *)remoteTransactionId
                     options:(NSDictionary *)options;

-(void)queueMAP_Unidirectional_Ind:(NSDictionary *)options
                    callingAddress:(SccpAddress *)src
                     calledAddress:(SccpAddress *)dst
                   dialoguePortion:(UMTCAP_asn1_dialoguePortion *)xdialoguePortion
                     transactionId:(NSString *)localTransactionId
               remoteTransactionId:(NSString *)remoteTransactionId;


-(void) queueMAP_Close_Ind:(UMGSMMAP_UserIdentifier *)userIdentifier
                   options:(NSDictionary *)options;
-(void)queueMAP_U_Abort_Ind:(UMGSMMAP_UserIdentifier *)userIdentifier
             callingAddress:(SccpAddress *)src
              calledAddress:(SccpAddress *)dst
            dialoguePortion:(UMTCAP_asn1_dialoguePortion *)xdialoguePortion
              transactionId:(NSString *)localTransactionId
        remoteTransactionId:(NSString *)remoteTransactionId
                    options:(NSDictionary *)options;

-(void) queueMAP_P_Abort_Ind:(UMGSMMAP_UserIdentifier *)userIdentifier
              callingAddress:(SccpAddress *)src
               calledAddress:(SccpAddress *)dst
             dialoguePortion:(UMTCAP_asn1_dialoguePortion *)xdialoguePortion
               transactionId:(NSString *)localTransactionId
         remoteTransactionId:(NSString *)remoteTransactionId
                     options:(NSDictionary *)options;

-(void) queueMAP_Notice_Ind:(UMGSMMAP_UserIdentifier *)userIdentifier
          tcapTransactionId:(NSString *)localTransactionId
                     reason:(SCCP_ReturnCause)reason
                    options:(NSDictionary *)options;

-(void) executeMAP_Invoke_Ind:GSMMAP_INVOKE_INDICATION_PARAMETERS;
-(void) executeMAP_ReturnResult_Resp:(UMASN1Object *)param
                              userId:(UMGSMMAP_UserIdentifier *)userIdentifier
                              dialog:(UMGSMMAP_DialogIdentifier *)dialogId
                         transaction:(NSString *)tcapTransactionId
                              opCode:(UMLayerGSMMAP_OpCode *)xopcode
                            invokeId:(int64_t)xinvokeId
                            linkedId:(int64_t)xlinkedId
                                last:(BOOL)xlast
                             options:(NSDictionary *)xoptions;


- (void) executeMAP_ReturnError_Resp:(UMASN1Object *)param
                              userId:(UMGSMMAP_UserIdentifier *)userIdentifier
                              dialog:(UMGSMMAP_DialogIdentifier *)dialogId
                         transaction:(NSString *)tcapTransactionId
                              opCode:(UMLayerGSMMAP_OpCode *)xopcode
                            invokeId:(int64_t)xinvokeId
                            linkedId:(int64_t)xlinkedId
                           errorCode:(int64_t)err
                             options:(NSDictionary *)xoptions;

- (void) executeMAP_Reject_Resp:(UMASN1Object *)param
                         userId:(UMGSMMAP_UserIdentifier *)userIdentifier
                         dialog:(UMGSMMAP_DialogIdentifier *)dialogId
                    transaction:(NSString *)tcapTransactionId
                         opCode:(UMLayerGSMMAP_OpCode *)xopcode
                       invokeId:(int64_t)xinvokeId
                       linkedId:(int64_t)xlinkedId
                      errorCode:(int64_t)err
                        options:(NSDictionary *)xoptions;

#pragma mark -
#pragma mark Session Handling

- (void) executeMAP_Open_Ind:(UMGSMMAP_UserIdentifier *)userIdentifier
                      dialog:(UMGSMMAP_DialogIdentifier *)dialogId
                 transaction:(NSString *)tcapTransactionId
           remoteTransaction:(NSString *)tcapRemoteTransactionId
                         map:(id<UMLayerGSMMAP_ProviderProtocol>)map
                     variant:(UMTCAP_Variant)xvariant
              callingAddress:(SccpAddress *)src
               calledAddress:(SccpAddress *)dst
             dialoguePortion:(UMTCAP_asn1_dialoguePortion *)xdialoguePortion
                     options:(NSDictionary *)options;

- (void)executeMAP_Open_Resp:(UMGSMMAP_UserIdentifier *)uidstr
                      dialog:(UMGSMMAP_DialogIdentifier *)dialogId
                 transaction:(NSString *)tcapTransactionId
           remoteTransaction:(NSString *)tcapRemoteTransactionId
                         map:(id<UMLayerGSMMAP_ProviderProtocol>)map
                     variant:(UMTCAP_Variant)xvariant
              callingAddress:(SccpAddress *)src
               calledAddress:(SccpAddress *)dst
             dialoguePortion:(UMTCAP_asn1_dialoguePortion *)xdialoguePortion
                     options:(NSDictionary *)xoptions;

-(void)executeMAP_Delimiter_Ind:(UMGSMMAP_UserIdentifier *)userIdentifier
                         dialog:(UMGSMMAP_DialogIdentifier *)dialogId
                 callingAddress:(SccpAddress *)src
                  calledAddress:(SccpAddress *)dst
                dialoguePortion:(UMTCAP_asn1_dialoguePortion *)xdialoguePortion
                  transactionId:(NSString *)localTransactionId
            remoteTransactionId:(NSString *)remoteTransactionId
                        options:(NSDictionary *)options;

-(void)executeMAP_Continue_Ind:(UMGSMMAP_UserIdentifier *)userIdentifier
                callingAddress:(SccpAddress *)src
                 calledAddress:(SccpAddress *)dst
               dialoguePortion:(UMTCAP_asn1_dialoguePortion *)xdialoguePortion
                 transactionId:(NSString *)localTransactionId
           remoteTransactionId:(NSString *)remoteTransactionId
                       options:(NSDictionary *)options;

-(void)executeMAP_Unidirectional_Ind:(NSDictionary *)options
                      callingAddress:(SccpAddress *)src
                       calledAddress:(SccpAddress *)dst
                     dialoguePortion:(UMTCAP_asn1_dialoguePortion *)xdialoguePortion
                       transactionId:(NSString *)localTransactionId
                 remoteTransactionId:(NSString *)remoteTransactionId;


-(void) executeMAP_Close_Ind:(UMGSMMAP_UserIdentifier *)userIdentifier
                     options:(NSDictionary *)options;

-(void)executeMAP_U_Abort_Ind:(UMGSMMAP_UserIdentifier *)userIdentifier
               callingAddress:(SccpAddress *)src
                calledAddress:(SccpAddress *)dst
              dialoguePortion:(UMTCAP_asn1_dialoguePortion *)xdialoguePortion
                transactionId:(NSString *)localTransactionId
          remoteTransactionId:(NSString *)remoteTransactionId
                      options:(NSDictionary *)options;

-(void) executeMAP_P_Abort_Ind:(UMGSMMAP_UserIdentifier *)userIdentifier
                callingAddress:(SccpAddress *)src
                 calledAddress:(SccpAddress *)dst
               dialoguePortion:(UMTCAP_asn1_dialoguePortion *)xdialoguePortion
                 transactionId:(NSString *)localTransactionId
           remoteTransactionId:(NSString *)remoteTransactionId
                       options:(NSDictionary *)options;

-(void) executeMAP_Notice_Ind:(UMGSMMAP_UserIdentifier *)userIdentifier
            tcapTransactionId:(NSString *)localTransactionId
                       reason:(SCCP_ReturnCause)reason
                      options:(NSDictionary *)options;
@end

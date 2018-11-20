//
//  SS7GenericSession.h
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

@class UMPCAPFile;

#import "OutputFormat.h"
#import "WebMacros.h"

@class SS7GenericInstance;

@interface SS7GenericSession : UMLayerTask<UMSCCP_TraceProtocol>
{
    UMGSMMAP_UserIdentifier *userIdentifier;
    BOOL                    _hasEnded;
    UMASN1Object            *_query;
    UMASN1Object            *_query2;
    UMASN1Object            *_query3;
    UMLayerGSMMAP_OpCode    *_opcode;
    UMLayerGSMMAP_OpCode    *_opcode2;
    UMLayerGSMMAP_OpCode    *_opcode3;
    UMLayerGSMMAP_OpCode    *_firstResponseOpcode;
    UMLayerGSMMAP_OpCode    *_firstInvokeOpcode;
    SS7GenericInstance      *_gInstance;
    SccpAddress             *_localAddress;
    SccpAddress             *_remoteAddress;

    UMHTTPRequest *req;
    NSDate *_startTime;
    UMAtomicDate *_lastActiveTime;
    NSTimeInterval _timeoutInSeconds;

    NSMutableDictionary *options;
    UMTCAP_asn1_objectIdentifier *applicationContext;
    UMTCAP_asn1_objectIdentifier *incomingApplicationContext;
    UMASN1BitString *dialogProtocolVersion;
    NSMutableArray *sccp_sent;
    NSMutableArray *sccp_received;
    BOOL sccpTracefileEnabled;
    UMPCAPFile *pcap;
    UMTCAP_asn1_dialoguePortion *_incomingDialogPortion;
    UMTCAP_asn1_userInformation *userInfo;
    UMTCAP_asn1_userInformation *incomingUserInfo;
    UMGSMMAP_DialogIdentifier *dialogId;
    BOOL    doEnd;
    UMTCAP_Variant  tcapVariant;
    NSString *tcapLocalTransactionId;
    NSString *tcapRemoteTransactionId;
    NSDictionary *incomingOptions;
    UMSynchronizedArray *_components;
    int         nowait;
    BOOL        undefinedSession;
    NSString    *sessionName;
    int         firstInvokeId;

    int _mapVersion;
    int _appContextByte;
    UMLogLevel _logLevel;
    UMMutex *_operationMutex;
    UMHistoryLog *_historyLog;
    BOOL _outgoing;
    BOOL _incoming;
    BOOL _missingSriSm;
    OutputFormat outputFormat;
    UMGSMMAP_MAP_OpenInfo *_incoming_map_open;
    NSInteger hasReceivedInvokes;
    int _phase;
    BOOL _keepOriginalSccpAddressForTcapContinue;

    NSString *_calling_ssn;
    NSString *_called_ssn;
    NSString *_calling_address;
    NSString *_called_address;
    NSString *_calling_tt;
    NSString *_called_tt;
    NSString *_opc;
    NSString *_dpc;
    int _sls;
}

@property(readwrite,strong) SS7GenericInstance *gInstance;
@property(readwrite,strong,atomic)     UMSynchronizedArray *components;
@property(readwrite,strong) UMGSMMAP_UserIdentifier *userIdentifier;
@property(readwrite,assign) BOOL hasEnded;

@property(readwrite,assign) int64_t operation;
@property(readwrite,assign) int64_t operation2;
@property(readwrite,assign) int64_t operation3;
@property(readwrite,assign) int64_t firstResponseOperation;
@property(readwrite,assign) int64_t firstInvokeOperation;

@property(readwrite,strong) UMASN1Object *query;
@property(readwrite,strong) UMASN1Object *query2;
@property(readwrite,strong) UMASN1Object *query3;
@property(readwrite,strong) UMASN1Object *firstResponse;
@property(readwrite,strong) UMASN1Object *firstInvoke;

@property(readwrite,strong) SccpAddress *localAddress;
@property(readwrite,strong) SccpAddress *remoteAddress;
@property(readwrite,strong) UMHTTPRequest *req;

@property(readwrite,strong) NSDictionary *options;
@property(readwrite,strong) UMTCAP_asn1_objectIdentifier *applicationContext;
@property(readwrite,strong) UMTCAP_asn1_objectIdentifier *applicationContext2;
@property(readwrite,strong) UMTCAP_asn1_objectIdentifier *incomingApplicationContext;

@property(readwrite,strong) NSMutableArray *sccp_sent;
@property(readwrite,strong) NSMutableArray *sccp_received;
@property(readwrite,assign) BOOL sccpDebugEnabled;
@property(readwrite,assign) BOOL sccpTracefileEnabled;

@property(readwrite,strong) NSDate *startTime;
@property(readwrite,strong) UMAtomicDate *lastActiveTime;
@property(readwrite,assign) NSTimeInterval timeoutInSeconds;

@property(readwrite,strong) UMGSMMAP_DialogIdentifier *dialogId;
@property(readwrite,strong) UMLayerGSMMAP_OpCode *opcode;
@property(readwrite,strong) UMLayerGSMMAP_OpCode *opcode2;
@property(readwrite,assign) UMTCAP_Variant tcapVariant;
@property(readwrite,strong) NSDictionary *incomingOptions;
@property(readwrite,strong) NSString *tcapLocalTransactionId;
@property(readwrite,strong) NSString *tcapRemoteTransactionId;
@property(readwrite,assign) BOOL doEnd;
@property(readwrite,strong) UMPCAPFile *pcap;
@property(readwrite,assign) int nowait;
@property(readwrite,assign) BOOL undefinedSession;
@property(readwrite,strong) NSString    *sessionName;
@property(readwrite,strong) UMTCAP_asn1_dialoguePortion *incomingDialogPortion;
@property(readwrite,assign) int mapVersion;
@property(readwrite,strong) UMASN1BitString *dialogProtocolVersion;
@property(readwrite,strong,atomic) NSString *opc;
@property(readwrite,strong,atomic) NSString *dpc;
@property(readwrite,assign,atomic) UMLogLevel logLevel;
@property(readwrite,strong) UMHistoryLog  *historyLog;
@property(readwrite,assign) BOOL outgoing;
@property(readwrite,assign) BOOL incoming;
@property(readwrite,assign) BOOL missingSriSm;
@property(readwrite,strong) UMGSMMAP_MAP_OpenInfo *incoming_map_open;
@property(readwrite,assign) int phase;
@property(readwrite,assign) BOOL keepOriginalSccpAddressForTcapContinue;
@property(readwrite,strong) NSString *calling_ssn;
@property(readwrite,strong) NSString *called_ssn;
@property(readwrite,strong) NSString *calling_address;
@property(readwrite,strong) NSString *called_address;
@property(readwrite,strong) NSString *calling_tt;
@property(readwrite,strong) NSString *called_tt;

- (void)setIncomingDialogPortion:(UMTCAP_asn1_dialoguePortion *)xdialoguePortion;
- (UMTCAP_asn1_dialoguePortion *)incomingDialogPortion;

- (UMGSMMAP_UserIdentifier *)getNewUserIdentifier;

- (SS7GenericSession *)initWithInstance:(SS7GenericInstance *)inst operation:(int64_t) xoperation;
- (SS7GenericSession *)initWithHttpReq:(UMHTTPRequest *)xreq
                          operation:(int64_t)op
                           instance:(SS7GenericInstance *)inst;

- (void) handleSccpAddressesDefaultCallingSsn:(NSString *)defaultCallingSsn
                             defaultCalledSsn:(NSString *)defaultCalledSsn
                         defaultCallingNumber:(NSString *)defaultCalling
                          defaultCalledNumber:(NSString *)defaultCalled
                      defaultCalledNumberPlan:(int)numberplan;

- (void) setDefaultApplicationContext:(NSString *)def;
- (void) setUserInfo_MAP_Open;
- (void) setTimeouts;
- (void) setOptions;
- (void)submit;
- (void)submitApplicationContextTest;
- (void)webException:(NSException *)e;
- (SS7GenericSession *)initWithSession:(SS7GenericSession *)ot;
- (void)markForTermination;

//--------------------------------------------------------------------------------------------
-(void) sessionMAP_Invoke_Ind:(UMASN1Object *)param
                       userId:(UMGSMMAP_UserIdentifier *)xuserIdentifier
                       dialog:(UMGSMMAP_DialogIdentifier *)xdialogId
                  transaction:(NSString *)xtcapTransactionId
                       opCode:(UMLayerGSMMAP_OpCode *)xopcode
                     invokeId:(int64_t)xinvokeId
                     linkedId:(int64_t)xlinkedId
                         last:(BOOL)xlast
                      options:(NSDictionary *)xoptions;

-(void) sessionMAP_Invoke_Ind_Log:(UMASN1Object *)param
                           userId:(UMGSMMAP_UserIdentifier *)xuserIdentifier
                           dialog:(UMGSMMAP_DialogIdentifier *)xdialogId
                      transaction:(NSString *)xtcapTransactionId
                           opCode:(UMLayerGSMMAP_OpCode *)xopcode
                         invokeId:(int64_t)xinvokeId
                         linkedId:(int64_t)xlinkedId
                             last:(BOOL)xlast
                          options:(NSDictionary *)xoptions;

- (void) sessionMAP_ReturnResult_Log:(UMASN1Object *)xparam
                              dialog:(UMGSMMAP_DialogIdentifier *)dialogId
                            invokeId:(int64_t)xinvokeId
                            linkedId:(int64_t)xlinkedId
                              opCode:(UMLayerGSMMAP_OpCode *)xopcode
                                last:(int64_t)xlast
                             options:(NSDictionary *)xoptions;


-(void) sessionMAP_ReturnResult_Resp:(UMASN1Object *)param
                              userId:(UMGSMMAP_UserIdentifier *)xuserIdentifier
                              dialog:(UMGSMMAP_DialogIdentifier *)xdialogId
                         transaction:(NSString *)xtcapTransactionId
                              opCode:(UMLayerGSMMAP_OpCode *)xopcode
                            invokeId:(int64_t)xinvokeId
                            linkedId:(int64_t)xlinkedId
                                last:(BOOL)xlast
                             options:(NSDictionary *)xoptions;

- (void) sessionMAP_ReturnError_Resp:(UMASN1Object *)param
                              userId:(UMGSMMAP_UserIdentifier *)xuserIdentifier
                              dialog:(UMGSMMAP_DialogIdentifier *)xdialogId
                         transaction:(NSString *)xtcapTransactionId
                              opCode:(UMLayerGSMMAP_OpCode *)xopcode
                            invokeId:(int64_t)xinvokeId
                            linkedId:(int64_t)xlinkedId
                           errorCode:(int64_t)err
                             options:(NSDictionary *)xoptions;

- (void) sessionMAP_Reject_Resp:(UMASN1Object *)param
                         userId:(UMGSMMAP_UserIdentifier *)xuserIdentifier
                         dialog:(UMGSMMAP_DialogIdentifier *)xdialogId
                    transaction:(NSString *)xtcapTransactionId
                         opCode:(UMLayerGSMMAP_OpCode *)xopcode
                       invokeId:(int64_t)xinvokeId
                       linkedId:(int64_t)xlinkedId
                      errorCode:(int64_t)err
                        options:(NSDictionary *)xoptions;

- (void) sessionMAP_Open_Ind:(UMGSMMAP_UserIdentifier *)xuserIdentifier
                      dialog:(UMGSMMAP_DialogIdentifier *)xdialogId
                 transaction:(NSString *)xtcapLocalTransactionId
           remoteTransaction:(NSString *)xtcapRemoteTransactionId
                         map:(id<UMLayerGSMMAP_ProviderProtocol>)map
                     variant:(UMTCAP_Variant)xvariant
              callingAddress:(SccpAddress *)src
               calledAddress:(SccpAddress *)dst
             dialoguePortion:(UMTCAP_asn1_dialoguePortion *)xdialoguePortion
                     options:(NSDictionary *)xoptions;

- (void) sessionMAP_Open_Resp:(UMGSMMAP_UserIdentifier *)userIdentifier
                       dialog:(UMGSMMAP_DialogIdentifier *)dialogId
                  transaction:(NSString *)xtcapLocalTransactionId
            remoteTransaction:(NSString *)xtcapRemoteTransactionId
                          map:(id<UMLayerGSMMAP_ProviderProtocol>)map
                      variant:(UMTCAP_Variant)xvariant
               callingAddress:(SccpAddress *)src
                calledAddress:(SccpAddress *)dst
              dialoguePortion:(UMTCAP_asn1_dialoguePortion *)xdialoguePortion
                      options:(NSDictionary *)options;

-(void)sessionMAP_Delimiter_Ind:(UMGSMMAP_UserIdentifier *)userIdentifier
                         dialog:(UMGSMMAP_DialogIdentifier *)dialogId
                 callingAddress:(SccpAddress *)src
                  calledAddress:(SccpAddress *)dst
                dialoguePortion:(UMTCAP_asn1_dialoguePortion *)xdialoguePortion
                  transactionId:(NSString *)localTransactionId
            remoteTransactionId:(NSString *)remoteTransactionId
                        options:(NSDictionary *)options;

-(void)sessionMAP_Continue_Ind:(UMGSMMAP_UserIdentifier *)userIdentifier
                callingAddress:(SccpAddress *)src
                 calledAddress:(SccpAddress *)dst
               dialoguePortion:(UMTCAP_asn1_dialoguePortion *)xdialoguePortion
                 transactionId:(NSString *)localTransactionId
           remoteTransactionId:(NSString *)remoteTransactionId
                       options:(NSDictionary *)options;

-(void)sessionMAP_Unidirectional_Ind:(NSDictionary *)options
                      callingAddress:(SccpAddress *)src
                       calledAddress:(SccpAddress *)dst
                     dialoguePortion:(UMTCAP_asn1_dialoguePortion *)xdialoguePortion
                       transactionId:(NSString *)localTransactionId
                 remoteTransactionId:(NSString *)remoteTransactionId;

-(void)sessionMAP_Close_Ind:(UMGSMMAP_UserIdentifier *)xuserIdentifier
                    options:(NSDictionary *)xoptions;
- (void) sessionMAP_Close_Req:(UMGSMMAP_UserIdentifier *)xuserIdentifier
                      options:(NSDictionary *)xoptions;
/*
 -(void) sessionMAP_U_Abort_Req:(UMGSMMAP_UserIdentifier *)xuserIdentifier
 options:(NSDictionary *)options;
 */
-(void)sessionMAP_U_Abort_Ind:(UMGSMMAP_UserIdentifier *)xuserIdentifier
               callingAddress:(SccpAddress *)src
                calledAddress:(SccpAddress *)dst
              dialoguePortion:(UMTCAP_asn1_dialoguePortion *)xdialoguePortion
                transactionId:(NSString *)xlocalTransactionId
          remoteTransactionId:(NSString *)xremoteTransactionId
                      options:(NSDictionary *)xoptions;

-(void)sessionMAP_P_Abort_Ind:(UMGSMMAP_UserIdentifier *)xuserIdentifier
               callingAddress:(SccpAddress *)src
                calledAddress:(SccpAddress *)dst
              dialoguePortion:(UMTCAP_asn1_dialoguePortion *)xdialoguePortion
                transactionId:(NSString *)xlocalTransactionId
          remoteTransactionId:(NSString *)xremoteTransactionId
                      options:(NSDictionary *)xoptions;

-(void) sessionMAP_Notice_Ind:(UMGSMMAP_UserIdentifier *)userIdentifier
                      options:(NSDictionary *)options;

-(void) sessionMAP_Notice_Ind:(UMGSMMAP_UserIdentifier *)userIdentifier
            tcapTransactionId:(NSString *)localTransactionId
                       reason:(SCCP_ReturnCause)reason
                      options:(NSDictionary *)options;


//--------------------------------------------------------------------------------------------

- (void)logWebSession;

+ (void)webFormStart:(NSMutableString *)s title:(NSString *)t;
+ (void)webFormEnd:(NSMutableString *)s;

+ (void)webMapTitle:(NSMutableString *)s;
+ (void)webDialogTitle:(NSMutableString *)s;
+ (void)webDialogOptions:(NSMutableString *)s;

+ (void)webTcapTitle:(NSMutableString *)s;
+ (void)webVariousTitle:(NSMutableString *)s;
+ (void)webTcapOptions:(NSMutableString *)s
            appContext:(NSString *)ac
        appContextName:(NSString *)acn;

+ (void)webSccpTitle:(NSMutableString *)s;
+ (void)webSccpOptions:(NSMutableString *)s
        callingComment:(NSString *)callingComment
         calledComment:(NSString *)calledComment
            callingSSN:(NSString *)callingSSN
             calledSSN:(NSString *)calledSSN;
+ (void)webMtp3Title:(NSMutableString *)s;
+ (void)webMtp3Options:(NSMutableString *)s;

- (UMMTP3Variant)mtp3Variant;
- (SccpVariant)sccpVariant;
- (void)touch;
- (void)timeout; /* gets called when timeouts occur */
- (void)abort;
- (void)abortUnknown;
- (BOOL)isTimedOut;
- (void)writeTraceToDirectory:(NSString *)dir;
- (void)dump:(NSFileHandle *)filehandler;
@end


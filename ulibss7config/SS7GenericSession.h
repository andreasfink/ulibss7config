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

typedef enum SS7MultiInvokeVariant
{
    SS7MultiInvokeVariant_off = 0,
    SS7MultiInvokeVariant_together = 1,
    SS7MultiInvokeVariant_one_by_one = 2,
    SS7MultiInvokeVariant_together_same_id = 3,
    SS7MultiInvokeVariant_together_same_id_different_second = 4,
    SS7MultiInvokeVariant_invoke5 = 5,
    SS7MultiInvokeVariant_invoke6 = 6,
    SS7MultiInvokeVariant_invoke7 = 7,
    SS7MultiInvokeVariant_invoke8 = 8,
} SS7MultiInvokeVariant;

@interface SS7GenericSession : UMLayerTask<UMSCCP_TraceProtocol>
{
    UMGSMMAP_UserIdentifier *_userIdentifier;
    BOOL                    _hasEnded;
    NSString                *_hasEndedReason;
    NSDate                  *_hasEndedTime;
    UMASN1Object            *_query;
    UMASN1Object            *_query2;
    UMASN1Object            *_query3;
    UMLayerGSMMAP_OpCode    *_opcode;
    UMLayerGSMMAP_OpCode    *_opcode2;
    UMLayerGSMMAP_OpCode    *_opcode3;
    int64_t                 _invokeId;
    int64_t                 _invokeId2;
    int64_t                 _invokeId3;
    SS7GenericInstance      *_gInstance;
    SccpAddress             *_initialLocalAddress;
    SccpAddress             *_localAddress;
    SccpAddress             *_initialRemoteAddress;
    SccpAddress             *_remoteAddress;

    UMHTTPRequest           *_req;
    NSDate                  *_startTime;
    UMAtomicDate            *_lastActiveTime;
    NSTimeInterval          _timeoutInSeconds;

    NSMutableDictionary         *_options;
    UMTCAP_asn1_objectIdentifier *_applicationContext;
    UMTCAP_asn1_objectIdentifier *_incomingApplicationContext;
    UMASN1BitString             *_dialogProtocolVersion;
    NSMutableArray              *_sccp_sent;
    NSMutableArray              *_sccp_received;
    BOOL                        _sccpTracefileEnabled;
    BOOL                        _sccpDebugEnabled;
    UMPCAPFile                  *_pcap;
    UMTCAP_asn1_dialoguePortion *_incomingDialogPortion;
    UMTCAP_asn1_userInformation *_userInfo;
    UMTCAP_asn1_userInformation *_incomingUserInfo;
    UMGSMMAP_DialogIdentifier   *_dialogId;
    BOOL                        _doEnd;
    UMTCAP_Variant              _tcapVariant;
    NSString                    *_tcapLocalTransactionId;
    NSString                    *_tcapRemoteTransactionId;
    NSArray<NSString *>         *_tcapOptions;
    NSDictionary                *_incomingOptions;
    UMSynchronizedArray         *_components;
    int                         _nowait;
    BOOL                        _undefinedSession;
    NSString                    *_sessionName;
    int                         _firstInvokeId;
    UMASN1Object                *_firstInvoke;
    UMASN1Object                *_firstResponse;
    int                         _secondInvokeId;
    UMASN1Object                *_secondInvoke;
    UMASN1Object                *_secondResponse;
    int                         _mapVersion;
    int                         _appContextByte;
    UMLogLevel                  _logLevel;
    UMMutex                     *_operationMutex;
    UMHistoryLog                *_historyLog;
    BOOL                        _outgoing;
    BOOL                        _incoming;
    BOOL                        _missingSriSm;
    OutputFormat                _outputFormat;
    UMGSMMAP_MAP_OpenInfo       *_incoming_map_open;
    NSInteger                   _hasReceivedInvokes;
    int                         _phase;
    BOOL                        _keepOriginalSccpAddressForTcapContinue;
    NSString                    *_tcap_operation_global;
    SS7MultiInvokeVariant       _multi_invoke_variant;
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

@property(readwrite,strong,atomic)    UMGSMMAP_UserIdentifier *userIdentifier;
@property(readwrite,assign,atomic)    BOOL                    hasEnded;
@property(readwrite,strong,atomic)    NSString                *hasEndedReason;
@property(readwrite,strong,atomic)    NSDate                  *hasEndedTime;
@property(readwrite,strong,atomic)    UMASN1Object            *query;
@property(readwrite,strong,atomic)    UMASN1Object            *query2;
@property(readwrite,strong,atomic)    UMASN1Object            *query3;
@property(readwrite,strong,atomic)    UMLayerGSMMAP_OpCode    *opcode;
@property(readwrite,strong,atomic)    UMLayerGSMMAP_OpCode    *opcode2;
@property(readwrite,strong,atomic)    UMLayerGSMMAP_OpCode    *opcode3;
@property(readwrite,strong,atomic)    UMLayerGSMMAP_OpCode    *firstResponseOpcode;
@property(readwrite,strong,atomic)    UMLayerGSMMAP_OpCode    *firstInvokeOpcode;
@property(readwrite,strong,atomic)    UMLayerGSMMAP_OpCode    *secondResponseOpcode;
@property(readwrite,strong,atomic)    UMLayerGSMMAP_OpCode    *secondInvokeOpcode;
@property(readwrite,strong,atomic)    SS7GenericInstance      *gInstance;
@property(readwrite,strong,atomic)    SccpAddress             *initialLocalAddress;
@property(readwrite,strong,atomic)    SccpAddress             *initialRemoteAddress;
@property(readwrite,strong,atomic)    SccpAddress             *localAddress;
@property(readwrite,strong,atomic)    SccpAddress             *remoteAddress;
@property(readwrite,strong,atomic)    UMHTTPRequest           *req;
@property(readwrite,strong,atomic)    NSDate                  *startTime;
@property(readwrite,strong,atomic)    UMAtomicDate            *lastActiveTime;
@property(readwrite,assign,atomic)    NSTimeInterval          timeoutInSeconds;
@property(readwrite,strong,atomic)    NSMutableDictionary         *options;
@property(readwrite,strong,atomic)    UMTCAP_asn1_objectIdentifier *applicationContext;
@property(readwrite,strong,atomic)    UMTCAP_asn1_objectIdentifier *incomingApplicationContext;
@property(readwrite,strong,atomic)    UMASN1BitString             *dialogProtocolVersion;
@property(readwrite,strong,atomic)    NSMutableArray              *sccp_sent;
@property(readwrite,strong,atomic)    NSMutableArray              *sccp_received;
@property(readwrite,assign,atomic)    BOOL                        sccpTracefileEnabled;
@property(readwrite,assign,atomic)    BOOL                        sccpDebugEnabled;
@property(readwrite,strong,atomic)    UMPCAPFile                  *pcap;
@property(readwrite,strong,atomic)    UMTCAP_asn1_dialoguePortion *incomingDialogPortion;
@property(readwrite,strong,atomic)    UMTCAP_asn1_userInformation *userInfo;
@property(readwrite,strong,atomic)    UMTCAP_asn1_userInformation *incomingUserInfo;
@property(readwrite,strong,atomic)    UMGSMMAP_DialogIdentifier   *dialogId;
@property(readwrite,assign,atomic)    BOOL                        doEnd;
@property(readwrite,assign,atomic)    UMTCAP_Variant              tcapVariant;
@property(readwrite,strong,atomic)    NSString                    *tcapLocalTransactionId;
@property(readwrite,strong,atomic)    NSString                    *tcapRemoteTransactionId;
@property(readwrite,strong,atomic)    NSArray<NSString *>         *tcapOptions;
@property(readwrite,strong,atomic)    NSDictionary                *incomingOptions;
@property(readwrite,strong,atomic)    UMSynchronizedArray         *components;
@property(readwrite,assign,atomic)    int                         nowait;
@property(readwrite,assign,atomic)    BOOL                        undefinedSession;
@property(readwrite,strong,atomic)    NSString                    *sessionName;
@property(readwrite,assign,atomic)    int                         firstInvokeId;
@property(readwrite,strong,atomic)    UMASN1Object                *firstInvoke;
@property(readwrite,strong,atomic)    UMASN1Object                *firstResponse;
@property(readwrite,assign,atomic)    int                         secondInvokeId;
@property(readwrite,strong,atomic)    UMASN1Object                *secondInvoke;
@property(readwrite,strong,atomic)    UMASN1Object                *secondResponse;
@property(readwrite,assign,atomic)    int                         mapVersion;
@property(readwrite,assign,atomic)    int                         appContextByte;
@property(readwrite,assign,atomic)    UMLogLevel                  logLevel;
@property(readwrite,strong,atomic)    UMMutex                     *operationMutex;
@property(readwrite,strong,atomic)    UMHistoryLog                *historyLog;
@property(readwrite,assign,atomic)    BOOL                        outgoing;
@property(readwrite,assign,atomic)    BOOL                        incoming;
@property(readwrite,assign,atomic)    BOOL                        missingSriSm;
@property(readwrite,assign,atomic)    OutputFormat                outputFormat;
@property(readwrite,strong,atomic)    UMGSMMAP_MAP_OpenInfo       *incoming_map_open;
@property(readwrite,assign,atomic)    NSInteger                   hasReceivedInvokes;
@property(readwrite,assign,atomic)    int                         phase;
@property(readwrite,assign,atomic)    BOOL                        keepOriginalSccpAddressForTcapContinue;
@property(readwrite,assign,atomic)    SS7MultiInvokeVariant       multi_invoke_variant;
@property(readwrite,strong,atomic)    NSString *tcap_operation_global;
@property(readwrite,strong,atomic)    NSString *callingssn;
@property(readwrite,strong,atomic)    NSString *calledssn;
@property(readwrite,strong,atomic)    NSString *callingaddress;
@property(readwrite,strong,atomic)    NSString *calledaddress;
@property(readwrite,strong,atomic)    NSString *callingtt;
@property(readwrite,strong,atomic)    NSString *calledtt;
@property(readwrite,strong,atomic)    NSString *opc;
@property(readwrite,strong,atomic)    NSString *dpc;
@property(readwrite,assign,atomic)    int sls;
@property(readwrite,assign,atomic)    int64_t operation;
@property(readwrite,assign,atomic)    int64_t operation2;
@property(readwrite,assign,atomic)    int64_t operation3;
@property(readwrite,assign,atomic)    int64_t firstResponseOperation;
@property(readwrite,assign,atomic)    int64_t firstInvokeOperation;

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
- (void)markForTermination:(NSString *)reason;

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
- (void)logDebug:(NSString *)str;
- (void)logInfo:(NSString *)str;
- (void)logMajorError:(NSString *)str;
- (void)logMinorError:(NSString *)str;

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



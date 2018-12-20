//
//  SS7AppDelegate.h
//  ulibss7config
//
//  Created by Andreas Fink on 13.11.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import <ulibgsmmap/ulibgsmmap.h>
#import <ulibcamel/ulibcamel.h>
#import <ulibsms/ulibsms.h>
#import <ulibtransport/ulibtransport.h>
#import <schrittmacherclient/schrittmacherclient.h>
#import "UMSS7ConfigObject.h"
#import "SS7TelnetSocketHelperProtocol.h"
#import "SS7UserAuthenticateProtocol.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMTTask.h"
#import "/usr/local/include/uliblicense//uliblicense.h"

#import "SS7TemporaryImsiPool.h"
#import "SS7TelnetSocketHelperProtocol.h"

@class ConfigurationSocket;
@class SchrittmacherClient;
@class UMSS7ConfigStorage;
@class SccpDestination;
@class SS7AppTransportHandler;
@class ApiSession;
@class SS7TemporaryImsiPool;
@class SS7GenericInstance;

typedef enum SchrittmacherMode
{
    SchrittmacherMode_unknown    = 0,
    SchrittmacherMode_hot        = 1,
    SchrittmacherMode_standby    = 2,
} SchrittmacherMode;

#ifdef __APPLE__
/* this is for unit tests to work in Xcode */
#import <cocoa/cocoa.h>
@interface SS7AppDelegate : UMObject<UMHTTPServerHttpGetPostDelegate,
UMHTTPServerAuthenticateRequestDelegate,
UMLayerUserProtocol,
NSApplicationDelegate,
UMHTTPServerHttpOptionsDelegate,
UMLayerSctpApplicationContextProtocol,
UMLayerM2PAApplicationContextProtocol,
UMLayerMTP3ApplicationContextProtocol,
UMLayerSCCPApplicationContextProtocol,
UMLayerTCAPApplicationContextProtocol,
UMLayerGSMMAPApplicationContextProtocol,
SS7TelnetSocketHelperProtocol,
SS7UserAuthenticateProtocol,
UMSS7ConfigAppDelegateProtocol>
#else
@interface SS7AppDelegate : UMObject<UMHTTPServerHttpGetPostDelegate,
UMHTTPServerAuthenticateRequestDelegate,
UMLayerUserProtocol,
UMHTTPServerHttpOptionsDelegate,
UMLayerSctpApplicationContextProtocol,
UMLayerM2PAApplicationContextProtocol,
UMLayerMTP3ApplicationContextProtocol,
UMLayerSCCPApplicationContextProtocol,
UMLayerTCAPApplicationContextProtocol,
UMLayerGSMMAPApplicationContextProtocol,
SS7TelnetSocketHelperProtocol,
SS7UserAuthenticateProtocol,
UMSS7ConfigAppDelegateProtocol>
#endif
{
    NSDictionary                *_enabledOptions;
    UMSynchronizedDictionary    *_smscSessions;
    UMCommandLine               *_commandLine;
    SchrittmacherClient         *_schrittmacherClient;
    NSString                    *_schrittmacherResourceID;
    SchrittmacherMode           _schrittmacherMode;
    UMSS7ConfigStorage          *_startupConfig;
    UMSS7ConfigStorage          *_runningConfig;
    UMLogHandler                *_logHandler;
    UMLogLevel                  _logLevel;
    UMHTTPClient                *_webClient;
    
    UMSynchronizedDictionary    *_sctp_dict;
    UMSynchronizedDictionary    *_m2pa_dict;
    UMSynchronizedDictionary    *_mtp3_dict;
    UMSynchronizedDictionary    *_sccp_dict;
    UMSynchronizedDictionary    *_sccp_destinations_dict;
    UMSynchronizedDictionary    *_sccp_number_translations_dict;
    UMSynchronizedDictionary    *_mtp3_link_dict;
    UMSynchronizedDictionary    *_mtp3_linkset_dict;
    UMSynchronizedDictionary    *_mtp3_route_dict;
    UMSynchronizedDictionary    *_m3ua_as_dict;
    UMSynchronizedDictionary    *_m3ua_asp_dict;
    UMSynchronizedDictionary    *_webserver_dict;
    UMSynchronizedDictionary    *_telnet_dict;
    UMSynchronizedDictionary    *_syslog_destination_dict;
    UMSynchronizedDictionary    *_apiSessions;
    UMSynchronizedDictionary    *_tcap_dict;
    UMSynchronizedDictionary    *_gsmmap_dict;
    UMSynchronizedDictionary    *_camel_dict;
    UMSynchronizedDictionary    *_imsi_pools_dict;
    UMSynchronizedDictionary    *_hlr_dict;
    UMSynchronizedDictionary    *_msc_dict;
    UMSynchronizedDictionary    *_vlr_dict;
    UMSynchronizedDictionary    *_eir_dict;
    UMSynchronizedDictionary    *_gsmscf_dict;
	UMSynchronizedDictionary    *_gmlc_dict;
	UMSynchronizedDictionary    *_estp_dict;

	UMSynchronizedDictionary	*_pendingUMT;/* FIXME: is this really needed anymore ?*/
    SS7AppTransportHandler      *_appTransport;
	UMLicenseDirectory       	*_globalLicenseDirectory;
	UMTransportService       	*_umtransportService;
	UMMutex                  	*_umtransportLock;

    NSString                    *_logDirectory;
    int                         _logRotations;
    int                         _concurrentTasks;
    NSString                    *_hostname;
    NSUInteger                  _queueHardLimit;
    UMTCAP_TransactionIdPool    *_tidPool;
    ConfigurationSocket         *_csListener;
    BOOL                        _startInStandby;
    
    UMSocketSCTPRegistry        *_registry;
    int                         _must_quit;

    int                         _concurrentThreads;
    UMTaskQueueMulti            *_generalTaskQueue;
    UMTaskQueueMulti            *_sctpTaskQueue;
    UMTaskQueueMulti            *_m2paTaskQueue;
    UMTaskQueueMulti            *_m3uaTaskQueue;
    UMTaskQueueMulti            *_mtp3TaskQueue;
    UMTaskQueueMulti            *_sccpTaskQueue;
    UMTaskQueueMulti            *_tcapTaskQueue;
    UMTaskQueueMulti            *_gsmmapTaskQueue;
}

@property(readwrite,assign)     UMLogLevel      logLevel;
@property(readwrite,strong)     UMLogHandler    *logHandler;
@property(readwrite,assign)     BOOL            startInStandby;


@property(readwrite,strong)     NSDictionary		*enabledOptions;
@property(readwrite,strong)     UMCommandLine		*commandLine;
@property(readwrite,strong)     SchrittmacherClient	*schrittmacherClient;
@property(readwrite,strong)     NSString			*schrittmacherResourceID;
@property(readwrite,assign)     SchrittmacherMode   schrittmacherMode;
@property(readwrite,strong)     UMSS7ConfigStorage	*startupConfig;
@property(readwrite,strong)     UMSS7ConfigStorage	*runningConfig;
@property(readwrite,strong)     UMTaskQueueMulti	*generalTaskQueue;
@property(readwrite,strong)     NSDictionary		*staticWebPages;
@property(readwrite,strong)     UMHTTPClient		*webClient;

- (SS7AppDelegate *)initWithOptions:(NSDictionary *)options;
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification;
- (void)applicationWillTerminate:(NSNotification *)aNotification;

- (void)applicationGoToHot;
- (void)applicationGoToStandby;
- (UMHTTPAuthenticationStatus)httpAuthenticateRequest:(UMHTTPRequest *)req
                                                realm:(NSString **)realm;

- (void)processCommandLine:(int)argc argv:(const char **)argv;
- (void)signal_SIGINT;
- (void)signal_SIGHUP;  /* reopen logfile */
- (void)signal_SIGUSR1; /* go into Hot mode      */
- (void)signal_SIGUSR2;  /* go into Standby mode */

- (NSDictionary *)appDefinition; /* has to be overloaded */
- (NSArray *)commandLineSyntax;
- (NSString *)defaultConfigFile;
- (void) setupSignalHandlers;
- (int)main:(int)argc argv:(const char **)argv;
- (void) createInstances;
- (void)  handleStatus:(UMHTTPRequest *)req;
- (NSString *)defaultLogDirectory;
- (int)defaultWebPort;
- (NSString *)defaultWebUser;
- (NSString *)defaultWebPassword;
- (NSString *)productName;
- (NSString *)productVersion;
- (void)umobjectStat:(UMHTTPRequest *)req;
- (void)ummutexStat:(UMHTTPRequest *)req;
- (void)umtGetPost:(UMHTTPRequest *)req;
- (void)webHeader:(NSMutableString *)s title:(NSString *)t;


- (void)addPendingUMTTask:(UMTask *)task
				   dialog:(UMTCAP_UserDialogIdentifier *)_dialogId
				 invokeId:(int64_t)_invokeId;


- (void)addApiSession:(ApiSession *)session;
- (void)removeApiSession:(NSString *)sessionKey;
- (UMSS7ApiSession *)getApiSession:(NSString *)sessionKey;

- (NSString *)umtransportGetNewUserReference;

- (UMTTask *)getPendingUMTTaskForDialog:(UMTCAP_UserDialogIdentifier *)dialogId
							   invokeId:(int64_t)invokeId;
- (UMTTask *)getAndRemovePendingUMTTaskForDialog:(UMTCAP_UserDialogIdentifier *)dialogId
										invokeId:(int64_t)invokeId;



/* @Description : Modifies a Routing Table for a specific SCCP Layer to Registry
 @Param : New Configuration Object
 @Param : Old Configuration Object
 @see : Document q-713 SCCP Format Codes
 **/
- (UMSynchronizedSortedDictionary *)modifySCCPTranslationTable:(NSDictionary *)new_config
														   old:(NSDictionary *)old_config;

/* @Description : Activates/Deactivates a Routing Table
 @Param : Name of SCCP Layer
 @Param : Translation Type of Routing Table
 @Param : Global Title Indicator
 @Param : Numbering Plan
 @Param : Nature of Address Indicator
 @Param : on (YES or NO)
 @see : Document q-713 SCCP Format Codes
 **/
- (UMSynchronizedSortedDictionary *)activateSCCPTranslationTable:(NSString *)name
															  tt:(NSNumber *)tt
															 gti:(NSNumber *)gti
															  np:(NSNumber *)np
															 nai:(NSNumber *)nai
															  on:(BOOL)on;

/* @Description : Clone a Routing Table for a specific SCCP Layer to Registry
 @Param : Configuration Object
 @see : Document q-713 SCCP Format Codes
 **/
- (UMSynchronizedSortedDictionary *)cloneSCCPTranslationTable:(NSDictionary *)config;

/* @Description : Adds a Routing Table for a specific SCCP Layer to Registry
 @Param : Configuration Object
 @see : Document q-713 SCCP Format Codes
 **/
- (void)addSCCPTranslationTable:(NSDictionary *)config;




/* @Description : Removes a Routing Table for a specific SCCP Layer from its Registry
 @Param : Name of SCCP Layer
 @Param : Translation Type of Routing Table
 @Param : Global Title Indicator
 @Param : Numbering Plan
 @Param : Nature of Address Indicator
 @see : Document q-713 SCCP Format Codes
 **/
- (void)deleteSCCPTranslationTable:(NSString *)name
								tt:(NSNumber *)tt
							   gti:(NSNumber *)gti
								np:(NSNumber *)np
							   nai:(NSNumber *)nai;

/* @Description : Returns a Routing Table for a specific SCCP Layer from its Registry
 @Param : Name of SCCP Layer
 @Param : Translation Type of Routing Table
 @Param : Global Title Indicator
 @Param : Numbering Plan
 @Param : Nature of Address Indicator
 @see : Document q-713 SCCP Format Codes
 **/




- (NSNumber *)concurrentTasksForConfig:(UMSS7ConfigObject *)co;

/************************************************************/
#pragma mark -
#pragma mark IMSI Pool Service Functions
/************************************************************/

- (SS7TemporaryImsiPool *)getIMSIPool:(NSString *)name;
- (void)addWithConfigIMSIPool:(NSDictionary *)config;
- (void)deleteIMSIPool:(NSString *)name;
- (void)renameIMSIPool:(NSString *)oldName to:(NSString *)newName;
@end


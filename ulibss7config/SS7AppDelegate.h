//
//  SS7AppDelegate.h
//  ulibss7config
//
//  Created by Andreas Fink on 13.11.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import <ulibgsmmap/ulibgsmmap.h>
#import <ulibcamel/ulibcamel.h>
#import <ulibdiameter/ulibdiameter.h>
#import <ulibsms/ulibsms.h>
#import <ulibtransport/ulibtransport.h>
#import <schrittmacherclient/schrittmacherclient.h>
#import "UMSS7ConfigObject.h"
#import "SS7TelnetSocketHelperProtocol.h"
#import "SS7UserAuthenticateProtocol.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMTTask.h"

#import "UMSS7FilterRuleSet.h"
#import "UMSS7FilterRule.h"
#import "UMSS7FilterActionList.h"
#import "UMSS7FilterAction.h"

#ifdef	HAS_ULIBLICENSE

#ifdef __APPLE__
#import "/Library/Application Support/FinkTelecomServices/frameworks/uliblicense/uliblicense.h"
#else
#import <uliblicense/uliblicense.h>
#endif

#endif //HAS_ULIBLICENSE

#import "SS7TemporaryImsiPool.h"
#import "SS7TelnetSocketHelperProtocol.h"

@class ConfigurationSocket;
@class SchrittmacherClient;
@class UMSS7ConfigStorage;
@class UMSS7ConfigSS7FilterStagingArea;
@class SccpDestination;
@class SS7AppTransportHandler;
@class ApiSession;
@class SS7TemporaryImsiPool;
@class SS7GenericInstance;
@class DiameterGenericInstance;
@class UMSS7ConfigSS7FilterTraceFile;

typedef enum SchrittmacherMode
{
    SchrittmacherMode_unknown    = 0,
    SchrittmacherMode_hot        = 1,
    SchrittmacherMode_standby    = 2,
} SchrittmacherMode;

#ifdef __APPLE__
/* this is for unit tests to work in Xcode */
#import <cocoa/cocoa.h>
#endif

@interface SS7AppDelegate : UMObject<UMHTTPServerHttpGetPostDelegate,
UMHTTPServerAuthenticateRequestDelegate,
UMLayerUserProtocol,
#ifdef __APPLE__
NSApplicationDelegate,
#endif
UMHTTPServerHttpOptionsDelegate,
UMLayerSctpApplicationContextProtocol,
UMLayerM2PAApplicationContextProtocol,
UMLayerMTP3ApplicationContextProtocol,
UMLayerSCCPApplicationContextProtocol,
UMLayerTCAPApplicationContextProtocol,
UMLayerGSMMAPApplicationContextProtocol,
SS7TelnetSocketHelperProtocol,
SS7UserAuthenticateProtocol,
UMSS7ConfigAppDelegateProtocol,
UMTransportUserProtocol,
UMDiameterPeerAppDelegateProtocol,
UMDiameterRouterAppDelegateProtocol>
{
    /* first all pointers... then integers. Workaround for a bug in clang...? */
    NSDictionary                *_enabledOptions;
    UMSynchronizedDictionary    *_smscSessions;
    UMCommandLine               *_commandLine;
    SchrittmacherClient         *_schrittmacherClient;
    NSString                    *_schrittmacherResourceID;
    UMSS7ConfigStorage          *_startupConfig;
    UMSS7ConfigStorage          *_runningConfig;
    UMLogHandler                *_logHandler;
    UMHTTPClient                *_webClient;
    UMSynchronizedDictionary    *_sctp_dict;
    UMSynchronizedDictionary    *_m2pa_dict;
    UMSynchronizedDictionary    *_mtp3_dict;
    UMSynchronizedDictionary    *_sccp_dict;
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
    UMSynchronizedDictionary    *_smsc_dict;
    UMSynchronizedDictionary    *_vlr_dict;
    UMSynchronizedDictionary    *_eir_dict;
    UMSynchronizedDictionary    *_gsmscf_dict;
	UMSynchronizedDictionary    *_gmlc_dict;
	UMSynchronizedDictionary    *_estp_dict;
    UMSynchronizedDictionary    *_diameter_connections_dict;
    UMSynchronizedDictionary    *_diameter_router_dict;
    UMSynchronizedDictionary    *_smsproxy_dict;
	UMSynchronizedDictionary 	*_ss7FilterStagingAreas_dict;

	UMSynchronizedDictionary	*_pendingUMT;/* FIXME: is this really needed anymore ?*/
    SS7AppTransportHandler      *_appTransport;
#ifdef	HAS_ULIBLICENSE
	UMLicenseDirectory       	*_globalLicenseDirectory;
#endif
	UMTransportService       	*_umtransportService;
	UMMutex                  	*_umtransportLock;
    NSString                    *_logDirectory;
    NSString                    *_hostname;
    UMTCAP_TransactionIdPool    *_tidPool;
    ConfigurationSocket         *_csListener;
    UMSocketSCTPRegistry        *_registry;
    UMTaskQueueMulti            *_generalTaskQueue;
    UMTaskQueueMulti            *_sctpTaskQueue;
    UMTaskQueueMulti            *_m2paTaskQueue;
    UMTaskQueueMulti            *_m3uaTaskQueue;
    UMTaskQueueMulti            *_mtp3TaskQueue;
    UMTaskQueueMulti            *_sccpTaskQueue;
    UMTaskQueueMulti            *_tcapTaskQueue;
    UMTaskQueueMulti            *_gsmmapTaskQueue;
    UMTaskQueueMulti            *_diameterTaskQueue;
    SchrittmacherMode           _schrittmacherMode;
    UMLogLevel                  _logLevel;
    int                         _must_quit;
    int                         _logRotations;
    int                         _concurrentThreads;
    int                         _concurrentTasks;
    NSUInteger                  _queueHardLimit;
    BOOL                        _startInStandby;
    NSString                    *_stagingAreaPath;
    NSString                    *_filterEnginesPath;
    NSString                    *_statisticsPath;

    NSDate                      *_applicationStart;
    DiameterGenericInstance     *_mainDiameterInstance;
    SS7GenericInstance			*_mainCamelInstance;
	SS7GenericInstance			*_mainMapInstance;
    UMSynchronizedDictionary     *_namedLists;
    UMMutex                     *_namedListLock;
    NSString                    *_namedListsDirectory;

    UMSynchronizedDictionary    *_ss7TraceFiles;
    UMMutex                     *_ss7TraceFilesLock;
    NSString                    *_ss7TraceFilesDirectory;
    UMTimer                     *_apiHousekeepingTimer;


    UMSynchronizedDictionary     *_statistics_dict;
    UMTimer                     *_dirtyTimer;

    UMSynchronizedDictionary    *_active_ruleset_dict;
    UMSynchronizedDictionary    *_active_action_list_dict;
    UMSynchronizedDictionary    *_ss7FilterEngines;

    UMSS7ConfigSS7FilterStagingArea *_activeStagingArea;
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
@property(readwrite,strong)     UMTaskQueueMulti    *generalTaskQueue;
@property(readwrite,strong)     UMTaskQueueMulti    *sctpTaskQueue;
@property(readwrite,strong)     UMTaskQueueMulti    *m2paTaskQueue;
@property(readwrite,strong)     UMTaskQueueMulti    *m3uaTaskQueue;
@property(readwrite,strong)     UMTaskQueueMulti    *mtp3TaskQueue;
@property(readwrite,strong)     UMTaskQueueMulti    *sccpTaskQueue;
@property(readwrite,strong)     UMTaskQueueMulti    *tcapTaskQueue;
@property(readwrite,strong)     UMTaskQueueMulti    *gsmmapTaskQueue;
@property(readwrite,strong)     UMTaskQueueMulti    *diameterTaskQueue;
@property(readwrite,strong)     NSDictionary		*staticWebPages;
@property(readwrite,strong)     UMHTTPClient		*webClient;
@property(readwrite,strong)     NSDate              *applicationStart;
@property(readwrite,strong)     NSString            *stagingAreaPath;
@property(readwrite,strong)     UMSynchronizedDictionary *ss7FilterEngines;
@property(readwrite,strong)     DiameterGenericInstance     *mainDiameterInstance;
@property(readwrite,strong)     UMSynchronizedDictionary     *namedLists;

#ifdef	HAS_ULIBLICENSE
@property(readwrite,strong)		UMLicenseDirectory 			*globalLicenseDirectory;
#endif


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

- (NSString *)defaultApiUser;
- (NSString *)defaultApiPassword;
- (NSString *)defaultLicensePath;
- (NSString *)defaultFilterEnginesPath;
- (NSString *)defaultStatisticsPath;
- (NSString *)defaultStagingAreaPath;
- (NSString *)defaultNamedListPath;
- (NSString *)defaultTracefilesPath;

- (NSString *)productName;
- (NSString *)productVersion;
- (void)umobjectStat:(UMHTTPRequest *)req;
- (void)ummutexStat:(UMHTTPRequest *)req;
- (void)umtGetPost:(UMHTTPRequest *)req;
- (void)webHeader:(NSMutableString *)s title:(NSString *)t;
- (void)handleRouteTest:(UMHTTPRequest *)req;


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
#pragma mark Diameter Peer Functions
/************************************************************/

- (UMDiameterPeer *)getDiameterConnection:(NSString *)name;
- (NSArray *)getDiameterConnectionNames;
- (void)addWithConfigDiameterConnection:(NSDictionary *)config;
- (void)deleteDiameterConnection:(NSString *)name;
- (void)renameDiameterConnection:(NSString *)oldName to:(NSString *)newName;

/************************************************************/
#pragma mark -
#pragma mark Diameter Router Functions
/************************************************************/

- (UMDiameterRouter *)getDiameterRouter:(NSString *)name;
- (NSArray *)getDiameterRouterNames;
- (void)addWithConfigDiameterRouter:(NSDictionary *)config;
- (void)deleteDiameterRouter:(NSString *)name;
- (void)renameDiameterRouter:(NSString *)oldName to:(NSString *)newName;


/************************************************************/
#pragma mark -
#pragma mark IMSI Pool Service Functions
/************************************************************/

- (SS7TemporaryImsiPool *)getIMSIPool:(NSString *)name;
- (void)addWithConfigIMSIPool:(NSDictionary *)config;
- (void)deleteIMSIPool:(NSString *)name;
- (void)renameIMSIPool:(NSString *)oldName to:(NSString *)newName;

- (NSArray *)getSCCPNames;


- (void)hanldeSCCPRouteStatus:(UMHTTPRequest *)req;
- (void)handleMTP3RouteStatus:(UMHTTPRequest *)req;
- (void)handleM2PAStatus:(UMHTTPRequest *)req;
- (void)handleM3UAStatus:(UMHTTPRequest *)req;
- (void)handleSCTPStatus:(UMHTTPRequest *)req;


/************************************************************/
#pragma mark -
#pragma mark Staging Area Service Functions
/************************************************************/


- (void)createSS7FilterStagingArea:(NSDictionary *)dict;
- (void)updateSS7FilterStagingArea:(NSDictionary *)dict;
- (void)selectSS7FilterStagingArea:(NSString *)name forSession:(UMSS7ApiSession *)session;
- (void)deleteSS7FilterStagingArea:(NSString *)name;
- (UMSS7ConfigSS7FilterStagingArea *)getStagingAreaForSession:(UMSS7ApiSession *)session;
- (BOOL)makeStagingAreaCurrent:(NSString *)name; /* returns YES on success */
- (NSArray<NSString *> *)getSS7FilterStagingAreaNames;
- (void)renameSS7FilterStagingArea:(NSString *)oldname newName:(NSString *)newname;
- (void)copySS7FilterStagingArea:(NSString *)oldname toNewName:(NSString *)newname;

/************************************************************/
#pragma mark -
#pragma mark Filter Engine Functions
/************************************************************/

- (NSArray *)getSS7FilterEngineNames;
- (void)addWithConfigSS7FilterEngine:(NSDictionary *)config; /* can throw exceptions */
- (void)loadSS7FilterEnginesFromDirectory:(NSString *)path;
- (UMPluginHandler *)getSS7FilterEngineHandler:(NSString *)name;


/************************************************************/
#pragma mark -
#pragma mark Named Lists Functions
/************************************************************/

- (UMSynchronizedArray *)namedlist_lists;
- (void)namedlist_add:(NSString *)listName value:(NSString *)value;
- (void)namedlist_remove:(NSString *)listName value:(NSString *)value;
- (BOOL)namedlist_contains:(NSString *)listName value:(NSString *)value;
- (void)namedlist_flushAll;
- (NSArray *)namedlist_get:(NSString *)listName;

/************************************************************/
#pragma mark -
#pragma mark Log File Functions
/************************************************************/

- (UMSynchronizedArray *)logfile_list;
- (void)logfile_remove:(NSString *)name;
- (void)logfile_enable:(NSString *)name enable:(BOOL)enable;
- (UMSS7ConfigSS7FilterTraceFile *)logfile_get:(NSString *)listName;
- (void)logfile_action:(NSString *)name action:(NSString *)enable;
- (void)logfile_add:(UMSynchronizedSortedDictionary *)conf;





/************************************************************/
#pragma mark -
#pragma mark Statistics
/************************************************************/

- (NSArray *)getStatisticsNames;
- (void)statistics_add:(NSString *)name params:(NSDictionary *)dict;
- (void)statistics_modify:(NSString *)name params:(NSDictionary *)dict;
- (void)statistics_remove:(NSString *)name;
- (void)loadStatisticsFromPath:(NSString *)directory;
- (void)statistics_flushAll;
- (UMStatistic *)statistics_get:(NSString *)name;


@end


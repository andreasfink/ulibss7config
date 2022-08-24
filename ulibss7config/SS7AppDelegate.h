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
#import <ulibdb/ulibdb.h>
#import <umscript/umscript.h>
#import "UMSS7ConfigObject.h"
#import "SS7TelnetSocketHelperProtocol.h"
#import "SS7UserAuthenticateProtocol.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMTTask.h"

#import "UMSS7ConfigSS7FilterRuleSet.h"
#import "UMSS7ConfigSS7FilterRule.h"
#import "UMSS7ConfigSS7FilterActionList.h"
#import "UMSS7ConfigSS7FilterAction.h"
#import "UMSS7TraceFile.h"

#ifdef __APPLE__
#import "/Library/Application Support/FinkTelecomServices/frameworks/uliblicense/uliblicense.h"
#else
#import <uliblicense/uliblicense.h>
#endif

#import "SS7TemporaryImsiPool.h"
#import "SS7TelnetSocketHelperProtocol.h"

@class ConfigurationSocket;
@class SchrittmacherClient;
@class UMSS7ConfigStorage;
@class UMSS7ConfigSS7FilterStagingArea;
@class SccpDestinationEntry;
@class SS7AppTransportHandler;
@class ApiSession;
@class SS7TemporaryImsiPool;
@class SS7GenericInstance;
@class DiameterGenericInstance;
@class UMSS7ConfigSS7FilterTraceFile;
@class SmscConnection;

typedef enum SchrittmacherMode
{
    SchrittmacherMode_unknown    = 0,
    SchrittmacherMode_hot        = 1,
    SchrittmacherMode_standby    = 2,
} SchrittmacherMode;

#ifdef __APPLE__
/* this is for unit tests to work in Xcode */
#import <Cocoa/Cocoa.h>
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
UMLayerCamelApplicationContextProtocol,
SS7TelnetSocketHelperProtocol,
SS7UserAuthenticateProtocol,
UMSS7ConfigAppDelegateProtocol,
UMTransportUserProtocol,
UMDiameterPeerAppDelegateProtocol,
UMDiameterRouterAppDelegateProtocol,
UMSCCP_FilterDelegateProtocol,
UMEnvironmentNamedListProviderProtocol>
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
    UMSynchronizedDictionary    *_mtp3_pointcode_translation_tables_dict;
    UMSynchronizedDictionary    *_mtp3_tranlation_table_maps_dict;
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
    UMSynchronizedDictionary    *_ggsn_dict;
    UMSynchronizedDictionary    *_sgsn_dict;
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
    UMSynchronizedDictionary    *_smppListeners;
    UMSynchronizedDictionary    *_smppUserConnections;
    UMSynchronizedDictionary    *_smppProviderConnections;
	UMSynchronizedDictionary	*_pendingUMT;/* FIXME: is this really needed anymore ?*/
    
    UMSynchronizedDictionary     *_smsDeliveryProfiles;
    UMSynchronizedDictionary     *_smsCategorizerPluings;
    UMSynchronizedDictionary     *_smsPreRoutingFilterPlugins;
    UMSynchronizedDictionary     *_smsPreBillingFilterPlugins;
    UMSynchronizedDictionary     *_smsRoutingEnginePlugins;
    UMSynchronizedDictionary     *_smsPostRoutingFilterPlugins;
    UMSynchronizedDictionary     *_smsPostBillingPlugins;
    UMSynchronizedDictionary     *_smsDeliveryReportFilterPlugins;
    UMSynchronizedDictionary     *_smsCdrWriterPlugins;
    UMSynchronizedDictionary     *_smsStoragePlugins;

    SS7AppTransportHandler      *_appTransport;
	UMLicenseDirectory       	*_globalLicenseDirectory;
    UMLicenseProductFeature     *_coreFeature;
    UMLicenseProductFeature     *_sctpFeature;
    UMLicenseProductFeature     *_m2paFeature;
    UMLicenseProductFeature     *_mtp3Feature;
    UMLicenseProductFeature     *_m3uaFeature;
    UMLicenseProductFeature     *_sccpFeature;
    UMLicenseProductFeature     *_tcapFeature;
    UMLicenseProductFeature     *_gsmmapFeature;
    UMLicenseProductFeature     *_smscFeature;
    UMLicenseProductFeature     *_smsproxyFeature;
    UMLicenseProductFeature     *_rerouterFeature;
    UMLicenseProductFeature     *_diameterFeature;
    UMLicenseProductFeature     *_gsmapiFeature;
    UMLicenseProductFeature     *_speedLimitFeature;
    double                      _speedLimit;
    
	UMTransportService       	*_umtransportService;
	UMMutex                  	*_umtransportLock;
    NSString                    *_logDirectory;
    NSString                    *_hostname;
    UMObject<UMTCAP_TransactionIdPoolProtocol>    *_applicationWideTransactionIdPool;
    ConfigurationSocket         *_csListener;
    UMSocketSCTPRegistry        *_registry;
    UMTaskQueueMulti            *_generalTaskQueue;
    UMTaskQueueMulti            *_sctpTaskQueue;
    //UMTaskQueueMulti            *_m2paTaskQueue;
    UMTaskQueueMulti            *_m3uaTaskQueue;
    UMTaskQueueMulti            *_mtp3TaskQueue;
    UMTaskQueueMulti            *_sccpTaskQueue;
    UMTaskQueueMulti            *_tcapTaskQueue;
    UMTaskQueueMulti            *_gsmmapTaskQueue;
    UMTaskQueueMulti            *_camelTaskQueue;
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
    NSString                    *_appsPath;

    NSDate                      *_applicationStart;
    DiameterGenericInstance     *_mainDiameterInstance;
    SS7GenericInstance			*_mainCamelInstance;
	SS7GenericInstance			*_mainMapInstance;
    UMLayerSCCP                 *_mainSccpInstance;
    NSMutableDictionary<NSString *,UMNamedList *>   *_namedLists; /* key = name, object type = UMNamedList */
    UMMutex                     *_namedListLock;
    NSString                    *_namedListsDirectory;

    UMSynchronizedDictionary    *_ss7TraceFiles; /* contains UMSS7TraceFile objects */
    NSString                    *_ss7TraceFilesDirectory;
    UMTimer                     *_apiHousekeepingTimer;
    UMSynchronizedDictionary    *_activeFilterRuleSets;


    UMSynchronizedDictionary     *_statistics_dict;
    UMTimer                     *_dirtyTimer;

    UMSynchronizedDictionary    *_active_ruleset_dict;
    UMSynchronizedDictionary    *_active_action_list_dict;
    UMSynchronizedDictionary    *_ss7FilterEngines;

    UMSS7ConfigSS7FilterStagingArea *_activeStagingArea;
    BOOL                    _filteringActive;
    UMSynchronizedDictionary *_incomingLinksetFilters; /* contains NSArray of NSStrings of UMSS7FilterRuleset names */
    UMSynchronizedDictionary *_outgoingLinksetFilters; /* contains NSArray of NSStrings of UMSS7FilterRuleset names */
    UMSynchronizedDictionary *_incomingLocalSubsystemFilters; /* contains NSArray of NSStrings of UMSS7FilterRuleset names */
    UMSynchronizedDictionary *_outgoingLocalSubsystemFilters; /* contains NSArray of NSStrings of UMSS7FilterRuleset names */

    UMSynchronizedDictionary    *_dbpool_dict;
    BOOL                        _dbStarted;
    UMTaskQueueMulti            *_databaseQueue;
    UMSynchronizedDictionary    *_cdrWriters_dict;
    NSTimeInterval              _sessionTimeout;
    UMLogFeed                   *_apiLogFeed;
    UMPrometheus                *_prometheus;
    long                        _appBuildNumber;
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
@property(readwrite,strong)     NSString            *statisticsPath;
@property(readwrite,strong)     NSString            *appsPath;
@property(readwrite,strong)     UMSynchronizedDictionary    *ss7FilterEngines;
@property(readwrite,strong)     DiameterGenericInstance     *mainDiameterInstance;
@property(readwrite,strong)     UMSynchronizedDictionary    *active_ruleset_dict;
@property(readwrite,strong)     UMSynchronizedDictionary    *active_action_list_dict;
@property(readwrite,strong)     UMSynchronizedDictionary     *statistics_dict;

@property(readwrite,strong)		UMLicenseDirectory 			*globalLicenseDirectory;
@property(readwrite,strong)     UMLicenseProductFeature     *coreFeature;
@property(readwrite,strong)     UMLicenseProductFeature     *sctpFeature;
@property(readwrite,strong)     UMLicenseProductFeature     *m2paFeature;
@property(readwrite,strong)     UMLicenseProductFeature     *mtp3Feature;
@property(readwrite,strong)     UMLicenseProductFeature     *m3uaFeature;
@property(readwrite,strong)     UMLicenseProductFeature     *sccpFeature;
@property(readwrite,strong)     UMLicenseProductFeature     *tcapFeature;
@property(readwrite,strong)     UMLicenseProductFeature     *gsmmapFeature;
@property(readwrite,strong)     UMLicenseProductFeature     *smscFeature;
@property(readwrite,strong)     UMLicenseProductFeature     *smsproxyFeature;
@property(readwrite,strong)     UMLicenseProductFeature     *rerouterFeature;
@property(readwrite,strong)     UMLicenseProductFeature     *diameterFeature;


@property(readwrite,strong)     UMSynchronizedDictionary     *smsDeliveryProfiles;
@property(readwrite,strong)     UMSynchronizedDictionary     *smsCategorizerPluings;
@property(readwrite,strong)     UMSynchronizedDictionary     *smsPreRoutingFilterPlugins;
@property(readwrite,strong)     UMSynchronizedDictionary     *smsPreBillingFilterPlugins;
@property(readwrite,strong)     UMSynchronizedDictionary     *smsRoutingEnginePlugins;
@property(readwrite,strong)     UMSynchronizedDictionary     *smsPostRoutingFilterPlugins;
@property(readwrite,strong)     UMSynchronizedDictionary     *smsPostBillingPlugins;
@property(readwrite,strong)     UMSynchronizedDictionary     *smsDeliveryReportFilterPlugins;
@property(readwrite,strong)     UMSynchronizedDictionary     *smsCdrWriterPlugins;
@property(readwrite,strong)     UMSynchronizedDictionary     *smsStoragePlugins;

@property(readwrite,strong)     UMSynchronizedDictionary    *traceFiles; /* contains UMSS7TraceFile objects */
@property(readwrite,strong)     UMSynchronizedDictionary    *cdrWriters_dict;
@property(readwrite,strong)     NSString                    *namedListsDirectory;
@property(readwrite,strong,atomic)  UMLogFeed               *apiLogFeed;
@property(readwrite,strong,atomic)  UMPrometheus            *prometheus;
@property(readwrite,assign,atomic)  long                    appBuildNumber;


- (SS7AppDelegate *)initWithOptions:(NSDictionary *)options;
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification;
- (void)applicationWillTerminate:(NSNotification *)aNotification;

- (void)applicationGoToHot;
- (void)applicationGoToStandby;
- (UMHTTPAuthenticationStatus)httpAuthenticateRequest:(UMHTTPRequest *)req
                                                realm:(NSString **)realm;
- (UMHTTPAuthenticationStatus)httpRequireAdminAuthorisation:(UMHTTPRequest *)req
                                                      realm:(NSString *)realm;

- (void)processCommandLine:(int)argc argv:(const char **)argv;
- (void)signal_SIGINT;
- (void)signal_SIGHUP;  /* reopen logfile and reload external configs */
- (void)signal_SIGUSR1; /* go into Hot mode      */
- (void)signal_SIGUSR2;  /* go into Standby mode */

- (NSDictionary *)appDefinition; /* has to be overloaded */
- (NSArray *)commandLineSyntax;
- (NSString *)defaultConfigFile;
- (void) setupSignalHandlers;
- (int)main:(int)argc argv:(const char **)argv;
- (void) createInstances;
- (void)  handleStatus:(UMHTTPRequest *)req;


- (void)  handleDecode:(UMHTTPRequest *)req;

- (void)  handleDecodeMtp3:(UMHTTPRequest *)req;
- (void)  handleDecodeSccp:(UMHTTPRequest *)req;
- (void)  handleDecodeTcap:(UMHTTPRequest *)req;
- (void)  handleDecodeTcap2:(UMHTTPRequest *)req;
- (void)  handleDecodeAsn1:(UMHTTPRequest *)req;
- (void)  handleDecodeSms:(UMHTTPRequest *)req;

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
- (NSString *)defaultAppsPath;


- (NSString *)productName;
- (NSString *)productVersion;
- (NSString *)productCopyright;

- (void)umobjectStat:(UMHTTPRequest *)req;
- (void)ummutexStat:(UMHTTPRequest *)req;
- (void)umtGetPost:(UMHTTPRequest *)req;
- (void)webHeader:(NSMutableString *)s title:(NSString *)t;
- (void)handleRouteTest:(UMHTTPRequest *)req;
- (void)handleDiameterRouteTest:(UMHTTPRequest *)req;


- (void)addPendingUMTTask:(UMTaskQueueTask *)task
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

- (NSArray <NSString *>*)getM2PANames;
- (NSArray <NSString *>*)getSCTPNames;
- (UMLayerSctp *)getSCTP:(NSString *)name;

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

- (NSArray<NSString *>*)namedlistsListNames;
- (void)namedlistReplaceList:(NSString *)listName withContentsOfFile:(NSString *)filename;
- (void)namedlistsFlushAll;
- (void)namedlistsLoadFromDirectory:(NSString *)directory;
- (void)namedlistAdd:(NSString *)listName value:(NSString *)value;
- (void)namedlistRemove:(NSString *)listName value:(NSString *)value;
- (BOOL)namedlistContains:(NSString *)listName value:(NSString *)value;
- (NSArray *)namedlistGetAllEntriesOfList:(NSString *)listName;
- (UMNamedList *)getNamedList:(NSString *)name;


/************************************************************/
#pragma mark -
#pragma mark Trace File Functions
/************************************************************/

- (UMSynchronizedArray *)tracefile_list;
- (void)tracefile_remove:(NSString *)name;
- (void)tracefile_enable:(NSString *)name enable:(BOOL)enable;
- (UMSS7ConfigSS7FilterTraceFile *)tracefile_get:(NSString *)listName;
- (void)tracefile_action:(NSString *)name action:(NSString *)enable;
- (void)tracefile_add:(UMSS7ConfigSS7FilterTraceFile *)conf;


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

/************************************************************/
#pragma mark -
#pragma mark Filter Packet
/************************************************************/

- (void) sccpDecodeTcapGsmmap:(UMSCCP_Packet *)packet;
- (UMSCCP_FilterResult)filterInbound:(UMSCCP_Packet *)packet;
- (UMSCCP_FilterResult)filterOutbound:(UMSCCP_Packet *)packet;
- (UMSCCP_FilterResult)filterToLocalSubsystem:(UMSCCP_Packet *)packet;
- (UMSCCP_FilterResult)filterFromLocalSubsystem:(UMSCCP_Packet *)packet;



/************************************************************/
#pragma mark -
#pragma mark Database functions
/************************************************************/


- (UMDbPool *)getDbPool:(NSString *)name;
- (UMSynchronizedDictionary *)dbPools;
- (void)startDatabaseConnections;
- (void) setupDatabaseTaskQueue;


/************************************************************/
#pragma mark -
#pragma mark SS7CDRWriter functions
/************************************************************/
- (SS7CDRWriter *)getCDRWriter:(NSString *)name;


/************************************************************/
#pragma mark -
#pragma mark Configuration Management
/************************************************************/

- (NSString *)exportRunningConfiguration;
- (NSString *)exportStartupConfiguration;
- (NSString *)writeCurrentConfigurationToStartup;

-(NSString *)filterEnginesPath;
-(id)licenseDirectory;
- (BOOL)increaseMaximumOpenFiles:(NSUInteger)count; /* returns YES if successful */

- (UMLayerCamel *)getCAMEL:(NSString *)name;
- (void)addWithConfigCAMEL:(NSDictionary *)config;
- (void)deleteCAMEL:(NSString *)name;
- (void)renameCAMEL:(NSString *)oldName to:(NSString *)newName;

@end


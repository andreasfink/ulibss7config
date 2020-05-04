//
//  UMSS7ConfigAppDelegateProtocol.h
//  ulibss7config
//
//  Created by Andreas Fink on 06.04.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import <ulib/ulib.h>
#import <ulibgsmmap/ulibgsmmap.h>
#import <ulibdb/ulibdb.h>
#import <umscript/umscript.h>

@class UMSS7ConfigStorage;
@class UMSS7ApiSession;
@class UMSS7ConfigSS7FilterStagingArea;
@class UMSS7ConfigSS7FilterTraceFile;
@class SS7CDRWriter;
@class UMDiameterRouter;

@protocol UMSS7ConfigAppDelegateProtocol<NSObject,
    UMLayerSctpApplicationContextProtocol,
    UMLayerM2PAApplicationContextProtocol,
    UMLayerMTP3ApplicationContextProtocol,
    UMLayerSCCPApplicationContextProtocol,
    UMEnvironmentNamedListProviderProtocol>

@property(readwrite,strong,atomic)  UMSS7ConfigStorage *runningConfig;
@property(readwrite,strong,atomic)  UMSS7ConfigStorage *startupConfig;
@property(readwrite,strong,atomic)  UMCommandLine *commandLine;
- (void)applicationGoToHot;
- (void)applicationGoToStandby;

- (UMHTTPAuthenticationStatus)httpAuthenticateRequest:(UMHTTPRequest *)req
realm:(NSString **)realm;

- (UMLayerSctp *)getSCTP:(NSString *)name;
- (void)addWithConfigSCTP:(NSDictionary *)config;
- (void)deleteSCTP:(NSString *)name;
- (void)renameSCTP:(NSString *)old to:(NSString *)new;

- (UMLayerM2PA *)getM2PA:(NSString *)name;
- (void)addWithConfigM2PA:(NSDictionary *)config;
- (void)deleteM2PA:(NSString *)name;
- (void)renameM2PA:(NSString *)old to:(NSString *)new;

- (UMLayerMTP3 *)getMTP3:(NSString *)name;
- (void)addWithConfigMTP3:(NSDictionary *)config;
- (void)deleteMTP3:(NSString *)name;
- (void)renameMTP3:(NSString *)old to:(NSString *)new;


- (NSArray<NSString *> *)getMTP3PointCodeTranslationTables;
- (UMMTP3PointCodeTranslationTable *)getMTP3PointCodeTranslationTable:(NSString *)name;
- (void)addWithConfigMTP3PointCodeTranslationTable:(NSDictionary *)config;
- (void)deleteMTP3PointCodeTranslationTable:(NSString *)name;
- (void)renameMTP3PointCodeTranslationTable:(NSString *)oldName to:(NSString *)newName;

- (UMMTP3Link *)getMTP3Link:(NSString *)name;
- (void)addWithConfigMTP3Link:(NSDictionary *)config;
- (void)deleteMTP3Link:(NSString *)name;
- (void)renameMTP3Link:(NSString *)old to:(NSString *)new;

- (UMMTP3LinkSet *)getMTP3LinkSet:(NSString *)name;
- (void)addWithConfigMTP3LinkSet:(NSDictionary *)config;
- (void)deleteMTP3LinkSet:(NSString *)name;
- (void)renameMTP3LinkSet:(NSString *)old to:(NSString *)new;

- (UMM3UAApplicationServer *)getM3UAAS:(NSString *)name;
- (void)addWithConfigM3UAAS:(NSDictionary *)config;
- (void)deleteM3UAAS:(NSString *)name;
- (void)renameM3UAAS:(NSString *)old to:(NSString *)new;

- (UMM3UAApplicationServerProcess *)getM3UAASP:(NSString *)name;
- (void)addWithConfigM3UAASP:(NSDictionary *)config;
- (void)deleteM3UAASP:(NSString *)name;
- (void)renameM3UAASP:(NSString *)old to:(NSString *)new;

- (UMLayerSCCP *)getSCCP:(NSString *)name;
- (NSArray *)getSCCPNames;
- (void)addWithConfigSCCP:(NSDictionary *)config;
- (void)deleteSCCP:(NSString *)name;
- (void)renameSCCP:(NSString *)old to:(NSString *)new;

- (void)deleteSCCPTranslationTable:(NSString *)name
								   tt:(NSNumber *)tt
								   gti:(NSNumber *)gti
								   np:(NSNumber *)np
								   nai:(NSNumber *)nai;
								   
- (UMSynchronizedSortedDictionary *)readSCCPTranslationTable:(NSString *)name
								   tt:(NSNumber *)tt
								   gti:(NSNumber *)gti
								   np:(NSNumber *)np
								   nai:(NSNumber *)nai;	
								   
- (UMSynchronizedSortedDictionary *)statusSCCPTranslationTable:(NSString *)name
									tt:(NSNumber *)tt
									gti:(NSNumber *)gti
									np:(NSNumber *)np
									nai:(NSNumber *)nai;								   

- (void)addApiSession:(UMSS7ApiSession *)session;
- (void)removeApiSession:(NSString *)sessionKey;
- (UMSS7ApiSession *)getApiSession:(NSString *)sessionKey;
- (UMSynchronizedDictionary *)getAllSessionsSessions;

- (UMLayerTCAP *)getTCAP:(NSString *)name;
- (void)addWithConfigTCAP:(NSDictionary *)config;
- (void)deleteTCAP:(NSString *)name;
- (void)renameTCAP:(NSString *)old to:(NSString *)new;

- (UMLayerGSMMAP *)getGSMMAP:(NSString *)name;
- (void)addWithConfigGSMMAP:(NSDictionary *)config;
- (void)deleteGSMMAP:(NSString *)name;
- (void)renameGSMMAP:(NSString *)old to:(NSString *)new;

- (UMSynchronizedSortedDictionary *)modifySCCPTranslationTable:(NSDictionary *)new_config
                                                           old:(NSDictionary *)old_config;

- (UMSynchronizedSortedDictionary *)activateSCCPTranslationTable:(NSString *)name
                                                              tt:(NSNumber *)tt
                                                             gti:(NSNumber *)gti
                                                              np:(NSNumber *)np
                                                             nai:(NSNumber *)nai
                                                              on:(BOOL)on;

- (UMSynchronizedSortedDictionary *)cloneSCCPTranslationTable:(NSDictionary *)config;

/************************************************************/
#pragma mark -
#pragma mark Staging Area Functions
/************************************************************/

- (void)createSS7FilterStagingArea:(NSDictionary *)dict;
- (void)updateSS7FilterStagingArea:(NSDictionary *)dict;
- (void)selectSS7FilterStagingArea:(NSString *)name forSession:(UMSS7ApiSession *)session;
- (void)deleteSS7FilterStagingArea:(NSString *)name;
- (UMSS7ConfigSS7FilterStagingArea *)getStagingAreaForSession:(UMSS7ApiSession *)session;
- (void)makeStagingAreaCurrent:(NSString *)name;
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
/* this is now taken care of in UMEnvironmentNamedListProviderProtocol from umscript
- (UMSynchronizedArray *)namedlist_lists;
- (void)namedlist_add:(NSString *)listName value:(NSString *)value;
- (void)namedlist_remove:(NSString *)listName value:(NSString *)value;
- (BOOL)namedlist_contains:(NSString *)listName value:(NSString *)value;
- (void)loadNamedListsFromPath:(NSString *)directory;
- (void)namedlist_flushAll;
- (NSArray *)namedlist_get:(NSString *)listName;

*/
/************************************************************/
#pragma mark -
#pragma mark Log File Functions
/************************************************************/

- (UMSynchronizedArray *)tracefile_list;
- (void)tracefile_remove:(NSString *)name;
- (void)tracefile_enable:(NSString *)name enable:(BOOL)enable;
- (UMSS7ConfigSS7FilterTraceFile *)tracefile_get:(NSString *)listName;
- (void)tracefile_action:(NSString *)name action:(NSString *)enable;
- (void)tracefile_add:(UMSS7ConfigSS7FilterTraceFile *)conf;


/************************************************************/
#pragma mark -
#pragma mark Statistics Functions
/************************************************************/

- (NSArray *)getStatisticsNames;
- (void)statistics_add:(NSString *)name params:(NSDictionary *)dict;
- (void)statistics_modify:(NSString *)name params:(NSDictionary *)dict;
- (void)statistics_remove:(NSString *)name;
- (void)loadStatisticsFromPath:(NSString *)directory;
- (void)statistics_flushAll;
- (UMStatistic *)statistics_get:(NSString *)name;

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
#pragma mark CDRWriter functions
/************************************************************/

- (SS7CDRWriter *)getCDRWriter:(NSString *)name;

/************************************************************/
#pragma mark -
#pragma mark Configuration Management
/************************************************************/

- (NSString *)exportRunningConfiguration;
- (NSString *)exportStartupConfiguration;
- (NSString *)writeCurrentConfigurationToStartup;


/************************************************************/
#pragma mark -
#pragma mark Diameter
/************************************************************/
- (UMDiameterRouter *)getDiameterRouter:(NSString *)name;

@end

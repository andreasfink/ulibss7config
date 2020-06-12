//
//  UMSS7ConfigStorage.h
//  estp
//
//  Created by Andreas Fink on 01.02.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import <ulib/ulib.h>

@class  UMSS7ConfigGeneral;
@class  UMSS7ConfigSCTP;
@class  UMSS7ConfigM2PA;
@class  UMSS7ConfigMTP3;
@class  UMSS7ConfigMTP3Filter;
@class  UMSS7ConfigMTP3FilterDict;
@class  UMSS7ConfigMTP3LinkSet;
@class  UMSS7ConfigMTP3Link;
@class  UMSS7ConfigM3UAAS;
@class  UMSS7ConfigM3UAASP;
@class  UMSS7ConfigMTP3Route;
@class  UMSS7ConfigMTP3PointCodeTranslationTable;
@class  UMSS7ConfigMTP3PointCodeTranslationTableEntry;
@class  UMSS7ConfigSCCP;
@class  UMSS7ConfigSCCPFilter;
@class  UMSS7ConfigSCCPFilterDict;
@class  UMSS7ConfigSCCPTranslationTable;
@class  UMSS7ConfigSCCPTranslationTableEntry;
@class  UMSS7ConfigSCCPDestination;
@class  UMSS7ConfigSCCPDestinationEntry;
@class  UMSS7ConfigTCAP;
@class  UMSS7ConfigTCAPFilter;
@class  UMSS7ConfigTCAPFilterDict;
@class  UMSS7ConfigGSMMAP;
@class  UMSS7ConfigGSMMAPFilter;
@class  UMSS7ConfigGSMMAPFilterDict;
@class  UMSS7ConfigSMS;
@class  UMSS7ConfigSMSFilter;
@class  UMSS7ConfigSMSFilterDict;
@class  UMSS7ConfigWebserver;
@class  UMSS7ConfigTelnet;
@class  UMSS7ConfigSyslogDestination;
@class  UMSS7ConfigHLR;
@class  UMSS7ConfigMSC;
@class  UMSS7ConfigGGSN;
@class  UMSS7ConfigSGSN;
@class  UMSS7ConfigVLR;
@class  UMSS7ConfigGSMSCF;
@class  UMSS7ConfigGMLC;
@class  UMSS7ConfigSMSC;
@class  UMSS7ConfigSMSProxy;
@class  UMSS7ConfigAdminUser;
@class  UMSS7ConfigDatabasePool;
@class UMSS7ConfigGSMSCF;
@class UMSS7ConfigEIR;
@class UMSS7ConfigSCCPNumberTranslation;
@class UMSS7ConfigServiceUser;
@class UMSS7ConfigServiceUserProfile;
@class UMSS7ConfigServiceBillingEntity;
@class UMSS7ConfigSMSProxy;
@class UMSS7ConfigESTP;
@class UMSS7ConfigMAPI;
@class UMSS7ConfigIMSIPool;
@class UMSS7ConfigCdrWriter;
@class UMSS7ConfigSCCPTranslationTableMap;
@class UMSS7ConfigApiUser;
@class UMSS7ConfigDiameterConnection;
@class UMSS7ConfigDiameterRouter;
@class UMSS7ConfigDiameterRoute;
@class UMSS7ConfigCAMEL;
@class UMSS7ConfigMnpDatabase;

@interface UMSS7ConfigStorage : UMObject
{
    NSArray                 *_commandLineArguments;
    UMCommandLine           *_commandLine;
    UMSS7ConfigGeneral      *_generalConfig;

    UMSynchronizedSortedDictionary *_webserver_dict;
    UMSynchronizedSortedDictionary *_telnet_dict;
    UMSynchronizedSortedDictionary *_syslog_destination_dict;
    UMSynchronizedSortedDictionary *_sctp_dict;
    UMSynchronizedSortedDictionary *_m2pa_dict;
    UMSynchronizedSortedDictionary *_mtp3_dict;
    UMSynchronizedSortedDictionary *_mtp3_route_dict;
    UMSynchronizedSortedDictionary *_mtp3_filter_dict;
    UMSynchronizedSortedDictionary *_mtp3_link_dict;
    UMSynchronizedSortedDictionary *_mtp3_linkset_dict;
    UMSynchronizedSortedDictionary *_mtp3_pctrans_dict;
    UMSynchronizedSortedDictionary *_m3ua_as_dict;
    UMSynchronizedSortedDictionary *_m3ua_asp_dict;
    UMSynchronizedSortedDictionary *_sccp_dict;
    UMSynchronizedSortedDictionary *_sccp_filter_dict;
    UMSynchronizedSortedDictionary *_sccp_destination_dict;
    UMSynchronizedSortedDictionary *_sccp_translation_table_dict;
    UMSynchronizedSortedDictionary *_sccp_translation_table_entry_dict;
    UMSynchronizedSortedDictionary *_sccp_translation_table_map_dict;
    UMSynchronizedSortedDictionary *_tcap_dict;
    UMSynchronizedSortedDictionary *_tcap_filter_dict;
    UMSynchronizedSortedDictionary *_gsmmap_dict;
    UMSynchronizedSortedDictionary *_gsmmap_filter_dict;
    UMSynchronizedSortedDictionary *_sms_dict;
    UMSynchronizedSortedDictionary *_sms_filter_dict;
    UMSynchronizedSortedDictionary *_hlr_dict;
    UMSynchronizedSortedDictionary *_msc_dict;
    UMSynchronizedSortedDictionary *_ggsn_dict;
    UMSynchronizedSortedDictionary *_sgsn_dict;
    UMSynchronizedSortedDictionary *_vlr_dict;
    UMSynchronizedSortedDictionary *_gsmscf_dict;
    UMSynchronizedSortedDictionary *_gmlc_dict;
    UMSynchronizedSortedDictionary *_eir_dict;
    UMSynchronizedSortedDictionary *_smsc_dict;
    UMSynchronizedSortedDictionary *_admin_user_dict;
    UMSynchronizedSortedDictionary *_api_user_dict;
    UMSynchronizedSortedDictionary *_database_pool_dict;
    UMSynchronizedSortedDictionary *_sccp_number_translation_dict;
    UMSynchronizedSortedDictionary *_service_user_dict;
    UMSynchronizedSortedDictionary *_service_billing_entity_dict;
    UMSynchronizedSortedDictionary *_service_user_profile_dict;
    UMSynchronizedSortedDictionary *_smsproxy_dict;
    UMSynchronizedSortedDictionary *_estp_dict;
    UMSynchronizedSortedDictionary *_mapi_dict;
    UMSynchronizedSortedDictionary *_imsi_pool_dict;
    UMSynchronizedSortedDictionary *_cdr_writer_dict;
    UMSynchronizedSortedDictionary *_diameter_connection_dict;
    UMSynchronizedSortedDictionary *_diameter_router_dict;
    UMSynchronizedSortedDictionary *_diameter_route_dict;
    UMSynchronizedSortedDictionary *_camel_dict;
    UMSynchronizedSortedDictionary *_mnpDatabases_dict;
    NSString                 *_rwconfigFile;
    UMTimer                  *_dirtyTimer;
    NSString                 *_productName;
    BOOL                    _dirty;
    BOOL                    _autowrite;
}

@property(readwrite,strong,atomic)  NSArray *commandLineArguments;
@property(readwrite,strong,atomic)  UMCommandLine *commandLine;
@property(readwrite,strong,atomic)  UMSS7ConfigGeneral *generalConfig;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *webserver_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *telnet_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *syslog_destination_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *sctp_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *m2pa_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *mtp3_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *mtp3_route_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *mtp3_filter_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *mtp3_link_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *mtp3_linkset_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *mtp3_pctrans_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *m3ua_as_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *m3ua_asp_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *sccp_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *sccp_filter_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *sccp_destination_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *sccp_translation_table_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *sccp_translation_table_entry_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *sccp_translation_table_map_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *tcap_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *tcap_filter_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *gsmmap_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *gsmmap_filter_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *sms_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *sms_filter_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *hlr_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *msc_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *ggsn_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *sgsn_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *vlr_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *gsmscf_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *gmlc_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *eir_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *smsc_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *admin_user_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *api_user_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *database_pool_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *sccp_number_translation_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *service_user_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *service_billing_entity_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *service_user_profile_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *smsproxy_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *estp_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *mapi_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *imsi_pool_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *cdr_writer_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *diameter_connection_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *diameter_router_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *diameter_route_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *camel_dict;
@property(readwrite,strong,atomic)  UMSynchronizedSortedDictionary *mnpDatabases_dict;

@property(readwrite,strong,atomic)  NSString *rwconfigFile;
@property(readwrite,strong,atomic)  NSString *productName;
@property(readwrite,assign,atomic)  BOOL dirty;
@property(readwrite,assign,atomic)  BOOL autowrite;

- (void)startDirtyTimer;
- (void)stopDirtyTimer;

- (void)touch;
- (UMSS7ConfigStorage *)copyWithZone:(NSZone *)zone;

- (UMSS7ConfigStorage *)initWithCommandLine:(UMCommandLine *)cmd;
- (UMSS7ConfigStorage *)initWithCommandLine:(UMCommandLine *)cmd defaultConfigFileName:(NSString *)defaultCfgFile;

- (void)writeConfigToDirectory:(NSString *)dir usingFilename:(NSString *)main_config_file_name singleFile:(BOOL)compact;

- (NSString *)configString;
- (UMSynchronizedSortedDictionary *)fullConfigOjbect;

- (NSArray *)getSCTPNames;
- (UMSS7ConfigSCTP *)getSCTP:(NSString *)name;
- (NSString *)addSCTP:(UMSS7ConfigSCTP*)sctp;
- (NSString *)replaceSCTP:(UMSS7ConfigSCTP *)sctp;
- (NSString *)deleteSCTP:(NSString *)name;

- (NSArray *)getM2PANames;
- (UMSS7ConfigM2PA *)getM2PA:(NSString *)name;
- (NSString *)addM2PA:(UMSS7ConfigM2PA*)m2pa;
- (NSString *)replaceM2PA:(UMSS7ConfigM2PA *)m2pa;
- (NSString *)deleteM2PA:(NSString *)name;

- (NSArray *)getMTP3Names;
- (UMSS7ConfigMTP3 *)getMTP3:(NSString *)name;
- (NSString *)addMTP3:(UMSS7ConfigMTP3*)mtp3;
- (NSString *)replaceMTP3:(UMSS7ConfigMTP3 *)mtp3;
- (NSString *)deleteMTP3:(NSString *)name;

- (NSArray *)getMTP3RouteNames;
- (UMSS7ConfigMTP3Route *)getMTP3Route:(NSString *)name;
- (NSString *)addMTP3Route:(UMSS7ConfigMTP3Route*)mtp3route;
- (NSString *)replaceMTP3Route:(UMSS7ConfigMTP3Route *)mtp3route;
- (NSString *)deleteMTP3Route:(NSString *)name;

- (NSArray *)getMTP3FilterNames;
- (UMSS7ConfigMTP3Filter *)getMTP3Filter:(NSString *)name;
- (NSString *)addMTP3Filter:(UMSS7ConfigMTP3Filter *)mtp3Filter;
- (NSString *)replaceMTP3Filter:(UMSS7ConfigMTP3Filter *)mtp3Filter;
- (NSString *)deleteMTP3Filter:(NSString *)name;

- (NSArray *)getMTP3LinkNames;
- (UMSS7ConfigMTP3Link *)getMTP3Link:(NSString *)name;
- (NSString *)addMTP3Link:(UMSS7ConfigMTP3Link*)mtp3_link;
- (NSString *)replaceMTP3Link:(UMSS7ConfigMTP3Link *)mtp3_link;
- (NSString *)deleteMTP3Link:(NSString *)name;

- (NSArray *)getMTP3LinkSetNames;
- (UMSS7ConfigMTP3LinkSet *)getMTP3LinkSet:(NSString *)name;
- (NSString *)addMTP3LinkSet:(UMSS7ConfigMTP3LinkSet*)mtp3_linkset;
- (NSString *)replaceMTP3LinkSet:(UMSS7ConfigMTP3LinkSet *)mtp3_linkset;
- (NSString *)deleteMTP3LinkSet:(NSString *)name;

- (NSArray *)getM3UAASNames;
- (UMSS7ConfigM3UAAS *)getM3UAAS:(NSString *)name;
- (NSString *)addM3UAAS:(UMSS7ConfigM3UAAS*)m3ua_as;
- (NSString *)replaceM3UAAS:(UMSS7ConfigM3UAAS *)m3ua_as;
- (NSString *)deleteM3UAAS:(NSString *)name;

- (NSArray *)getM3UAASPNames;
- (UMSS7ConfigM3UAASP *)getM3UAASP:(NSString *)name;
- (NSString *)addM3UAASP:(UMSS7ConfigM3UAASP*)m3ua_asp;
- (NSString *)replaceM3UAASP:(UMSS7ConfigM3UAASP *)m3ua_asp;
- (NSString *)deleteM3UAASP:(NSString *)name;

- (NSArray *)getSCCPNames;- (UMSS7ConfigSCCP *)getSCCP:(NSString *)name;
- (NSString *)addSCCP:(UMSS7ConfigSCCP*)sccp;
- (NSString *)replaceSCCP:(UMSS7ConfigSCCP *)sccp;
- (NSString *)deleteSCCP:(NSString *)name;

- (NSArray *)getSCCPFilterNames;
- (UMSS7ConfigSCCPFilter *)getSCCPFilter:(NSString *)name;
- (NSString *)addSCCPFilter:(UMSS7ConfigSCCPFilter*)sccpFilter;
- (NSString *)replaceSCCPFilter:(UMSS7ConfigSCCPFilter *)sccpFilter;
- (NSString *)deleteSCCPFilter:(NSString *)name;

- (NSArray *)getSCCPDestinationNames;
- (UMSS7ConfigSCCPDestination *)getSCCPDestination:(NSString *)name;
- (NSString *)addSCCPDestination:(UMSS7ConfigSCCPDestination*)sccp_destination;
- (NSString *)replaceSCCPDestination:(UMSS7ConfigSCCPDestination *)sccp_destination;
- (NSString *)deleteSCCPDestination:(NSString *)name;

- (NSArray *)getSCCPTranslationTableNames;
- (UMSS7ConfigSCCPTranslationTable *)getSCCPTranslationTable:(NSString *)name;
- (NSString *)addSCCPTranslationTable:(UMSS7ConfigSCCPTranslationTable*)sccp_destination;
- (NSString *)replaceSCCPTranslationTable:(UMSS7ConfigSCCPTranslationTable *)sccp_destination;
- (NSString *)deleteSCCPTranslationTable:(NSString *)name;

- (NSArray *)getSCCPTranslationTableEntryNames;
- (UMSS7ConfigSCCPTranslationTableEntry *)getSCCPTranslationTableEntry:(NSString *)name;
- (NSString *)addSCCPTranslationTableEntry:(UMSS7ConfigSCCPTranslationTableEntry *)entry;
- (NSString *)replaceSCCPTranslationTableEntry:(UMSS7ConfigSCCPTranslationTableEntry *)entry;
- (NSString *)deleteSCCPTranslationTableEntry:(NSString *)name;

- (NSArray *)getSCCPTranslationTableMap;
- (UMSS7ConfigSCCPTranslationTableMap *)getSCCPTranslationTableMap:(NSString *)name;
- (NSString *)addSCCPTranslationTableMap:(UMSS7ConfigSCCPTranslationTableMap *)sccp_destination;
- (NSString *)replaceSCCPTranslationTableMap:(UMSS7ConfigSCCPTranslationTableMap *)sccp_destination;
- (NSString *)deleteSCCPTranslationTableMap:(NSString *)name;

- (NSArray *)getTCAPNames;
- (UMSS7ConfigTCAP *)getTCAP:(NSString *)name;
- (NSString *)addTCAP:(UMSS7ConfigTCAP *)tcap;
- (NSString *)replaceTCAP:(UMSS7ConfigTCAP *)tcap;
- (NSString *)deleteTCAP:(NSString *)name;

- (NSArray *)getTCAPFilterNames;
- (UMSS7ConfigTCAPFilter *)getTCAPFilter:(NSString *)name;
- (NSString *)addTCAPFilter:(UMSS7ConfigTCAPFilter *)tcapFilter;
- (NSString *)replaceTCAPFilter:(UMSS7ConfigTCAPFilter *)tcapFilter;
- (NSString *)deleteTCAPFilter:(NSString *)name;

- (NSArray *)getGSMMAPNames;
- (UMSS7ConfigGSMMAP *)getGSMMAP:(NSString *)name;
- (NSString *)addGSMMAP:(UMSS7ConfigGSMMAP *)tcap;
- (NSString *)replaceGSMMAP:(UMSS7ConfigGSMMAP *)tcap;
- (NSString *)deleteGSMMAP:(NSString *)name;

- (NSArray *)getGSMMAPFilterNames;
- (UMSS7ConfigGSMMAPFilter  *)getGSMMAPFilter:(NSString *)name;
- (NSString *)addGSMMAPFilter :(UMSS7ConfigGSMMAPFilter  *)gsmmapFilter;
- (NSString *)replaceGSMMAPFilter :(UMSS7ConfigGSMMAPFilter  *)gsmmapFilter;
- (NSString *)deleteGSMMAPFilter :(NSString *)name;

- (NSArray *)getHLRNames;
- (UMSS7ConfigHLR *)getHLR:(NSString *)name;
- (NSString *)addHLR:(UMSS7ConfigHLR *)hlr;
- (NSString *)replaceHLR:(UMSS7ConfigHLR *)hlr;
- (NSString *)deleteHLR:(NSString *)name;

- (NSArray *)getMSCNames;
- (UMSS7ConfigMSC *)getMSC:(NSString *)name;
- (NSString *)addMSC:(UMSS7ConfigMSC *)msc;
- (NSString *)replaceMSC:(UMSS7ConfigMSC *)msc;
- (NSString *)deleteMSC:(NSString *)name;

- (NSArray *)getGGSNNames;
- (UMSS7ConfigGGSN *)getGGSN:(NSString *)name;
- (NSString *)addGGSN:(UMSS7ConfigGGSN *)msc;
- (NSString *)replaceGGSN:(UMSS7ConfigGGSN *)msc;
- (NSString *)deleteGGSN:(NSString *)name;

- (NSArray *)getSGSNNames;
- (UMSS7ConfigSGSN *)getSGSN:(NSString *)name;
- (NSString *)addSGSN:(UMSS7ConfigSGSN *)msc;
- (NSString *)replaceSGSN:(UMSS7ConfigSGSN *)msc;
- (NSString *)deleteSGSN:(NSString *)name;


- (NSArray *)getVLRNames;
- (UMSS7ConfigVLR *)getVLR:(NSString *)name;
- (NSString *)addVLR:(UMSS7ConfigVLR *)vlr;
- (NSString *)replaceVLR:(UMSS7ConfigVLR *)vlr;
- (NSString *)deleteVLR:(NSString *)name;

- (NSArray *)getSMSCNames;
- (UMSS7ConfigSMSC *)getSMSC:(NSString *)name;
- (NSString *)addSMSC:(UMSS7ConfigSMSC *)smsc;
- (NSString *)replaceSMSC:(UMSS7ConfigSMSC *)smsc;
- (NSString *)deleteSMSC:(NSString *)name;

- (NSArray *)getGSMSCFNames;
- (UMSS7ConfigGSMSCF *)getGSMSCF:(NSString *)name;
- (NSString *)addGSMSCF:(UMSS7ConfigGSMSCF *)gsmscf;
- (NSString *)replaceGSMSCF:(UMSS7ConfigGSMSCF *)gsmscf;
- (NSString *)deleteGSMSCF:(NSString *)name;

- (NSArray *)getGMLCNames;
- (UMSS7ConfigGMLC *)getGMLC:(NSString *)name;
- (NSString *)addGMLC:(UMSS7ConfigGMLC *)gmlc;
- (NSString *)replaceGMLC:(UMSS7ConfigGMLC *)gmlc;
- (NSString *)deleteGMLC:(NSString *)name;



- (NSArray *)getEIRNames;
- (UMSS7ConfigEIR *)getEIR:(NSString *)name;
- (NSString *)addEIR:(UMSS7ConfigEIR *)eir;
- (NSString *)replaceEIR:(UMSS7ConfigEIR *)eir;
- (NSString *)deleteEIR:(NSString *)name;

- (NSArray *)getESTPNames;
- (UMSS7ConfigESTP *)getESTP:(NSString *)name;
- (NSString *)addESTP:(UMSS7ConfigESTP *)eir;
- (NSString *)replaceESTP:(UMSS7ConfigESTP *)eir;
- (NSString *)deleteESTP:(NSString *)name;

- (NSArray *)getSMSProxyNames;
- (UMSS7ConfigSMSProxy *)getSMSProxy:(NSString *)name;
- (NSString *)addSMSProxy:(UMSS7ConfigSMSProxy *)rpoxy;
- (NSString *)replaceSMSProxy:(UMSS7ConfigSMSProxy *)proxy;
- (NSString *)deleteSMSProxy:(NSString *)name;


- (NSArray *)getMAPINames;
- (UMSS7ConfigMAPI *)getMAPI:(NSString *)name;
- (NSString *)addMAPI:(UMSS7ConfigMAPI *)eir;
- (NSString *)replaceMAPI:(UMSS7ConfigMAPI *)eir;
- (NSString *)deleteMAPI:(NSString *)name;

- (NSArray *)getSMSNames;
- (UMSS7ConfigSMS *)getSMS:(NSString *)name;
- (NSString *)addSMS:(UMSS7ConfigSMS *)sms;
- (NSString *)replaceSMS:(UMSS7ConfigSMS *)sms;
- (NSString *)deleteSMS:(NSString *)name;

- (NSArray *)getSMSFilterNames;
- (UMSS7ConfigSMSFilter *)getSMSFilter:(NSString *)name;
- (NSString *)addSMSFilter:(UMSS7ConfigSMSFilter *)smsFilter;
- (NSString *)replaceSMSFilter:(UMSS7ConfigSMSFilter *)smsFilter;
- (NSString *)deleteSMSFilter:(NSString *)name;

- (NSArray *)getWebserverNames;
- (UMSS7ConfigWebserver *)getWebserver:(NSString *)name;
- (NSString *)addWebserver:(UMSS7ConfigWebserver *)webserver;
- (NSString *)replaceWebserver:(UMSS7ConfigWebserver *)webserver;
- (NSString *)deleteWebserver:(NSString *)name;

- (NSArray *)getTelnetNames;
- (UMSS7ConfigTelnet *)getTelnet:(NSString *)name;
- (NSString *)addTelnet:(UMSS7ConfigTelnet *)telnet;
- (NSString *)replaceTelnet:(UMSS7ConfigTelnet *)telnet;
- (NSString *)deleteTelnet:(NSString *)name;

- (NSArray *)getSyslogDestinationNames;
- (UMSS7ConfigSyslogDestination *)getSyslogDestination:(NSString *)name;
- (NSString *)addSyslogDestination:(UMSS7ConfigSyslogDestination *)syslog;
- (NSString *)replaceSyslogDestination:(UMSS7ConfigSyslogDestination *)syslog;
- (NSString *)deleteSyslogDestination:(NSString *)name;

- (NSArray *)getAdminUserNames;
- (UMSS7ConfigAdminUser *)getAdminUser:(NSString *)name;
- (NSString *)addAdminUser:(UMSS7ConfigAdminUser *)user;
- (NSString *)replaceAdminUser:(UMSS7ConfigAdminUser *)user;
- (NSString *)deleteAdminUser:(NSString *)name;

- (NSArray *)getSCCPNumberTranslationNames;
- (UMSS7ConfigSCCPNumberTranslation *)getSCCPNumberTranslation:(NSString *)name;
- (NSString *)addSCCPNumberTranslation:(UMSS7ConfigSCCPNumberTranslation*)number_translaton;
- (NSString *)replaceSCCPNumberTranslation:(UMSS7ConfigSCCPNumberTranslation *)number_translaton;
- (NSString *)deleteSCCPNumberTranslation:(NSString *)name;


- (NSArray *)getServiceUserNames;
- (UMSS7ConfigServiceUser *)getServiceUser:(NSString *)name;
- (NSString *)addServiceUser:(UMSS7ConfigServiceUser *)smsc;
- (NSString *)replaceServiceUser:(UMSS7ConfigServiceUser *)smsc;
- (NSString *)deleteServiceUser:(NSString *)name;

- (NSArray *)getServiceUserProfileNames;
- (UMSS7ConfigServiceUserProfile *)getServiceUserProfile:(NSString *)name;
- (NSString *)addServiceUserProfile:(UMSS7ConfigServiceUserProfile *)smsc;
- (NSString *)replaceServiceUserProfile:(UMSS7ConfigServiceUserProfile *)smsc;
- (NSString *)deleteServiceUserProfile:(NSString *)name;

- (NSArray *)getServiceBillingEntityNames;
- (UMSS7ConfigServiceBillingEntity *)getServiceBillingEntity:(NSString *)name;
- (NSString *)addServiceBillingEntity:(UMSS7ConfigServiceBillingEntity *)smsc;
- (NSString *)replaceServiceBillingEntity:(UMSS7ConfigServiceBillingEntity *)smsc;
- (NSString *)deleteServiceBillingEntitye:(NSString *)name;

- (NSArray *)getIMSIPoolNames;
- (UMSS7ConfigIMSIPool *)getIMSIPool:(NSString *)name;
- (NSString *)addIMSIPool:(UMSS7ConfigIMSIPool *)pool;
- (NSString *)replaceIMSIPool:(UMSS7ConfigIMSIPool *)pool;
- (NSString *)deleteIMSIPool:(NSString *)name;

- (NSArray *)getCdrWriterNames;
- (UMSS7ConfigCdrWriter *)getCdrWriter:(NSString *)cdrw;
- (NSString *)addCdrWriter:(UMSS7ConfigCdrWriter *)cdrw;
- (NSString *)replaceCdrWriter:(UMSS7ConfigCdrWriter *)cdrw;
- (NSString *)deleteCdrWriter:(NSString *)cdrw;


- (NSArray *)getApiUserNames;
- (UMSS7ConfigApiUser *)getApiUser:(NSString *)name;
- (NSString *)addApiUser:(UMSS7ConfigApiUser *)user;
- (NSString *)replaceApiUser:(UMSS7ConfigApiUser *)user;
- (NSString *)deleteApiUser:(NSString *)name;


- (NSArray *)getDiameterConnectionNames;
- (UMSS7ConfigDiameterConnection *)getDiameterConnection:(NSString *)name;
- (NSString *)addDiameterConnection:(UMSS7ConfigDiameterConnection*)dc;
- (NSString *)replaceDiameterConnection:(UMSS7ConfigDiameterConnection *)dc;
- (NSString *)deleteDiameterConnection:(NSString *)name;

- (NSArray *)getDiameterRouterNames;
- (UMSS7ConfigDiameterRouter *)getDiameterRouter:(NSString *)name;
- (NSString *)addDiameterRouter:(UMSS7ConfigDiameterRouter *)dc;
- (NSString *)replaceDiameterRouter:(UMSS7ConfigDiameterRouter *)dc;
- (NSString *)deleteDiameterRouter:(NSString *)name;

- (NSArray *)getDiameterRoutes;
- (UMSS7ConfigDiameterRoute *)getDiameterRoute:(NSString *)name;
- (NSString *)addDiameterRoute:(UMSS7ConfigDiameterRoute *)dc;
- (NSString *)replaceDiameterRoute:(UMSS7ConfigDiameterRoute *)dc;
- (NSString *)deleteDiameterRoute:(NSString *)name;

- (NSArray *)getPointcodeTranslationTables;
- (UMSS7ConfigMTP3PointCodeTranslationTable *)getPointcodeTranslationTable:(NSString *)name;
- (NSString *)addPointcodeTranslationTable:(UMSS7ConfigMTP3PointCodeTranslationTable *)dc;
- (NSString *)replacePointcodeTranslationTable:(UMSS7ConfigMTP3PointCodeTranslationTable *)dc;
- (NSString *)deletePointcodeTranslationTable:(NSString *)name;

- (NSArray *)getCAMELNames;
- (UMSS7ConfigCAMEL *)getCAMEL:(NSString *)name;
- (NSString *)addCAMEL:(UMSS7ConfigCAMEL *)camel;
- (NSString *)replaceCAMEL:(UMSS7ConfigCAMEL *)camel;
- (NSString *)deleteCAMEL:(NSString *)name;

- (NSArray *)getMnpDatabaseNames;
- (UMSS7ConfigMnpDatabase *)getMnpDatabase:(NSString *)name;
- (NSString *)addMnpDatabase:(UMSS7ConfigMnpDatabase *)mnpdb;
- (NSString *)replaceMnpDatabase:(UMSS7ConfigMnpDatabase *)mnpdb;
- (NSString *)deleteMnpDatabase:(NSString *)name;

@end

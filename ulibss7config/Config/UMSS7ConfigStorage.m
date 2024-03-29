//
//  UMSS7ConfigStorage.m
//  estp
//
//  Created by Andreas Fink on 01.02.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import <ulibsctp/ulibsctp.h>
#import "UMSS7ConfigGeneral.h"
#import "UMSS7ConfigWebserver.h"
#import "UMSS7ConfigTelnet.h"
#import "UMSS7ConfigSyslogDestination.h"
#import "UMSS7ConfigSCTP.h"
#import "UMSS7ConfigM2PA.h"
#import "UMSS7ConfigMTP3.h"
#import "UMSS7ConfigMTP3Route.h"
#import "UMSS7ConfigMTP3Filter.h"
#import "UMSS7ConfigMTP3FilterEntry.h"
#import "UMSS7ConfigMTP3LinkSet.h"
#import "UMSS7ConfigMTP3Link.h"
#import "UMSS7ConfigM3UAAS.h"
#import "UMSS7ConfigM3UAASP.h"
#import "UMSS7ConfigSCCP.h"
#import "UMSS7ConfigSCCPFilter.h"
#import "UMSS7ConfigSCCPTranslationTable.h"
#import "UMSS7ConfigSCCPTranslationTableEntry.h"
#import "UMSS7ConfigSCCPTranslationTableMap.h"
#import "UMSS7ConfigSCCPDestination.h"
#import "UMSS7ConfigSCCPDestinationEntry.h"
#import "UMSS7ConfigTCAP.h"
#import "UMSS7ConfigTCAPFilter.h"
#import "UMSS7ConfigTCAPFilterEntry.h"
#import "UMSS7ConfigGSMMAP.h"
#import "UMSS7ConfigGSMMAPFilter.h"
#import "UMSS7ConfigGSMMAPFilterEntry.h"
#import "UMSS7ConfigSMS.h"
#import "UMSS7ConfigSMSFilter.h"
#import "UMSS7ConfigSMSFilterEntry.h"
#import "UMSS7ConfigHLR.h"
#import "UMSS7ConfigMSC.h"
#import "UMSS7ConfigGGSN.h"
#import "UMSS7ConfigSGSN.h"
#import "UMSS7ConfigSMSC.h"
#import "UMSS7ConfigSMSProxy.h"
#import "UMSS7ConfigDatabasePool.h"
#import "UMSS7ConfigCdrWriter.h"
#import "UMSS7ConfigAdminUser.h"
#import "UMSS7ConfigMSC.h"
#import "UMSS7ConfigHLR.h"
#import "UMSS7ConfigVLR.h"
#import "UMSS7ConfigGSMSCF.h"
#import "UMSS7ConfigGMLC.h"
#import "UMSS7ConfigEIR.h"
#import "UMSS7ConfigESTP.h"
#import "UMSS7ConfigMAPI.h"
#import "UMSS7ConfigSCCPNumberTranslation.h"
#import "UMSS7ConfigSCCPNumberTranslationEntry.h"
#import "UMSS7ConfigServiceUser.h"
#import "UMSS7ConfigServiceProfile.h"
#import "UMSS7ConfigServiceBillingEntity.h"
#import "UMSS7ConfigIMSIPool.h"
#import "UMSS7ConfigCdrWriter.h"
#import "UMSS7ConfigApiUser.h"
#import "UMSS7ConfigDiameterConnection.h"
#import "UMSS7ConfigDiameterRouter.h"
#import "UMSS7ConfigDiameterRoute.h"
#import "UMSS7ConfigMTP3PointCodeTranslationTable.h"
#import "UMSS7ConfigCAMEL.h"
#import "UMSS7ConfigMnpDatabase.h"
#import "UMSS7ConfigMirrorPort.h"
#import "UMSS7ConfigSMSDeliveryProvider.h"
#import "UMSS7ConfigSMPPServer.h"
#import "UMSS7ConfigSMPPConnection.h"
#import "UMSS7ConfigSMPPPlugin.h"
#import "UMSS7ConfigAuthServer.h"
#import "UMSS7ConfigStorageServer.h"
#import "UMSS7ConfigCdrServer.h"


#define CONFIG_ERROR(s)     [NSException exceptionWithName:[NSString stringWithFormat:@"CONFIG_ERROR FILE %s line:%ld",__FILE__,(long)__LINE__] reason:s userInfo:@{@"backtrace": UMBacktrace(NULL,0) }]

@implementation UMSS7ConfigStorage

- (void)generalInitialisation
{
    _webserver_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _telnet_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _syslog_destination_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _sctp_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _m2pa_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _mtp3_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _mtp3_link_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _mtp3_linkset_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _m3ua_as_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _m3ua_asp_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _mtp3_filter_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _mtp3_route_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _mtp3_pctrans_dict = [[UMSynchronizedSortedDictionary alloc]init];
    _sccp_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _sccp_destination_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _sccp_translation_table_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _sccp_translation_table_entry_dict= [[UMSynchronizedSortedDictionary alloc]init]; /* do we need this or should this be above */
    _sccp_translation_table_map_dict = [[UMSynchronizedSortedDictionary alloc]init];
    _sccp_filter_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _sccp_number_translation_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _tcap_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _tcap_filter_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _gsmmap_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _gsmmap_filter_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _sms_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _sms_filter_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _hlr_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _msc_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _ggsn_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _sgsn_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _vlr_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _eir_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _gsmscf_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _camel_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _gmlc_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _smsc_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _smsproxy_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _estp_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _admin_user_dict = [[UMSynchronizedSortedDictionary alloc]init];
    _api_user_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _database_pool_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _service_user_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _service_user_profile_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _service_billing_entity_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _imsi_pool_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _cdr_writer_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _diameter_connection_dict =  [[UMSynchronizedSortedDictionary alloc]init];
    _diameter_router_dict =  [[UMSynchronizedSortedDictionary alloc]init];
    _diameter_route_dict =  [[UMSynchronizedSortedDictionary alloc]init];
    _estp_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _mapi_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _mnpDatabases_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _mirrorPorts_dict= [[UMSynchronizedSortedDictionary alloc]init];
    _smsDeliveryProviders_dict = [[UMSynchronizedSortedDictionary alloc]init];
    _smppServers_dict = [[UMSynchronizedSortedDictionary alloc]init];
    _smppConnections_dict = [[UMSynchronizedSortedDictionary alloc]init];
    _smppPlugins_dict = [[UMSynchronizedSortedDictionary alloc]init];
    
    _authServers_dict       = [[UMSynchronizedSortedDictionary alloc]init];
    _storageServers_dict    = [[UMSynchronizedSortedDictionary alloc]init];
    _cdrServers_dict        = [[UMSynchronizedSortedDictionary alloc]init];

    _dirtyTimer = [[UMTimer alloc]initWithTarget:self
                                        selector:@selector(dirtyCheck)
                                          object:NULL
                                         seconds:10.0
                                            name:@"dirty-config-timer"
                                         repeats:YES
                                 runInForeground:NO];
    _productName = @"UniversalSS7";
}

- (UMSS7ConfigStorage *)init
{
    return [self initWithFileName:NULL];
}

- (void)touch
{
    _dirty = YES;
}

- (UMSS7ConfigStorage *)initWithFileName:(NSString *)filename
{
    self = [super init];
    if(self)
    {
        [self generalInitialisation];
        if(filename)
        {
            [self loadFromFile:filename];
        }
    }
    return self;
}


- (UMSS7ConfigStorage *)initWithCommandLine:(UMCommandLine *)cmd
{
    return [self initWithCommandLine:cmd defaultConfigFileName:@"/etc/universalss7/universalss7.conf"];
}

- (UMSS7ConfigStorage *)initWithCommandLine:(UMCommandLine *)cmd defaultConfigFileName:(NSString *)defaultCfgFile
{
    self = [super init];
    if(self)
    {
        [self generalInitialisation];
        _commandLine = cmd;
        NSArray *configFiles = _commandLine.params[@"config"];
        if(configFiles.count ==0)
        {
            configFiles = @[ defaultCfgFile ];
        }
        for(NSString *configFile in configFiles)
        {
            [self loadFromFile:configFile];
        }

        NSArray *rwconfigFiles = _commandLine.params[@"readwriteconfig"];
        if(rwconfigFiles.count==1)
        {
           _rwconfigFile = rwconfigFiles[0];
            [self loadFromFile:_rwconfigFile];
        }
        if(_commandLine.params[@"rw"])
        {
            _rwconfigFile = configFiles[0];
        }
        if(_commandLine.params[@"autowrite"])
        {
            _autowrite = YES;
        }
    }
    return self;
}


- (void)startDirtyTimer
{
    if(_autowrite==YES)
    {
        [_dirtyTimer start];
    }
}

- (void)stopDirtyTimer
{
    [_dirtyTimer stop];
}

- (void)dirtyCheck
{
    if(_dirty==YES)
    {
        NSLog(@"dirty config. lets write it");
        NSError *e = NULL;
        NSString *s = [self configString];
        if(s == NULL)
        {
            NSLog(@"self config is NULL. can't write");
        }
        else if(_rwconfigFile.length==0)
        {
            NSLog(@"_rwconfigFile is NULL. can't write");
        }
        else
        {
            [s writeToFile:_rwconfigFile atomically:YES encoding:NSUTF8StringEncoding error:&e];
            if(e)
            {
                NSLog(@"Error %@",e);
            }
        }
    }
    _dirty=NO;
}

- (void)loadFromFile:(NSString *)filename
{
    UMConfig* cfg = [[UMConfig alloc]initWithFileName:filename];
    [cfg allowSingleGroup:@"general"];
    [cfg allowMultiGroup:[UMSS7ConfigWebserver type]];
    [cfg allowMultiGroup:[UMSS7ConfigTelnet type]];
    [cfg allowMultiGroup:[UMSS7ConfigSyslogDestination type]];
    [cfg allowMultiGroup:[UMSS7ConfigSCTP type]];
    [cfg allowMultiGroup:[UMSS7ConfigM2PA type]];
    [cfg allowMultiGroup:[UMSS7ConfigMTP3 type]];
    [cfg allowMultiGroup:[UMSS7ConfigMTP3Link type]];
    [cfg allowMultiGroup:[UMSS7ConfigMTP3LinkSet type]];
    [cfg allowMultiGroup:[UMSS7ConfigM3UAAS type]];
    [cfg allowMultiGroup:[UMSS7ConfigM3UAASP type]];
    [cfg allowMultiGroup:[UMSS7ConfigMTP3Filter type]];
    [cfg allowMultiGroup:[UMSS7ConfigMTP3FilterEntry type]];
    [cfg allowMultiGroup:[UMSS7ConfigMTP3Route type]];
    [cfg allowMultiGroup:[UMSS7ConfigSCCP type]];
    [cfg allowMultiGroup:[UMSS7ConfigSCCPDestination type]];
    [cfg allowMultiGroup:[UMSS7ConfigSCCPDestinationEntry type]];
    [cfg allowMultiGroup:[UMSS7ConfigSCCPTranslationTable type]];
    [cfg allowMultiGroup:[UMSS7ConfigSCCPTranslationTableEntry type]];
    [cfg allowMultiGroup:[UMSS7ConfigSCCPTranslationTableMap type]];
    [cfg allowMultiGroup:[UMSS7ConfigSCCPFilter type]];
    [cfg allowMultiGroup:[UMSS7ConfigSCCPNumberTranslation type]];
    [cfg allowMultiGroup:[UMSS7ConfigSCCPNumberTranslationEntry type]];
    [cfg allowMultiGroup:[UMSS7ConfigTCAP type]];
    [cfg allowMultiGroup:[UMSS7ConfigTCAPFilter type]];
    [cfg allowMultiGroup:[UMSS7ConfigTCAPFilterEntry type]];
    [cfg allowMultiGroup:[UMSS7ConfigGSMMAP type]];
    [cfg allowMultiGroup:[UMSS7ConfigGSMMAPFilter type]];
    [cfg allowMultiGroup:[UMSS7ConfigGSMMAPFilterEntry type]];
    [cfg allowMultiGroup:[UMSS7ConfigSMS type]];
    [cfg allowMultiGroup:[UMSS7ConfigSMSFilter type]];
    [cfg allowMultiGroup:[UMSS7ConfigSMSFilterEntry type]];
    [cfg allowMultiGroup:[UMSS7ConfigHLR type]];
    [cfg allowMultiGroup:[UMSS7ConfigMSC type]];
    [cfg allowMultiGroup:[UMSS7ConfigGGSN type]];
    [cfg allowMultiGroup:[UMSS7ConfigSGSN type]];
    [cfg allowMultiGroup:[UMSS7ConfigVLR type]];
    [cfg allowMultiGroup:[UMSS7ConfigEIR type]];
    [cfg allowMultiGroup:[UMSS7ConfigGSMSCF type]];
    [cfg allowMultiGroup:[UMSS7ConfigGMLC type]];
    [cfg allowMultiGroup:[UMSS7ConfigSMSC type]];
    [cfg allowMultiGroup:[UMSS7ConfigCAMEL type]];
    [cfg allowMultiGroup:[UMSS7ConfigSMSProxy type]];
    [cfg allowMultiGroup:[UMSS7ConfigESTP type]];
    [cfg allowMultiGroup:[UMSS7ConfigAdminUser type]];
    [cfg allowMultiGroup:[UMSS7ConfigApiUser type]];
    [cfg allowMultiGroup:[UMSS7ConfigDatabasePool type]];
    [cfg allowMultiGroup:[UMSS7ConfigServiceUser type]];
    [cfg allowMultiGroup:[UMSS7ConfigServiceProfile type]];
    [cfg allowMultiGroup:[UMSS7ConfigServiceBillingEntity type]];
    [cfg allowMultiGroup:[UMSS7ConfigIMSIPool type]];
    [cfg allowMultiGroup:[UMSS7ConfigCdrWriter type]];
    [cfg allowMultiGroup:[UMSS7ConfigDiameterRouter type]];
    [cfg allowMultiGroup:[UMSS7ConfigDiameterRoute type]];
    [cfg allowMultiGroup:[UMSS7ConfigDiameterConnection type]];
    [cfg allowMultiGroup:[UMSS7ConfigMTP3PointCodeTranslationTable type]];
    [cfg allowMultiGroup:[UMSS7ConfigMnpDatabase type]];
    [cfg read];
    [self processConfig:cfg];
}



- (void)processConfig:(UMConfig *)cfg
{
    /* as we can read multiple config files, the general options could be further
     enhanced in a second file */
    NSDictionary *general_config = [cfg getSingleGroup:[UMSS7ConfigGeneral type]];
    if(general_config==NULL)
    {
        general_config = @{@"group" : @"general",
                           @"name"  : @"general",
                           @"hostname" : @"localhost",
                           @"log-level": @(3),
                           @"log-rotations" : @(5),
                           @"log-file": @"main.log",
                           @"log-directory": @".",
                           @"concurrent-tasks" : @(8),
                           };
    }
    if(_generalConfig==NULL)
    {
        _generalConfig =[[ UMSS7ConfigGeneral alloc]initWithConfig:general_config];
    }
    else
    {
        [_generalConfig setConfig:general_config];
    }

    NSArray *webserver_configs = [cfg getMultiGroups:[UMSS7ConfigWebserver type]];
    for(NSDictionary *webserver_config in webserver_configs)
    {
        UMSS7ConfigWebserver *webserver = [[UMSS7ConfigWebserver alloc]initWithConfig:webserver_config];
        if(webserver.name.length  > 0)
        {
            _webserver_dict[webserver.name] = webserver;
        }
    }
    NSArray *telnet_configs = [cfg getMultiGroups:[UMSS7ConfigTelnet type]];
    for(NSDictionary *telnet_config in telnet_configs)
    {
        UMSS7ConfigTelnet *telnet = [[UMSS7ConfigTelnet alloc]initWithConfig:telnet_config];
        if(telnet.name.length  > 0)
        {
            _telnet_dict[telnet.name] = telnet;
        }
    }

    NSArray *syslog_configs = [cfg getMultiGroups:[UMSS7ConfigSyslogDestination type]];
    for(NSDictionary *syslog_config in syslog_configs)
    {
        UMSS7ConfigSyslogDestination *syslog = [[UMSS7ConfigSyslogDestination alloc]initWithConfig:syslog_config];
        if(syslog.name.length  > 0)
        {
            _syslog_destination_dict[syslog.name] = syslog;
        }
    }

    NSArray *sctp_configs = [cfg getMultiGroups:[UMSS7ConfigSCTP type]];
    for(NSDictionary *sctp_config in sctp_configs)
    {
        UMSS7ConfigSCTP *sctp = [[UMSS7ConfigSCTP alloc]initWithConfig:sctp_config];
        if(sctp.name.length  > 0)
        {
            _sctp_dict[sctp.name] = sctp;
        }
    }
    NSArray *m2pa_configs = [cfg getMultiGroups:[UMSS7ConfigM2PA type]];
    for(NSDictionary *m2pa_config in m2pa_configs)
    {
        UMSS7ConfigM2PA *m2pa = [[UMSS7ConfigM2PA alloc]initWithConfig:m2pa_config];
        if(m2pa.name.length  > 0)
        {
            _m2pa_dict[m2pa.name] = m2pa;
        }
    }
    NSArray *mtp3_configs = [cfg getMultiGroups:[UMSS7ConfigMTP3 type]];
    for(NSDictionary *mtp3_config in mtp3_configs)
    {
        UMSS7ConfigMTP3 *mtp3 = [[UMSS7ConfigMTP3 alloc]initWithConfig:mtp3_config];
        if(mtp3.name.length  > 0)
        {
            _mtp3_dict[mtp3.name] = mtp3;
        }
    }
    NSArray *mtp3_link_configs = [cfg getMultiGroups:[UMSS7ConfigMTP3Link type]];
    for(NSDictionary *mtp3_link_config in mtp3_link_configs)
    {
        UMSS7ConfigMTP3Link *mtp3_link = [[UMSS7ConfigMTP3Link alloc]initWithConfig:mtp3_link_config];
        if(mtp3_link.name.length  > 0)
        {
            _mtp3_link_dict[mtp3_link.name] = mtp3_link;
        }
    }
    NSArray *mtp3_linkset_configs = [cfg getMultiGroups:[UMSS7ConfigMTP3LinkSet type]];
    for(NSDictionary *mtp3_linkset_config in mtp3_linkset_configs)
    {
        UMSS7ConfigMTP3LinkSet *mtp3_linkset = [[UMSS7ConfigMTP3LinkSet alloc]initWithConfig:mtp3_linkset_config];
        if(mtp3_linkset.name.length  > 0)
        {
            _mtp3_linkset_dict[mtp3_linkset.name] = mtp3_linkset;
        }
    }
    NSArray *m3ua_as_configs = [cfg getMultiGroups:[UMSS7ConfigM3UAAS type]];
    for(NSDictionary *m3ua_as_config in m3ua_as_configs)
    {
        UMSS7ConfigM3UAAS *m3ua_as = [[UMSS7ConfigM3UAAS alloc]initWithConfig:m3ua_as_config];
        if(m3ua_as.name.length  > 0)
        {
            _m3ua_as_dict[m3ua_as.name] = m3ua_as;
        }
    }
    NSArray *m3ua_asp_configs = [cfg getMultiGroups:[UMSS7ConfigM3UAASP type]];
    for(NSDictionary *m3ua_asp_config in m3ua_asp_configs)
    {
        UMSS7ConfigM3UAASP *m3ua_asp = [[UMSS7ConfigM3UAASP alloc]initWithConfig:m3ua_asp_config];
        if(m3ua_asp.name.length  > 0)
        {
            _m3ua_asp_dict[m3ua_asp.name] = m3ua_asp;
        }
    }

    NSArray *mtp3_filter_configs = [cfg getMultiGroups:[UMSS7ConfigMTP3Filter type]];
    for(NSDictionary *mtp3_filter_config in mtp3_filter_configs)
    {
        UMSS7ConfigMTP3Filter *mtp3_filter = [[UMSS7ConfigMTP3Filter alloc]initWithConfig:mtp3_filter_config];
        if(mtp3_filter.name.length  > 0)
        {
            _mtp3_filter_dict[mtp3_filter.name] = mtp3_filter;
        }
    }

    NSArray *mtp3_filter_entry_configs = [cfg getMultiGroups:[UMSS7ConfigMTP3FilterEntry type]];
    for(NSDictionary *mtp3_filter_entry_config in mtp3_filter_entry_configs)
    {
        UMSS7ConfigMTP3FilterEntry *mtp3_filter_entry = [[UMSS7ConfigMTP3FilterEntry alloc]initWithConfig:mtp3_filter_entry_config];
        if(mtp3_filter_entry.filter.length  > 0)
        {
            UMSS7ConfigMTP3Filter *filter = _mtp3_filter_dict[mtp3_filter_entry.filter];
            if(filter)
            {
                [filter addSubEntry:mtp3_filter_entry];
            }
        }
    }

    NSArray *mtp3_route_configs = [cfg getMultiGroups:[UMSS7ConfigMTP3Route type]];
    for(NSDictionary *mtp3_route_config in mtp3_route_configs)
    {
        UMSS7ConfigMTP3Route *mtp3_route = [[UMSS7ConfigMTP3Route alloc]initWithConfig:mtp3_route_config];
        if(mtp3_route)
        {
            _mtp3_route_dict[mtp3_route.name] = mtp3_route;
        }
    }

    NSArray *mtp3_pctrans_configs = [cfg getMultiGroups:[UMSS7ConfigMTP3PointCodeTranslationTable type]];
    for(NSDictionary *mtp3_pctrans_config in mtp3_pctrans_configs)
    {
        UMSS7ConfigMTP3PointCodeTranslationTable *mtp3_pctt = [[UMSS7ConfigMTP3PointCodeTranslationTable alloc]initWithConfig:mtp3_pctrans_config];
        if(mtp3_pctt)
        {
            _mtp3_pctrans_dict[mtp3_pctt.name] = mtp3_pctt;
        }
    }

    NSArray *sccp_configs = [cfg getMultiGroups:[UMSS7ConfigSCCP type]];
    for(NSDictionary *sccp_config in sccp_configs)
    {
        UMSS7ConfigSCCP *sccp = [[UMSS7ConfigSCCP alloc]initWithConfig:sccp_config];
        if(sccp.name.length  > 0)
        {
            _sccp_dict[sccp.name] = sccp;
        }
    }


    NSArray *sccp_destination_configs = [cfg getMultiGroups:[UMSS7ConfigSCCPDestination type]];
    for(NSDictionary *sccp_destination_config in sccp_destination_configs)
    {
        UMSS7ConfigSCCPDestination *sccp_destination = [[UMSS7ConfigSCCPDestination alloc]initWithConfig:sccp_destination_config];
        if(sccp_destination.name.length  > 0)
        {
            _sccp_destination_dict[sccp_destination.name] = sccp_destination;
        }
    }

    NSArray *sccp_destination_entry_configs = [cfg getMultiGroups:[UMSS7ConfigSCCPDestinationEntry type]];
    for(NSDictionary *sccp_destination_entry_config in sccp_destination_entry_configs)
    {
        UMSS7ConfigSCCPDestinationEntry *sccp_destination_entry = [[UMSS7ConfigSCCPDestinationEntry alloc]initWithConfig:sccp_destination_entry_config];
        if(sccp_destination_entry.destination.length  > 0)
        {
            UMSS7ConfigSCCPDestination *destination = _sccp_destination_dict[sccp_destination_entry.destination];
            if(destination)
            {
                [destination addSubEntry:sccp_destination_entry];
            }
        }
    }


    NSArray *sccp_translation_table_configs = [cfg getMultiGroups:[UMSS7ConfigSCCPTranslationTable type]];
    for(NSDictionary *sccp_translation_table_config in sccp_translation_table_configs)
    {
        UMSS7ConfigSCCPTranslationTable *sccp_translation_table = [[UMSS7ConfigSCCPTranslationTable alloc]initWithConfig:sccp_translation_table_config];
        if(sccp_translation_table.name.length  > 0)
        {
            _sccp_translation_table_dict[sccp_translation_table.name] = sccp_translation_table;
        }
    }

    NSArray *sccp_translation_table_map_configs = [cfg getMultiGroups:[UMSS7ConfigSCCPTranslationTableMap type]];
    for(NSDictionary *sccp_translation_table_map_config in sccp_translation_table_map_configs)
    {
        UMSS7ConfigSCCPTranslationTableMap *sccp_translation_table_map = [[UMSS7ConfigSCCPTranslationTableMap alloc]initWithConfig:sccp_translation_table_map_config];
        if(sccp_translation_table_map.name.length  > 0)
        {
            _sccp_translation_table_map_dict[sccp_translation_table_map.name] = sccp_translation_table_map;
        }
    }

    NSArray *sccp_translation_table_entry_configs = [cfg getMultiGroups:[UMSS7ConfigSCCPTranslationTableEntry type]];
    for(NSDictionary *sccp_translation_table_entry_config in sccp_translation_table_entry_configs)
    {
        UMSS7ConfigSCCPTranslationTableEntry *sccp_translation_table_entry = [[UMSS7ConfigSCCPTranslationTableEntry alloc]initWithConfig:sccp_translation_table_entry_config];
        if(sccp_translation_table_entry.translationTableName.length  > 0)
        {
            UMSS7ConfigSCCPTranslationTable *translation_table = _sccp_translation_table_dict[sccp_translation_table_entry.translationTableName];
            if(translation_table==NULL)
            {
                translation_table = [[UMSS7ConfigSCCPTranslationTable alloc]initWithConfig:@{ @"name" : sccp_translation_table_entry.translationTableName }];
            }
            if(sccp_translation_table_entry.gta.count > 1)
            {
                for(NSString *gta in sccp_translation_table_entry.gta)
                {
                    UMSS7ConfigSCCPTranslationTableEntry *single = [sccp_translation_table_entry copy];
                    [single setGta:@[gta]];
                    [translation_table addSubEntry:single];
                }
            }
            else
            {
                [translation_table addSubEntry:sccp_translation_table_entry];
            }
            _sccp_translation_table_entry_dict[sccp_translation_table_entry.name] = sccp_translation_table_entry;
        }
    }

    NSArray *sccp_filter_configs = [cfg getMultiGroups:[UMSS7ConfigSCCPFilter type]];
    for(NSDictionary *sccp_filter_config in sccp_filter_configs)
    {
        UMSS7ConfigSCCPFilter *sccp_filter = [[UMSS7ConfigSCCPFilter alloc]initWithConfig:sccp_filter_config];
        if(sccp_filter.name.length  > 0)
        {
            _sccp_filter_dict[sccp_filter.name] = sccp_filter;
        }
    }

    NSArray *tcap_configs = [cfg getMultiGroups:[UMSS7ConfigTCAP type]];
    for(NSDictionary *tcap_config in tcap_configs)
    {
        UMSS7ConfigTCAP *tcap = [[UMSS7ConfigTCAP alloc]initWithConfig:tcap_config];
        if(tcap.name.length  > 0)
        {
            _tcap_dict[tcap.name] = tcap;
        }
    }

    NSArray *tcap_filter_configs = [cfg getMultiGroups:[UMSS7ConfigTCAPFilter type]];
    for(NSDictionary *tcap_filter_config in tcap_filter_configs)
    {
        UMSS7ConfigTCAPFilter *tcap_filter = [[UMSS7ConfigTCAPFilter alloc]initWithConfig:tcap_filter_config];
        if(tcap_filter.name.length  > 0)
        {
            _tcap_filter_dict[tcap_filter.name] = tcap_filter;
        }
    }

    NSArray *tcap_filter_entry_configs = [cfg getMultiGroups:[UMSS7ConfigTCAPFilterEntry type]];
    for(NSDictionary *tcap_filter_entry_config in tcap_filter_entry_configs)
    {
        UMSS7ConfigTCAPFilterEntry *tcap_filter_entry = [[UMSS7ConfigTCAPFilterEntry alloc]initWithConfig:tcap_filter_entry_config];
        if(tcap_filter_entry.filter.length  > 0)
        {
            UMSS7ConfigTCAPFilter *filter = _tcap_filter_dict[tcap_filter_entry.filter];
            if(filter)
            {
                [filter addSubEntry:tcap_filter_entry];
            }
        }
    }

    NSArray *gsmmap_configs = [cfg getMultiGroups:[UMSS7ConfigGSMMAP type]];
    for(NSDictionary *gsmmap_config in gsmmap_configs)
    {
        UMSS7ConfigGSMMAP *gsmmap = [[UMSS7ConfigGSMMAP alloc]initWithConfig:gsmmap_config];
        if(gsmmap.name.length  > 0)
        {
            _gsmmap_dict[gsmmap.name] = gsmmap;
        }
    }

    NSArray *gsmmap_filter_configs = [cfg getMultiGroups:[UMSS7ConfigGSMMAPFilter type]];
    for(NSDictionary *gsmmap_filter_config in gsmmap_filter_configs)
    {
        UMSS7ConfigGSMMAPFilter *gsmmap_filter = [[UMSS7ConfigGSMMAPFilter alloc]initWithConfig:gsmmap_filter_config];
        if(gsmmap_filter.name.length  > 0)
        {
            _gsmmap_filter_dict[gsmmap_filter.name] = gsmmap_filter;
        }
    }

    NSArray *gsmmap_filter_entry_configs = [cfg getMultiGroups:[UMSS7ConfigGSMMAPFilterEntry type]];
    for(NSDictionary *gsmmap_filter_entry_config in gsmmap_filter_entry_configs)
    {
        UMSS7ConfigGSMMAPFilterEntry *gsmmap_filter_entry = [[UMSS7ConfigGSMMAPFilterEntry alloc]initWithConfig:gsmmap_filter_entry_config];
        if(gsmmap_filter_entry.filter.length  > 0)
        {
            UMSS7ConfigGSMMAPFilter *filter = _gsmmap_filter_dict[gsmmap_filter_entry.filter];
            if(filter)
            {
                [filter addSubEntry:gsmmap_filter_entry];
            }
        }
    }

    NSArray *sms_configs = [cfg getMultiGroups:[UMSS7ConfigSMS type]];
    for(NSDictionary *sms_config in sms_configs)
    {
        UMSS7ConfigSMS *sms = [[UMSS7ConfigSMS alloc]initWithConfig:sms_config];
        if(sms.name.length  > 0)
        {
            _sms_dict[sms.name] = sms;
        }
    }

    NSArray *sms_filter_configs = [cfg getMultiGroups:[UMSS7ConfigSMSFilter type]];
    for(NSDictionary *sms_filter_config in sms_filter_configs)
    {
        UMSS7ConfigSMSFilter *sms_filter = [[UMSS7ConfigSMSFilter alloc]initWithConfig:sms_filter_config];
        if(sms_filter.name.length  > 0)
        {
            _sms_filter_dict[sms_filter.name] = sms_filter;
        }
    }

    NSArray *sms_filter_entry_configs = [cfg getMultiGroups:[UMSS7ConfigSMSFilterEntry type]];
    for(NSDictionary *sms_filter_entry_config in sms_filter_entry_configs)
    {
        UMSS7ConfigSMSFilterEntry *sms_filter_entry = [[UMSS7ConfigSMSFilterEntry alloc]initWithConfig:sms_filter_entry_config];
        if(sms_filter_entry.filter.length  > 0)
        {
            UMSS7ConfigSMSFilter *filter = _sms_filter_dict[sms_filter_entry.filter];
            if(filter)
            {
                [filter addSubEntry:sms_filter_entry];
            }
        }
    }

    NSArray *hlr_configs = [cfg getMultiGroups:[UMSS7ConfigHLR type]];
    for(NSDictionary *hlr_config in hlr_configs)
    {
        UMSS7ConfigHLR *hlr = [[UMSS7ConfigHLR alloc]initWithConfig:hlr_config];
        if(hlr.name.length  > 0)
        {
            _hlr_dict[hlr.name] = hlr;
        }
    }
    NSArray *msc_configs = [cfg getMultiGroups:[UMSS7ConfigMSC type]];
    for(NSDictionary *msc_config in msc_configs)
    {
        UMSS7ConfigMSC *msc = [[UMSS7ConfigMSC alloc]initWithConfig:msc_config];
        if(msc.name.length  > 0)
        {
            _msc_dict[msc.name] = msc;
        }
    }

    NSArray *ggsn_configs = [cfg getMultiGroups:[UMSS7ConfigGGSN type]];
    for(NSDictionary *ggsn_config in ggsn_configs)
    {
        UMSS7ConfigGGSN *ggsn = [[UMSS7ConfigGGSN alloc]initWithConfig:ggsn_config];
        if(ggsn.name.length  > 0)
        {
            _ggsn_dict[ggsn.name] = ggsn;
        }
    }

    NSArray *sgsn_configs = [cfg getMultiGroups:[UMSS7ConfigSGSN type]];
    for(NSDictionary *sgsn_config in sgsn_configs)
    {
        UMSS7ConfigSGSN *sgsn = [[UMSS7ConfigSGSN alloc]initWithConfig:sgsn_config];
        if(sgsn.name.length  > 0)
        {
            _sgsn_dict[sgsn.name] = sgsn;
        }
    }

    NSArray *vlr_configs = [cfg getMultiGroups:[UMSS7ConfigVLR type]];
    for(NSDictionary *vlr_config in vlr_configs)
    {
        UMSS7ConfigVLR *vlr = [[UMSS7ConfigVLR alloc]initWithConfig:vlr_config];
        if(vlr.name.length  > 0)
        {
            _vlr_dict[vlr.name] = vlr;
        }
    }

    NSArray *eir_configs = [cfg getMultiGroups:[UMSS7ConfigEIR type]];
    for(NSDictionary *eir_config in eir_configs)
    {
        UMSS7ConfigEIR *eir = [[UMSS7ConfigEIR alloc]initWithConfig:eir_config];
        if(eir.name.length  > 0)
        {
            _eir_dict[eir.name] = eir;
        }
    }

    NSArray *gsmscf_configs = [cfg getMultiGroups:[UMSS7ConfigGSMSCF type]];
    for(NSDictionary *gsmscf_config in gsmscf_configs)
    {
        UMSS7ConfigGSMSCF *gsmscf = [[UMSS7ConfigGSMSCF alloc]initWithConfig:gsmscf_config];
        if(gsmscf.name.length  > 0)
        {
            _gsmscf_dict[gsmscf.name] = gsmscf;
        }
    }

    NSArray *gmlc_configs = [cfg getMultiGroups:[UMSS7ConfigGMLC type]];
    for(NSDictionary *gmlc_config in gmlc_configs)
    {
        UMSS7ConfigGMLC *gmlc = [[UMSS7ConfigGMLC alloc]initWithConfig:gmlc_config];
        if(gmlc.name.length  > 0)
        {
            _gmlc_dict[gmlc.name] = gmlc;
        }
    }
    
    NSArray *camel_configs = [cfg getMultiGroups:[UMSS7ConfigCAMEL type]];
    for(NSDictionary *camel_config in camel_configs)
    {
        UMSS7ConfigCAMEL *camel = [[UMSS7ConfigCAMEL alloc]initWithConfig:camel_config];
        if(camel.name.length  > 0)
        {
            _camel_dict[camel.name] = camel;
        }
    }

    NSArray *smsc_configs = [cfg getMultiGroups:[UMSS7ConfigSMSC type]];
    for(NSDictionary *smsc_config in smsc_configs)
    {
        UMSS7ConfigSMSC *smsc = [[UMSS7ConfigSMSC alloc]initWithConfig:smsc_config];
        if(smsc.name.length  > 0)
        {
            _smsc_dict[smsc.name] = smsc;
        }
    }
    
    NSArray *smsproxy_configs = [cfg getMultiGroups:[UMSS7ConfigSMSProxy type]];
    for(NSDictionary *smsproxy_config in smsproxy_configs)
    {
        UMSS7ConfigSMSProxy *proxy = [[UMSS7ConfigSMSProxy alloc]initWithConfig:smsproxy_config];
        if(proxy.name.length  > 0)
        {
            _smsproxy_dict[proxy.name] = proxy;
        }
    }

    NSArray *estp_configs = [cfg getMultiGroups:[UMSS7ConfigESTP type]];
    for(NSDictionary *estp_config in estp_configs)
    {
        UMSS7ConfigESTP *estp = [[UMSS7ConfigESTP alloc]initWithConfig:estp_config];
        if(estp.name.length  > 0)
        {
            _estp_dict[estp.name] = estp;
        }
    }

    NSArray *admin_user_configs = [cfg getMultiGroups:[UMSS7ConfigAdminUser type]];
    for(NSDictionary *admin_user_config in admin_user_configs)
    {
        UMSS7ConfigAdminUser *admin_user = [[UMSS7ConfigAdminUser alloc]initWithConfig:admin_user_config];
        if(admin_user.name.length  > 0)
        {
            _admin_user_dict[admin_user.name] = admin_user;
        }
    }

    NSArray *api_user_configs = [cfg getMultiGroups:[UMSS7ConfigApiUser type]];
    for(NSDictionary *api_user_config in api_user_configs)
    {
        UMSS7ConfigApiUser *api_user = [[UMSS7ConfigApiUser alloc]initWithConfig:api_user_config];
        if(api_user.name.length  > 0)
        {
            _api_user_dict[api_user.name] = api_user;
        }
    }

    NSArray *database_pool_configs = [cfg getMultiGroups:[UMSS7ConfigDatabasePool type]];
    for(NSDictionary *database_pool_config in database_pool_configs)
    {
        UMSS7ConfigDatabasePool *e = [[UMSS7ConfigDatabasePool alloc]initWithConfig:database_pool_config];
        if(e.name.length  > 0)
        {
            _database_pool_dict[e.name] = e;
        }
    }

    NSArray *sccp_number_translation_configs = [cfg getMultiGroups:[UMSS7ConfigSCCPNumberTranslation type]];
    for(NSDictionary *sccp_number_translation_config in sccp_number_translation_configs)
    {
        UMSS7ConfigSCCPNumberTranslation *e = [[UMSS7ConfigSCCPNumberTranslation alloc]initWithConfig:sccp_number_translation_config];
        if(e.name.length  > 0)
        {
            _sccp_number_translation_dict[e.name] = e;
        }
    }
    NSArray *sccp_number_translation_entry_configs = [cfg getMultiGroups:[UMSS7ConfigSCCPNumberTranslationEntry type]];
    for(NSDictionary *sccp_number_translation_entry_config in sccp_number_translation_entry_configs)
    {
        UMSS7ConfigSCCPNumberTranslationEntry *e = [[UMSS7ConfigSCCPNumberTranslationEntry alloc]initWithConfig:sccp_number_translation_entry_config];
        NSString *parent = e.sccpNumberTranslation;
        UMSS7ConfigSCCPNumberTranslation *p = _sccp_number_translation_dict[parent];
        if(p==NULL)
        {
            p = [[UMSS7ConfigSCCPNumberTranslation alloc]initWithConfig:@{ @"name" : parent }];
            _sccp_number_translation_dict[p.name] = p;
        }
        [p addSubEntry:e];
        _sccp_number_translation_dict[p.name] = p;
    }

    NSArray *service_user_configs = [cfg getMultiGroups:[UMSS7ConfigServiceUser type]];
    for(NSDictionary *service_user_config in service_user_configs)
    {
        UMSS7ConfigServiceUser *u = [[UMSS7ConfigServiceUser alloc]initWithConfig:service_user_config];
        if(u.name.length  > 0)
        {
            _service_user_dict[u.name] = u;
        }
    }

    NSArray *service_user_profile_configs = [cfg getMultiGroups:[UMSS7ConfigServiceProfile type]];
    for(NSDictionary *service_user_profile_config in service_user_profile_configs)
    {
        UMSS7ConfigServiceProfile *up = [[UMSS7ConfigServiceProfile alloc]initWithConfig:service_user_profile_config];
        if(up.name.length  > 0)
        {
            _service_user_profile_dict[up.name] = up;
        }
    }

    NSArray *service_billing_entity_configs = [cfg getMultiGroups:[UMSS7ConfigServiceBillingEntity type]];
    for(NSDictionary *service_billing_entity_config in service_billing_entity_configs)
    {
        UMSS7ConfigServiceBillingEntity *be = [[UMSS7ConfigServiceBillingEntity alloc]initWithConfig:service_billing_entity_config];
        if(be.name.length  > 0)
        {
            _service_billing_entity_dict[be.name] = be;
        }
    }
    NSArray *imsi_pool_configs = [cfg getMultiGroups:[UMSS7ConfigIMSIPool type]];
    for(NSDictionary *imsi_pool_config in imsi_pool_configs)
    {
        UMSS7ConfigIMSIPool *pool = [[UMSS7ConfigIMSIPool alloc]initWithConfig:imsi_pool_config];
        if(pool.name.length  > 0)
        {
            _imsi_pool_dict[pool.name] = pool;
        }
    }

    NSArray *cdr_writer_configs = [cfg getMultiGroups:[UMSS7ConfigCdrWriter type]];
    for(NSDictionary *cdr_writer_config in cdr_writer_configs)
    {
        UMSS7ConfigCdrWriter *co = [[UMSS7ConfigCdrWriter alloc]initWithConfig:cdr_writer_config];
        if(co.name==NULL)
        {
            co.name=@"cdr-writer";
        }
        _cdr_writer_dict[co.name] = co;
    }

    NSArray *diameter_connection_configs = [cfg getMultiGroups:[UMSS7ConfigDiameterConnection type]];
    for(NSDictionary *diameter_connection_config in diameter_connection_configs)
    {
        UMSS7ConfigDiameterConnection *dc = [[UMSS7ConfigDiameterConnection alloc]initWithConfig:diameter_connection_config];
        if(dc.name.length  > 0)
        {
            _diameter_connection_dict[dc.name] = dc;
        }
    }

    NSArray *diameter_router_configs = [cfg getMultiGroups:[UMSS7ConfigDiameterRouter type]];
    for(NSDictionary *diameter_router_config in diameter_router_configs)
    {
        UMSS7ConfigDiameterRouter *dr = [[UMSS7ConfigDiameterRouter alloc]initWithConfig:diameter_router_config];
        if(dr.name.length  > 0)
        {
            _diameter_router_dict[dr.name] = dr;
        }
    }

    NSArray *diameter_route_configs = [cfg getMultiGroups:[UMSS7ConfigDiameterRoute type]];
    for(NSDictionary *diameter_route_config in diameter_route_configs)
    {
        UMSS7ConfigDiameterRoute *dr = [[UMSS7ConfigDiameterRoute alloc]initWithConfig:diameter_route_config];
        if(dr.name.length  > 0)
        {
            _diameter_route_dict[dr.name] = dr;
        }
    }
}



- (UMConfig *)saveConfig
{
    return NULL;
}


- (void)appendSection:(NSMutableString *)s
                 dict:(UMSynchronizedDictionary *)dict
          sectionName:(NSString *)sectionName
{
    if(dict.count > 0)
    {
        [s appendString:@"\n"];
        [s appendString:@"#-----------------------------------------------\n"];
        [s appendFormat:@"# Section %@\n", sectionName];
        [s appendString:@"#-----------------------------------------------\n"];

        NSArray *keys = [dict allKeys];
        for(id key in keys)
        {
            UMSS7ConfigObject *co = dict[key];
            [s appendString: co.configString];
            [s appendString:@"\n"];
        }
    }
}

- (void)appendSectionWithEntries:(NSMutableString *)s
                            dict:(UMSynchronizedDictionary *)dict
                     sectionName:(NSString *)sectionName
{
    if(dict.count > 0)
    {
        [s appendString:@"\n"];
        [s appendString:@"#-----------------------------------------------\n"];
        [s appendFormat:@"# Section %@\n", sectionName];
        [s appendString:@"#-----------------------------------------------\n"];

        NSArray *keys = [dict allKeys];
        for(id key in keys)
        {
            UMSS7ConfigObject *co = dict[key];
            [s appendString: co.configString];
            [s appendString:@"\n"];

            NSMutableArray<UMSS7ConfigObject *> *entries = [co subEntries];
            for(UMSS7ConfigObject *co2 in entries)
            {
                [s appendString: co2.configString];
                [s appendString:@"\n"];
            }
        }
    }
}

- (void)appendSingleSection:(NSMutableString *)s
                     config:(UMSS7ConfigObject *)co
                sectionName:(NSString *)sectionName
{
    [s appendString:@"\n"];
    [s appendString:@"#-----------------------------------------------\n"];
    [s appendFormat:@"# Section %@\n", sectionName];
    [s appendString:@"#-----------------------------------------------\n"];
    [s appendString: co.configString];
    [s appendString:@"\n"];
}

- (NSString *)configString
{
    NSMutableString *s = [[NSMutableString alloc]init];
    [s appendString:@"#-----------------------------------------------\n"];
    [s appendFormat:@"# %@ Config\n",_productName];
    [s appendFormat:@"# Written %@\n", [NSDate date]];
    [s appendString:@"#-----------------------------------------------\n\n"];
    [s appendString:@"\n"];
    
    [self appendSingleSection:s config:_generalConfig sectionName:@"general"];
    [self configStringAppendSubsections:s];
    return s;
}

- (void)configStringAppendSubsections:(NSMutableString *)s
{
    [self appendSection:s dict:_webserver_dict sectionName:[UMSS7ConfigWebserver type]];
    [self appendSection:s dict:_telnet_dict sectionName:[UMSS7ConfigTelnet type]];
    [self appendSection:s dict:_syslog_destination_dict sectionName:[UMSS7ConfigSyslogDestination type]];
     [self appendSection:s dict:_sctp_dict sectionName:[UMSS7ConfigSCTP type]];
     [self appendSection:s dict:_m2pa_dict sectionName:[UMSS7ConfigM2PA type]];
     [self appendSection:s dict:_mtp3_dict sectionName:[UMSS7ConfigMTP3 type]];
     [self appendSection:s dict:_mtp3_link_dict sectionName:[UMSS7ConfigMTP3Link type]];
     [self appendSection:s dict:_mtp3_linkset_dict sectionName:[UMSS7ConfigMTP3LinkSet type]];
     [self appendSection:s dict:_m3ua_as_dict sectionName:[UMSS7ConfigM3UAAS type]];
     [self appendSection:s dict:_m3ua_asp_dict sectionName:[UMSS7ConfigM3UAASP type]];
     [self appendSection:s dict:_mtp3_filter_dict sectionName:[UMSS7ConfigMTP3Filter type]];
     /* UMSS7ConfigMTP3FilterEntry */
     [self appendSection:s dict:_mtp3_route_dict sectionName:[UMSS7ConfigMTP3Route type]];
     [self appendSection:s dict:_sccp_dict sectionName:[UMSS7ConfigSCCP type]];
     [self appendSectionWithEntries:s dict:_sccp_destination_dict sectionName:[UMSS7ConfigSCCPDestination type]];
      /* UMSS7ConfigSCCPDestinationEntry */
      [self appendSectionWithEntries:s dict:_sccp_translation_table_dict sectionName:[UMSS7ConfigSCCPTranslationTable type]];
      /* UMSS7ConfigSCCPTranslationTableEntry */
      [self appendSectionWithEntries:s dict:_sccp_translation_table_map_dict sectionName:[UMSS7ConfigSCCPTranslationTableMap type]];
      [self appendSection:s dict:_sccp_filter_dict sectionName:[UMSS7ConfigSCCPFilter type]];
      [self appendSectionWithEntries:s dict:_sccp_number_translation_dict sectionName:[UMSS7ConfigSCCPNumberTranslation type]];
      /* UMSS7ConfigSCCPNumberTranslationEntry */
      [self appendSection:s dict:_tcap_dict sectionName:[UMSS7ConfigTCAP type]];
      [self appendSectionWithEntries:s dict:_tcap_filter_dict sectionName:[UMSS7ConfigTCAPFilter type]];
      /* [UMSS7ConfigTCAPFilterEntry */
      [self appendSection:s dict:_gsmmap_dict sectionName:[UMSS7ConfigGSMMAP type]];
      [self appendSectionWithEntries:s dict:_gsmmap_filter_dict sectionName:[UMSS7ConfigGSMMAPFilter type]];
      /* UMSS7ConfigGSMMAPFilterEntry */
      [self appendSection:s dict:_sms_dict sectionName:[UMSS7ConfigSMS type]];
      [self appendSectionWithEntries:s dict:_sms_filter_dict sectionName:[UMSS7ConfigSMSFilter type]];
      /* UMSS7ConfigSMSFilterEntry */
      [self appendSection:s dict:_hlr_dict sectionName:[UMSS7ConfigHLR type]];
      [self appendSection:s dict:_msc_dict sectionName:[UMSS7ConfigMSC type]];
      [self appendSection:s dict:_ggsn_dict sectionName:[UMSS7ConfigGGSN type]];
      [self appendSection:s dict:_sgsn_dict sectionName:[UMSS7ConfigSGSN type]];
      [self appendSection:s dict:_vlr_dict sectionName:[UMSS7ConfigVLR type]];
      [self appendSection:s dict:_eir_dict sectionName:[UMSS7ConfigEIR type]];
      [self appendSection:s dict:_gsmscf_dict sectionName:[UMSS7ConfigGSMSCF type]];
      [self appendSection:s dict:_gmlc_dict sectionName:[UMSS7ConfigGMLC type]];
      [self appendSection:s dict:_smsc_dict sectionName:[UMSS7ConfigSMSC type]];
      [self appendSection:s dict:_smsproxy_dict sectionName:[UMSS7ConfigSMSProxy type]];
      [self appendSection:s dict:_estp_dict sectionName:[UMSS7ConfigESTP type]];
      [self appendSection:s dict:_admin_user_dict sectionName:[UMSS7ConfigAdminUser type]];
      [self appendSection:s dict:_api_user_dict sectionName:[UMSS7ConfigApiUser type]];
      [self appendSection:s dict:_database_pool_dict sectionName:[UMSS7ConfigDatabasePool type]];
      [self appendSection:s dict:_service_user_dict sectionName:[UMSS7ConfigServiceUser type]];
      [self appendSection:s dict:_service_user_profile_dict sectionName:[UMSS7ConfigServiceProfile type]];
      [self appendSection:s dict:_service_billing_entity_dict sectionName:[UMSS7ConfigServiceBillingEntity type]];
      [self appendSection:s dict:_imsi_pool_dict sectionName:[UMSS7ConfigIMSIPool type]];
      [self appendSection:s dict:_cdr_writer_dict sectionName:[UMSS7ConfigCdrWriter type]];
      [self appendSection:s dict:_diameter_connection_dict sectionName:[UMSS7ConfigDiameterConnection type]];

}

- (void)writeConfigToDirectory:(NSString *)dir usingFilename:(NSString *)main_config_file_name  singleFile:(BOOL)compact
{

    NSError *e=NULL;
    if([[NSFileManager defaultManager]createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:NULL error:&e]==NO)
    {
        NSString *s = [NSString stringWithFormat:@"Can not create directory at path %@ due to error: %@",dir,e];
        @throw([NSException exceptionWithName:@"WRITE_CONFIG" reason:s userInfo:NULL]);
    }
    NSMutableString *s = [[NSMutableString alloc]init];
    [s appendString:@"#-----------------------------------------------\n"];
    [s appendFormat:@"# %@ Config\n",_productName];
    [s appendFormat:@"# Written %@\n", [NSDate date]];
    [s appendString:@"#-----------------------------------------------\n\n"];
    [s appendString:@"\n"];


    [self appendSingleSection:s config:_generalConfig sectionName:@"general"];

    if(compact)
    {
        [self configStringAppendSubsections:s];
    }
    else
    {
        [self writeSectionToDirectory:dir dict:_webserver_dict sectionName:@"webserver" general:s];
        [self writeSectionToDirectory:dir dict:_telnet_dict sectionName:@"telnet" general:s];
        [self writeSectionToDirectory:dir dict:_syslog_destination_dict sectionName:@"syslog-destination" general:s];
        [self writeSectionToDirectory:dir dict:_sctp_dict sectionName:@"sctp" general:s];
        [self writeSectionToDirectory:dir dict:_m2pa_dict sectionName:@"m2pa" general:s];
        [self writeSectionToDirectory:dir dict:_mtp3_dict sectionName:@"mtp3" general:s];
        [self writeSectionToDirectory:dir dict:_mtp3_linkset_dict sectionName:@"mtp3-linkset" general:s];
        [self writeSectionToDirectory:dir dict:_mtp3_link_dict sectionName:@"mtp3-link" general:s];
        [self writeSectionToDirectory:dir dict:_m3ua_as_dict sectionName:@"m3ua-as" general:s];
        [self writeSectionToDirectory:dir dict:_m3ua_asp_dict sectionName:@"m3ua-asp" general:s];
        [self writeSectionToDirectory:dir dict:_mtp3_filter_dict sectionName:@"mtp3-filter" general:s];
        [self writeSectionToDirectory:dir dict:_mtp3_route_dict sectionName:@"mtp3-route" general:s];
        [self writeSectionToDirectory:dir dict:_sccp_dict sectionName:@"sccp" general:s];
        [self writeSectionToDirectory:dir dict:_sccp_destination_dict sectionName:@"sccp-destination" general:s];
        [self writeSectionToDirectory:dir dict:_sccp_filter_dict sectionName:@"sccp-filter" general:s];
        [self writeSectionToDirectory:dir dict:_tcap_dict sectionName:@"tcap" general:s];
        [self writeSectionToDirectory:dir dict:_tcap_filter_dict sectionName:@"tcap-filter" general:s];
        [self writeSectionToDirectory:dir dict:_gsmmap_dict sectionName:@"gsmmap" general:s];
        [self writeSectionToDirectory:dir dict:_gsmmap_filter_dict sectionName:@"gsmmap-filter" general:s];
        [self writeSectionToDirectory:dir dict:_sms_dict sectionName:@"sms" general:s];
        [self writeSectionToDirectory:dir dict:_sms_filter_dict sectionName:@"sms-filter" general:s];
        [self writeSectionToDirectory:dir dict:_imsi_pool_dict sectionName:@"imsi-pool" general:s];
    }
    NSString *config_file  = [NSString stringWithFormat:@"%@/%@",dir,main_config_file_name];
    if(NO==[s writeToFile:config_file atomically:YES encoding:NSUTF8StringEncoding error:&e])
    {
        NSString *s = [NSString stringWithFormat:@"Can not write config file at path %@ due to error: %@",config_file,e];
        @throw([NSException exceptionWithName:@"WRITE_CONFIG" reason:s userInfo:NULL]);
    }
}

- (UMSynchronizedSortedDictionary *)fullConfigOjbect
{

#define ADD_SECTION_CONDITIONAL(d,obj,dict) \
    { \
        if(dict.count > 0) \
        { \
            UMSynchronizedSortedDictionary *d2 = [[UMSynchronizedSortedDictionary alloc]init]; \
            NSArray *keys = [dict allKeys]; \
            for(NSString *key in keys)\
            { \
                UMSS7ConfigObject *co = dict[key];\
                d2[key] = co.config;\
            } \
            d[ [obj type] ] = d2; \
        } \
    }

#define ADD_SECTION_CONDITIONAL_WITH_ENTRIES(d,obj,obj2,dict) \
    { \
        if(dict.count > 0) \
        { \
            UMSynchronizedSortedDictionary *d2 = [[UMSynchronizedSortedDictionary alloc]init]; \
            NSArray *keys = [dict allKeys]; \
            for(NSString *key in keys)\
            { \
                UMSS7ConfigObject *co = dict[key];\
                d2[key] = co.config;\
            } \
            d[ [obj type] ] = d2; \
            UMSynchronizedSortedDictionary *subentries = [[UMSynchronizedSortedDictionary alloc]init]; \
            for(NSString *key in keys) \
            { \
                UMSS7ConfigObject *co = dict[key]; \
                NSMutableArray<UMSS7ConfigObject *> *entries = [co subEntries]; \
                for(UMSS7ConfigObject *co2 in entries) \
                { \
                    subentries[co2.name] = co2.config; \
                } \
            } \
            d[ [obj2 type]] = subentries; \
        } \
    }

    UMSynchronizedSortedDictionary *d = [[UMSynchronizedSortedDictionary alloc]init];
    d[@"general"]= _generalConfig.config;
    
    ADD_SECTION_CONDITIONAL(d,UMSS7ConfigWebserver,_webserver_dict);
    ADD_SECTION_CONDITIONAL(d,UMSS7ConfigTelnet,_telnet_dict);
    ADD_SECTION_CONDITIONAL(d,UMSS7ConfigSyslogDestination,_syslog_destination_dict);
    ADD_SECTION_CONDITIONAL(d,UMSS7ConfigSCTP,_sctp_dict);
    ADD_SECTION_CONDITIONAL(d,UMSS7ConfigM2PA,_m2pa_dict);
    ADD_SECTION_CONDITIONAL(d,UMSS7ConfigMTP3Link,_mtp3_link_dict);
    ADD_SECTION_CONDITIONAL(d,UMSS7ConfigMTP3LinkSet,_mtp3_linkset_dict);
    ADD_SECTION_CONDITIONAL(d,UMSS7ConfigM3UAAS,_m3ua_as_dict);
    ADD_SECTION_CONDITIONAL(d,UMSS7ConfigM3UAASP,_m3ua_asp_dict);
    ADD_SECTION_CONDITIONAL(d,UMSS7ConfigMTP3Filter,_mtp3_filter_dict);
    ADD_SECTION_CONDITIONAL(d,UMSS7ConfigMTP3Route,_mtp3_route_dict);
    ADD_SECTION_CONDITIONAL(d,UMSS7ConfigSCCP,_sccp_dict);
    ADD_SECTION_CONDITIONAL_WITH_ENTRIES(d, UMSS7ConfigSCCPDestination,
                                            UMSS7ConfigSCCPDestinationEntry,
                                            _sccp_destination_dict);

    ADD_SECTION_CONDITIONAL_WITH_ENTRIES(d, UMSS7ConfigSCCPTranslationTable,
                                            UMSS7ConfigSCCPTranslationTableEntry,
                                            _sccp_translation_table_dict);
    
    ADD_SECTION_CONDITIONAL(d,UMSS7ConfigSCCPTranslationTableMap,_sccp_translation_table_map_dict);
    ADD_SECTION_CONDITIONAL(d, UMSS7ConfigSCCPFilter,_sccp_translation_table_dict);

    
    ADD_SECTION_CONDITIONAL_WITH_ENTRIES(d, UMSS7ConfigSCCPNumberTranslation,
                                            UMSS7ConfigSCCPNumberTranslationEntry,
                                            _sccp_number_translation_dict);

    ADD_SECTION_CONDITIONAL(d, UMSS7ConfigTCAP,_tcap_dict);
    ADD_SECTION_CONDITIONAL_WITH_ENTRIES(d, UMSS7ConfigTCAPFilter,UMSS7ConfigTCAPFilterEntry,_tcap_dict);

    ADD_SECTION_CONDITIONAL(d, UMSS7ConfigGSMMAP,_gsmmap_dict);
    ADD_SECTION_CONDITIONAL_WITH_ENTRIES(d, UMSS7ConfigGSMMAPFilter,
                                            UMSS7ConfigGSMMAPFilterEntry,
                                            _gsmmap_filter_dict);
    ADD_SECTION_CONDITIONAL(d, UMSS7ConfigSMS,_sms_dict);
    ADD_SECTION_CONDITIONAL_WITH_ENTRIES(d, UMSS7ConfigSMSFilter,
                                            UMSS7ConfigSMSFilterEntry,
                                            _sms_filter_dict);

    ADD_SECTION_CONDITIONAL(d, UMSS7ConfigHLR,_hlr_dict);
    ADD_SECTION_CONDITIONAL(d, UMSS7ConfigMSC,_msc_dict);
    ADD_SECTION_CONDITIONAL(d, UMSS7ConfigGGSN,_ggsn_dict);
    ADD_SECTION_CONDITIONAL(d, UMSS7ConfigSGSN,_sgsn_dict);
    ADD_SECTION_CONDITIONAL(d, UMSS7ConfigVLR,_vlr_dict);
    ADD_SECTION_CONDITIONAL(d, UMSS7ConfigEIR,_eir_dict);
    ADD_SECTION_CONDITIONAL(d, UMSS7ConfigGSMSCF,_gsmscf_dict);
    ADD_SECTION_CONDITIONAL(d, UMSS7ConfigGMLC,_gmlc_dict);
    ADD_SECTION_CONDITIONAL(d, UMSS7ConfigSMSC,_smsc_dict);
    ADD_SECTION_CONDITIONAL(d, UMSS7ConfigSMSProxy,_smsproxy_dict);
    ADD_SECTION_CONDITIONAL(d, UMSS7ConfigESTP,_estp_dict);
    ADD_SECTION_CONDITIONAL(d, UMSS7ConfigAdminUser,_admin_user_dict);
    ADD_SECTION_CONDITIONAL(d, UMSS7ConfigApiUser,_api_user_dict);
    ADD_SECTION_CONDITIONAL(d, UMSS7ConfigDatabasePool,_database_pool_dict);
    ADD_SECTION_CONDITIONAL(d, UMSS7ConfigServiceUser,_service_user_dict);
    ADD_SECTION_CONDITIONAL(d, UMSS7ConfigServiceProfile,_service_user_profile_dict);
    ADD_SECTION_CONDITIONAL(d, UMSS7ConfigServiceBillingEntity,_service_billing_entity_dict);
    ADD_SECTION_CONDITIONAL(d, UMSS7ConfigIMSIPool,_imsi_pool_dict);
    ADD_SECTION_CONDITIONAL(d, UMSS7ConfigCdrWriter,_cdr_writer_dict);
    ADD_SECTION_CONDITIONAL(d, UMSS7ConfigDiameterConnection,_diameter_connection_dict);
    return d;
}

/* returns YES on success */
- (void)writeSectionToDirectory:(NSString *)dir
                           dict:(UMSynchronizedDictionary *)dict
                    sectionName:(NSString *)sectionName
                        general:(NSMutableString *)general
{
    if(dict.count==0)
    {
        return;
    }
    NSString *subdir  = [NSString stringWithFormat:@"%@/%@/",dir,sectionName];

    NSError *e = NULL;
    if([[NSFileManager defaultManager]createDirectoryAtPath:subdir withIntermediateDirectories:YES attributes:NULL error:&e]==NO)
    {
        NSString *s = [NSString stringWithFormat:@"Can not create directory at path %@ due to error: %@",subdir,e];
        @throw([NSException exceptionWithName:@"WRITE_CONFIG" reason:s userInfo:NULL]);
    }

    NSArray *keys = [dict allKeys];
    for(id key in keys)
    {
        [general appendString:@"\n"];
        [general appendString:@"#-----------------------------------------------\n"];
        [general appendFormat:@"# Section %@\n", sectionName];
        [general appendString:@"#-----------------------------------------------\n"];

        UMSS7ConfigObject *co = dict[key];

        NSString *config_file_absolute  = [NSString stringWithFormat:@"%@/%@/%@.conf",dir,sectionName,co.name];
        NSString *config_file_relative  = [NSString stringWithFormat:@"%@/%@.conf",sectionName,co.name];
        NSMutableString *config = [[NSMutableString alloc]init];
        [general appendFormat:@"include=\"%@\"\n",config_file_relative];

        [config appendString:@"#-----------------------------------------------\n"];
        [config appendFormat:@"# Config for %@ %@\n", sectionName,co.name];
        [config appendString:@"#-----------------------------------------------\n"];
        [config appendString: co.configString];
        [config appendString:@"\n"];

        if(NO==[config writeToFile:config_file_absolute atomically:YES encoding:NSUTF8StringEncoding error:&e])
        {
            NSString *s = [NSString stringWithFormat:@"Can not write config file at path %@ due to error: %@",config_file_absolute,e];
            @throw([NSException exceptionWithName:@"WRITE_CONFIG" reason:s userInfo:NULL]);
        }
    }
}

/*
 **************************************************
 ** SCTP
 **************************************************
 */
#pragma mark -
#pragma mark SCCP

- (NSArray *)getSCTPNames
{
    return [[_sctp_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigSCTP *)getSCTP:(NSString *)name
{
    return _sctp_dict[name];
}

- (NSString *)addSCTP:(UMSS7ConfigSCTP*)sctp
{
    if(_sctp_dict[sctp.name] == NULL)
    {
        _sctp_dict[sctp.name] = sctp;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceSCTP:(UMSS7ConfigSCTP *)sctp
{
    _sctp_dict[sctp.name] = sctp;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteSCTP:(NSString *)name
{
    if(_sctp_dict[name]==NULL)
    {
        return @"not found";
    }
    [_sctp_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}


/*
 **************************************************
 ** M2PA
 **************************************************
 */
#pragma mark -
#pragma mark M2PA

- (NSArray *)getM2PANames
{
    return [[_m2pa_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigM2PA *)getM2PA:(NSString *)name
{
    return _m2pa_dict[name];
}

- (NSString *)addM2PA:(UMSS7ConfigM2PA*)m2pa
{
    if(_m2pa_dict[m2pa.name] == NULL)
    {
        _m2pa_dict[m2pa.name] = m2pa;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceM2PA:(UMSS7ConfigM2PA *)m2pa
{
    _m2pa_dict[m2pa.name] = m2pa;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteM2PA:(NSString *)name
{
    if(_m2pa_dict[name]==NULL)
    {
        return @"not found";
    }
    [_m2pa_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}


/*
 **************************************************
 ** MTP3
 **************************************************
 */
#pragma mark -
#pragma mark MTP3

- (NSArray *)getMTP3Names
{
    return [[_mtp3_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigMTP3 *)getMTP3:(NSString *)name
{
    return _mtp3_dict[name];
}

- (NSString *)addMTP3:(UMSS7ConfigMTP3*)mtp3
{
    if(_mtp3_dict[mtp3.name] == NULL)
    {
        _mtp3_dict[mtp3.name] = mtp3;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceMTP3:(UMSS7ConfigMTP3 *)mtp3
{
    _mtp3_dict[mtp3.name] = mtp3;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteMTP3:(NSString *)name
{
    if(_mtp3_dict[name]==NULL)
    {
        return @"not found";
    }
    [_mtp3_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}

/*
 **************************************************
 ** MTP3 Route
 **************************************************
 */
#pragma mark -
#pragma mark MTP3 Route

- (NSArray *)getMTP3RouteNames
{
    return [[_mtp3_route_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigMTP3Route *)getMTP3Route:(NSString *)name
{
    return _mtp3_route_dict[name];
}

- (NSString *)addMTP3Route:(UMSS7ConfigMTP3Route*)mtp3route
{
    if(_mtp3_route_dict[mtp3route.name] == NULL)
    {
        _mtp3_route_dict[mtp3route.name] = mtp3route;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceMTP3Route:(UMSS7ConfigMTP3Route *)mtp3route
{
    _mtp3_route_dict[mtp3route.name] = mtp3route;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteMTP3Route:(NSString *)name
{
    if(_mtp3_route_dict[name]==NULL)
    {
        return @"not found";
    }
    [_mtp3_route_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}

/*
 **************************************************
 ** MTP3 Filter
 **************************************************
 */
#pragma mark -
#pragma mark MTP3 Filter

- (NSArray *)getMTP3FilterNames
{
    return [[_mtp3_filter_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigMTP3Filter *)getMTP3Filter:(NSString *)name
{
    return _mtp3_filter_dict[name];
}

- (NSString *)addMTP3Filter:(UMSS7ConfigMTP3Filter*)mtp3filter
{
    if(_mtp3_filter_dict[mtp3filter.name] == NULL)
    {
        _mtp3_filter_dict[mtp3filter.name] = mtp3filter;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceMTP3Filter:(UMSS7ConfigMTP3Filter *)mtp3filter
{
    _mtp3_filter_dict[mtp3filter.name] = mtp3filter;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteMTP3Filter:(NSString *)name
{
    if(_mtp3_filter_dict[name]==NULL)
    {
        return @"not found";
    }
    [_mtp3_filter_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}


/*
 **************************************************
 ** MTP3-Link
 **************************************************
 */
#pragma mark -
#pragma mark MTP3Link

- (NSArray *)getMTP3LinkNames
{
    return [[_mtp3_link_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigMTP3Link *)getMTP3Link:(NSString *)name
{
    return _mtp3_link_dict[name];
}

- (NSString *)addMTP3Link:(UMSS7ConfigMTP3Link*)mtp3_link
{
    if(_mtp3_link_dict[mtp3_link.name] == NULL)
    {
        _mtp3_link_dict[mtp3_link.name] = mtp3_link;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceMTP3Link:(UMSS7ConfigMTP3Link *)mtp3_link
{
    _mtp3_link_dict[mtp3_link.name] = mtp3_link;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteMTP3Link:(NSString *)name
{
    if(_mtp3_link_dict[name]==NULL)
    {
        return @"not found";
    }
    [_mtp3_link_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}


/*
 **************************************************
 ** MTP3-LinkSet
 **************************************************
 */
#pragma mark -
#pragma mark MTP3LinkSet

- (NSArray *)getMTP3LinkSetNames
{
    return [[_mtp3_linkset_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigMTP3LinkSet *)getMTP3LinkSet:(NSString *)name
{
    return _mtp3_linkset_dict[name];
}

- (NSString *)addMTP3LinkSet:(UMSS7ConfigMTP3LinkSet*)mtp3_linkset
{
    if(_mtp3_linkset_dict[mtp3_linkset.name] == NULL)
    {
        _mtp3_linkset_dict[mtp3_linkset.name] = mtp3_linkset;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceMTP3LinkSet:(UMSS7ConfigMTP3LinkSet *)mtp3_linkset
{
    _mtp3_linkset_dict[mtp3_linkset.name] = mtp3_linkset;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteMTP3LinkSet:(NSString *)name
{
    if(_mtp3_linkset_dict[name]==NULL)
    {
        return @"not found";
    }
    [_mtp3_linkset_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}


/*
 **************************************************
 ** M3UAS
 **************************************************
 */
#pragma mark -
#pragma mark M3UAS

- (NSArray *)getM3UAASNames
{
    return [[_m3ua_as_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigM3UAAS *)getM3UAAS:(NSString *)name
{
    return _m3ua_as_dict[name];
}

- (NSString *)addM3UAAS:(UMSS7ConfigM3UAAS*)m3ua_as
{
    if(_m3ua_as_dict[m3ua_as.name] == NULL)
    {
        _m3ua_as_dict[m3ua_as.name] = m3ua_as;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceM3UAAS:(UMSS7ConfigM3UAAS *)m3ua_as
{
    _m3ua_as_dict[m3ua_as.name] = m3ua_as;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteM3UAAS:(NSString *)name
{
    if(_m3ua_as_dict[name]==NULL)
    {
        return @"not found";
    }
    [_m3ua_as_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}


/*
 **************************************************
 ** M3UASP
 **************************************************
 */
#pragma mark -
#pragma mark M3UAASP

- (NSArray *)getM3UAASPNames
{
    return [[_m3ua_asp_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigM3UAASP *)getM3UAASP:(NSString *)name
{
    return _m3ua_asp_dict[name];
}

- (NSString *)addM3UAASP:(UMSS7ConfigM3UAASP*)m3ua_asp
{
    if(_m3ua_asp_dict[m3ua_asp.name] == NULL)
    {
        _m3ua_asp_dict[m3ua_asp.name] = m3ua_asp;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceM3UAASP:(UMSS7ConfigM3UAASP *)m3ua_asp
{
    _m3ua_asp_dict[m3ua_asp.name] = m3ua_asp;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteM3UAASP:(NSString *)name
{
    if(_m3ua_asp_dict[name]==NULL)
    {
        return @"not found";
    }
    [_m3ua_asp_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}


/*
 **************************************************
 ** SCCP
 **************************************************
 */
#pragma mark -
#pragma mark SCCP

- (NSArray *)getSCCPNames
{
    return [[_sccp_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigSCCP *)getSCCP:(NSString *)name
{
    return _sccp_dict[name];
}

- (NSString *)addSCCP:(UMSS7ConfigSCCP*)sccp
{
    if(_sccp_dict[sccp.name] == NULL)
    {
        _sccp_dict[sccp.name] = sccp;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceSCCP:(UMSS7ConfigSCCP *)sccp
{
    _sccp_dict[sccp.name] = sccp;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteSCCP:(NSString *)name
{
    if(_sccp_dict[name]==NULL)
    {
        return @"not found";
    }
    [_sccp_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}

/*
**************************************************
** SCCP Filter
**************************************************
*/
#pragma mark -
#pragma mark SCCP Filter

- (NSArray *)getSCCPFilterNames
{
    return  [[_sccp_filter_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigSCCPFilter *)getSCCPFilter:(NSString *)name
{
    return _sccp_filter_dict[name];
}

- (NSString *)addSCCPFilter:(UMSS7ConfigSCCPFilter *)sccpFilter
{
    if(_sccp_filter_dict[sccpFilter.name] == NULL)
    {
        _sccp_filter_dict[sccpFilter.name] = sccpFilter;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceSCCPFilter:(UMSS7ConfigSCCPFilter *)sccpFilter
{
    _sccp_filter_dict[sccpFilter.name] = sccpFilter;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteSCCPFilter:(NSString *)name
{
    if(_sccp_filter_dict[name]==NULL)
    {
        return @"not found";
    }
    [_sccp_filter_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}

/*
 **************************************************
 ** SCCP-Destination
 **************************************************
 */
#pragma mark -
#pragma mark SCCP Destination

- (NSArray *)getSCCPDestinationNames
{
    return [[_sccp_destination_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigSCCPDestination *)getSCCPDestination:(NSString *)name
{
    return _sccp_destination_dict[name];
}

- (NSString *)addSCCPDestination:(UMSS7ConfigSCCPDestination*)sccp_destination
{
    if(_sccp_destination_dict[sccp_destination.name] == NULL)
    {
        _sccp_destination_dict[sccp_destination.name] = sccp_destination;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceSCCPDestination:(UMSS7ConfigSCCPDestination *)sccp_destination
{
    _sccp_destination_dict[sccp_destination.name] = sccp_destination;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteSCCPDestination:(NSString *)name
{
    if(_sccp_destination_dict[name]==NULL)
    {
        return @"not found";
    }
    [_sccp_destination_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}

/*
 **************************************************
 ** SCCP-GTT Translation Tables
 **************************************************
 */
#pragma mark -
#pragma mark SCCP TranslationTable

- (NSArray *)getSCCPTranslationTableNames
{
    return [[_sccp_translation_table_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigSCCPTranslationTable *)getSCCPTranslationTable:(NSString *)name
{
    return _sccp_translation_table_dict[name];

}

- (NSString *)addSCCPTranslationTable:(UMSS7ConfigSCCPTranslationTable*)sccp_translation_table
{
    if(_sccp_translation_table_dict[sccp_translation_table.name] == NULL)
    {
        _sccp_translation_table_dict[sccp_translation_table.name] = sccp_translation_table;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";

}
- (NSString *)replaceSCCPTranslationTable:(UMSS7ConfigSCCPTranslationTable *)sccp_translation_table
{
    _sccp_translation_table_dict[sccp_translation_table.name] = sccp_translation_table;
    _dirty=YES;
    return @"ok";

}
- (NSString *)deleteSCCPTranslationTable:(NSString *)name
{
    if(_sccp_translation_table_dict[name]==NULL)
    {
        return @"not found";
    }
    [_sccp_translation_table_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}

/*
**************************************************
** SCCP-GTT Translation Table Entries
**************************************************
*/
#pragma mark -
#pragma mark SCCP TranslationTableEntry

- (NSArray *)getSCCPTranslationTableEntryNames
{
    return [[_sccp_translation_table_entry_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigSCCPTranslationTableEntry *)getSCCPTranslationTableEntry:(NSString *)name
{
    return _sccp_translation_table_entry_dict[name];
}

- (NSString *)addSCCPTranslationTableEntry:(UMSS7ConfigSCCPTranslationTableEntry *)entry
{
    if(_sccp_translation_table_entry_dict[entry.name])
    {
        _sccp_translation_table_entry_dict[entry.name] = entry;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceSCCPTranslationTableEntry:(UMSS7ConfigSCCPTranslationTableEntry *)entry
{
    _sccp_translation_table_entry_dict[entry.name] = entry;
    _dirty=YES;
    return @"ok";

}
- (NSString *)deleteSCCPTranslationTableEntry:(NSString *)name
{
    if(_sccp_translation_table_entry_dict[name]==NULL)
    {
        return @"not found";
    }
    [_sccp_translation_table_entry_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}

/*
**************************************************
** SCCP-GTT Translation Table Map
**************************************************
*/
#pragma mark -
#pragma mark SCCP TranslationTableMap

- (NSArray *)getSCCPTranslationTableMap
{
    return [[_sccp_translation_table_map_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigSCCPTranslationTableMap *)getSCCPTranslationTableMap:(NSString *)name
{
    return _sccp_translation_table_map_dict[name];

}

- (NSString *)addSCCPTranslationTableMap:(UMSS7ConfigSCCPTranslationTableMap *)sccp_translation_table_map
{
    if(_sccp_translation_table_map_dict[sccp_translation_table_map.name] == NULL)
    {
        _sccp_translation_table_dict[sccp_translation_table_map.name] = sccp_translation_table_map;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";

}
- (NSString *)replaceSCCPTranslationTableMap:(UMSS7ConfigSCCPTranslationTableMap *)sccp_translation_table_map
{
    _sccp_translation_table_map_dict[sccp_translation_table_map.name] = sccp_translation_table_map;
    _dirty=YES;
    return @"ok";

}
- (NSString *)deleteSCCPTranslationTableMap:(NSString *)name
{
    if(_sccp_translation_table_map_dict[name]==NULL)
    {
        return @"not found";
    }
    [_sccp_translation_table_map_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}

/*
 **************************************************
 ** SCCP-NumberTranslation
 **************************************************
 */
#pragma mark -
#pragma mark SCCP Number Translation

- (NSArray *)getSCCPNumberTranslationNames
{
    return [[_sccp_number_translation_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigSCCPNumberTranslation *)getSCCPNumberTranslation:(NSString *)name;
{
    return _sccp_number_translation_dict[name];
}

- (NSString *)addSCCPNumberTranslation:(UMSS7ConfigSCCPNumberTranslation*)number_translation;
{
    if(_sccp_number_translation_dict[number_translation.name] == NULL)
    {
        _sccp_number_translation_dict[number_translation.name] = number_translation;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceSCCPNumberTranslation:(UMSS7ConfigSCCPNumberTranslation *)number_translation;
{
    _sccp_number_translation_dict[number_translation.name] = number_translation;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteSCCPNumberTranslation:(NSString *)name;
{
    if(_sccp_number_translation_dict[name]==NULL)
    {
        return @"not found";
    }
    [_sccp_number_translation_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}

/*
 **************************************************
 ** TCAP
 **************************************************
 */
#pragma mark -
#pragma mark TCAP

- (NSArray *)getTCAPNames
{
    return [[_tcap_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigTCAP *)getTCAP:(NSString *)name
{
    return _tcap_dict[name];
}

- (NSString *)addTCAP:(UMSS7ConfigTCAP *)tcap
{
    if(_tcap_dict[tcap.name] == NULL)
    {
        _tcap_dict[tcap.name] = tcap;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceTCAP:(UMSS7ConfigTCAP *)tcap
{
    _tcap_dict[tcap.name] = tcap;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteTCAP:(NSString *)name
{
    if(_tcap_dict[name]==NULL)
    {
        return @"not found";
    }
    [_tcap_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}

/*
**************************************************
** TCAP Filter
**************************************************
*/
#pragma mark -
#pragma mark TCAP Filter

- (NSArray *)getTCAPFilterNames
{
    return [[_tcap_filter_dict allKeys]sortedStringsArray];

}

- (UMSS7ConfigTCAPFilter *)getTCAPFilter:(NSString *)name
{
    return _tcap_filter_dict[name];
}

- (NSString *)addTCAPFilter:(UMSS7ConfigTCAPFilter *)tcapFilter
{
    if(_tcap_filter_dict[tcapFilter.name] == NULL)
    {
        _tcap_filter_dict[tcapFilter.name] = tcapFilter;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceTCAPFilter:(UMSS7ConfigTCAPFilter *)tcapFilter
{
    _tcap_filter_dict[tcapFilter.name] = tcapFilter;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteTCAPFilter:(NSString *)name
{
    if(_tcap_filter_dict[name]==NULL)
    {
        return @"not found";
    }
    [_tcap_filter_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}

/*
 **************************************************
 ** GSMMAP
 **************************************************
 */
#pragma mark -
#pragma mark GSMMAP

- (NSArray *)getGSMMAPNames
{
    return [[_gsmmap_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigGSMMAP *)getGSMMAP:(NSString *)name
{
    return _gsmmap_dict[name];
}

- (NSString *)addGSMMAP:(UMSS7ConfigGSMMAP *)gsmmap
{
    if(_gsmmap_dict[gsmmap.name] == NULL)
    {
        _gsmmap_dict[gsmmap.name] = gsmmap;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceGSMMAP:(UMSS7ConfigGSMMAP *)gsmmap
{
    _gsmmap_dict[gsmmap.name] = gsmmap;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteGSMMAP:(NSString *)name
{
    if(_gsmmap_dict[name]==NULL)
    {
        return @"not found";
    }
    [_gsmmap_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}


/*
 **************************************************
 ** GSMMAP Filter
 **************************************************
 */
#pragma mark -
#pragma mark GSMMAP Filter

- (NSArray *)getGSMMAPFilterNames
{
    return [[_gsmmap_filter_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigGSMMAPFilter *)getGSMMAPFilter:(NSString *)name
{
    return _gsmmap_filter_dict[name];
}

- (NSString *)addGSMMAPFilter:(UMSS7ConfigGSMMAP *)gsmmapFilter
{
    if(_gsmmap_filter_dict[gsmmapFilter.name] == NULL)
    {
        _gsmmap_filter_dict[gsmmapFilter.name] = gsmmapFilter;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceGSMMAPFilter:(UMSS7ConfigGSMMAP *)gsmmapFilter
{
    _gsmmap_filter_dict[gsmmapFilter.name] = gsmmapFilter;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteGSMMAPFilter:(NSString *)name
{
    if(_gsmmap_filter_dict[name]==NULL)
    {
        return @"not found";
    }
    [_gsmmap_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}

/*
 **************************************************
 ** SMS
 **************************************************
 */
#pragma mark -
#pragma mark SMS

- (NSArray *)getSMSNames
{
    return [[_sms_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigSMS *)getSMS:(NSString *)name
{
    return _sms_dict[name];
}

- (NSString *)addSMS:(UMSS7ConfigSMS*)sms
{
    if(_sms_dict[sms.name] == NULL)
    {
        _sms_dict[sms.name] = sms;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceSMS:(UMSS7ConfigSMS *)sms
{
    _sms_filter_dict[sms.name] = sms;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteSMS:(NSString *)name
{
    if(_sms_dict[name]==NULL)
    {
        return @"not found";
    }
    [_sms_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}

/*
 **************************************************
 ** SMS Filter
 **************************************************
 */
#pragma mark -
#pragma mark SMS Filter

- (NSArray *)getSMSFilterNames
{
    return [[_sms_filter_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigSMSFilter *)getSMSFilter:(NSString *)name
{
    return _sms_filter_dict[name];
}

- (NSString *)addSMSFilter:(UMSS7ConfigSMS*)smsFilter
{
    if(_sms_filter_dict[smsFilter.name] == NULL)
    {
        _sms_filter_dict[smsFilter.name] = smsFilter;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceSMSFilter:(UMSS7ConfigSMSFilter *)smsFilter
{
    _sms_filter_dict[smsFilter.name] = smsFilter;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteSMSFilter:(NSString *)name
{
    if(_sms_filter_dict[name]==NULL)
    {
        return @"not found";
    }
    [_sms_filter_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}


/*
 **************************************************
 ** MSC
 **************************************************
 */
#pragma mark -
#pragma mark MSC

- (NSArray *)getMSCNames
{
    return [[_msc_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigMSC *)getMSC:(NSString *)name
{
    return _msc_dict[name];
}

- (NSString *)addMSC:(UMSS7ConfigMSC *)msc
{
    if(_msc_dict[msc.name] == NULL)
    {
        _msc_dict[msc.name] = msc;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceMSC:(UMSS7ConfigMSC *)msc
{
    _msc_dict[msc.name] = msc;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteMSC:(NSString *)name
{
    if(_msc_dict[name]==NULL)
    {
        return @"not found";
    }
    [_msc_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}

/*
 **************************************************
 ** GGSN
 **************************************************
 */
#pragma mark -
#pragma mark GGSN

- (NSArray *)getGGSNNames
{
    return [[_ggsn_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigGGSN *)getGGSN:(NSString *)name
{
    return _ggsn_dict[name];
}

- (NSString *)addGGSN:(UMSS7ConfigGGSN *)ggsn
{
    if(_ggsn_dict[ggsn.name] == NULL)
    {
        _ggsn_dict[ggsn.name] = ggsn;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceGGSN:(UMSS7ConfigGGSN *)ggsn
{
    _ggsn_dict[ggsn.name] = ggsn;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteGGSN:(NSString *)name
{
    if(_ggsn_dict[name]==NULL)
    {
        return @"not found";
    }
    [_ggsn_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}

/*
 **************************************************
 ** SGSN
 **************************************************
 */
#pragma mark -
#pragma mark SGSN

- (NSArray *)getSGSNNames
{
    return [[_sgsn_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigSGSN *)getSGSN:(NSString *)name
{
    return _sgsn_dict[name];
}

- (NSString *)addSGSN:(UMSS7ConfigSGSN *)sgsn
{
    if(_sgsn_dict[sgsn.name] == NULL)
    {
        _sgsn_dict[sgsn.name] = sgsn;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceSGSN:(UMSS7ConfigSGSN *)sgsn
{
    _sgsn_dict[sgsn.name] = sgsn;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteSGSN:(NSString *)name
{
    if(_sgsn_dict[name]==NULL)
    {
        return @"not found";
    }
    [_sgsn_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}
/*
 **************************************************
 ** HLR
 **************************************************
 */
#pragma mark -
#pragma mark HLR

- (NSArray *)getHLRNames
{
    return [[_hlr_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigHLR *)getHLR:(NSString *)name
{
    return _hlr_dict[name];
}

- (NSString *)addHLR:(UMSS7ConfigHLR *)hlr
{
    if(_hlr_dict[hlr.name] == NULL)
    {
        _hlr_dict[hlr.name] = hlr;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceHLR:(UMSS7ConfigHLR *)hlr
{
    _hlr_dict[hlr.name] = hlr;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteHLR:(NSString *)name
{
    if(_hlr_dict[name]==NULL)
    {
        return @"not found";
    }
    [_hlr_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}

/*
 **************************************************
 ** VLR
 **************************************************
 */
#pragma mark -
#pragma mark VLR

- (NSArray *)getVLRNames
{
    return [[_vlr_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigVLR *)getVLR:(NSString *)name
{
    return _vlr_dict[name];
}

- (NSString *)addVLR:(UMSS7ConfigVLR *)vlr
{
    if(_vlr_dict[vlr.name] == NULL)
    {
        _vlr_dict[vlr.name] = vlr;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceVLR:(UMSS7ConfigVLR *)vlr
{
    _vlr_dict[vlr.name] = vlr;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteVLR:(NSString *)name
{
    if(_vlr_dict[name]==NULL)
    {
        return @"not found";
    }
    [_vlr_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}

/*
 **************************************************
 ** SMSC
 **************************************************
 */
#pragma mark -
#pragma mark SMSC

- (NSArray *)getSMSCNames
{
    return [[_smsc_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigSMSC *)getSMSC:(NSString *)name
{
    return _smsc_dict[name];
}

- (NSString *)addSMSC:(UMSS7ConfigSMSC *)smsc
{
    if(_smsc_dict[smsc.name] == NULL)
    {
        _smsc_dict[smsc.name] = smsc;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceSMSC:(UMSS7ConfigSMSC *)smsc
{
    _smsc_dict[smsc.name] = smsc;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteSMSC:(NSString *)name
{
    if(_smsc_dict[name]==NULL)
    {
        return @"not found";
    }
    [_smsc_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}
/*
 **************************************************
 ** GSMSCF
 **************************************************
 */
#pragma mark -
#pragma mark GSMSCF

- (NSArray *)getGSMSCFNames
{
    return [[_gsmscf_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigGSMSCF *)getGSMSCF:(NSString *)name
{
    return _gsmscf_dict[name];
}

- (NSString *)addGSMSCF:(UMSS7ConfigGSMSCF *)gsmscf
{
    if(_gsmscf_dict[gsmscf.name] == NULL)
    {
        _gsmscf_dict[gsmscf.name] = gsmscf;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceGSMSCF:(UMSS7ConfigGSMSCF *)gsmscf
{
    _gsmscf_dict[gsmscf.name] = gsmscf;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteGSMSCF:(NSString *)name
{
    if(_gsmscf_dict[name]==NULL)
    {
        return @"not found";
    }
    [_gsmscf_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}

/*
 **************************************************
 ** GMLC
 **************************************************
 */
#pragma mark -
#pragma mark GMLC

- (NSArray *)getGMLCNames
{
    return [[_gmlc_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigGMLC *)getGMLC:(NSString *)name
{
    return _gmlc_dict[name];
}

- (NSString *)addGMLC:(UMSS7ConfigGMLC *)gmlc
{
    if(_gsmmap_dict[gmlc.name] == NULL)
    {
        _gmlc_dict[gmlc.name] = gmlc;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceGMLC:(UMSS7ConfigGMLC *)gmlc
{
    _gmlc_dict[gmlc.name] = gmlc;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteGMLC:(NSString *)name
{
    if(_gmlc_dict[name]==NULL)
    {
        return @"not found";
    }
    [_gmlc_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}


/*
 **************************************************
 ** EIR
 **************************************************
 */
#pragma mark -
#pragma mark EIR

- (NSArray *)getEIRNames
{
    return [[_eir_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigEIR *)getEIR:(NSString *)name
{
    return _eir_dict[name];
}

- (NSString *)addEIR:(UMSS7ConfigEIR *)eir
{
    if(_eir_dict[eir.name] == NULL)
    {
        _eir_dict[eir.name] = eir;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceEIR:(UMSS7ConfigEIR *)eir
{
    _eir_dict[eir.name] = eir;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteEIR:(NSString *)name
{
    if(_eir_dict[name]==NULL)
    {
        return @"not found";
    }
    [_eir_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}

/*
 **************************************************
 ** SMSProxy
 **************************************************
 */
#pragma mark -
#pragma mark SMSProxy

- (NSArray *)getSMSProxyNames
{
    return [[_smsproxy_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigSMSProxy *)getSMSProxy:(NSString *)name
{
    return _smsproxy_dict[name];
}

- (NSString *)addSMSProxy:(UMSS7ConfigSMSProxy *)proxy
{
    if(_smsproxy_dict[proxy.name] == NULL)
    {
        _smsproxy_dict[proxy.name] = proxy;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceSMSProxy:(UMSS7ConfigSMSProxy *)proxy
{
    _smsproxy_dict[proxy.name] = proxy;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteSMSProxy:(NSString *)name
{
    if(_smsproxy_dict[name]==NULL)
    {
        return @"not found";
    }
    [_smsproxy_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}

/*
 **************************************************
 ** ESTP
 **************************************************
 */
#pragma mark -
#pragma mark ESTP

- (NSArray *)getESTPNames
{
    return [[_estp_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigESTP *)getESTP:(NSString *)name
{
    return _estp_dict[name];
}

- (NSString *)addESTP:(UMSS7ConfigESTP *)estp
{
    if(_estp_dict[estp.name] == NULL)
    {
        _estp_dict[estp.name] = estp;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceESTP:(UMSS7ConfigESTP *)estp
{
    _estp_dict[estp.name] = estp;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteESTP:(NSString *)name
{
    if(_estp_dict[name]==NULL)
    {
        return @"not found";
    }
    [_estp_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}

/*
 **************************************************
 ** MAPI
 **************************************************
 */
#pragma mark -
#pragma mark MAPI

- (NSArray *)getMAPINames
{
    return [[_mapi_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigMAPI *)getMAPI:(NSString *)name
{
    return _estp_dict[name];
}

- (NSString *)addMAPI:(UMSS7ConfigMAPI *)mapi
{
    if(_mapi_dict[mapi.name] == NULL)
    {
        _mapi_dict[mapi.name] = mapi;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceMAPI:(UMSS7ConfigMAPI *)mapi
{
    _mapi_dict[mapi.name] = mapi;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteMAPI:(NSString *)name
{
    if(_mapi_dict[name]==NULL)
    {
        return @"not found";
    }
    [_mapi_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}


/*
 **************************************************
 ** IMSI-Pool
 **************************************************
 */

#pragma mark -
#pragma mark IMSIPool

- (NSArray *)getIMSIPoolNames
{
    return [[_imsi_pool_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigIMSIPool *)getIMSIPool:(NSString *)name
{
    return _imsi_pool_dict[name];
}

- (NSString *)addIMSIPool:(UMSS7ConfigIMSIPool *)pool
{
    if(_imsi_pool_dict[pool.name] == NULL)
    {
        _imsi_pool_dict[pool.name] = pool;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceIMSIPool:(UMSS7ConfigIMSIPool *)pool
{
    _imsi_pool_dict[pool.name] = pool;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteIMSIPool:(NSString *)name
{
    if(_imsi_pool_dict[name]==NULL)
    {
        return @"not found";
    }
    [_imsi_pool_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}


/**************************************************
** SS7CDRWriter
**************************************************
*/

#pragma mark -
#pragma mark IMSIPool

- (NSArray *)getCdrWriterNames
{
    return [[_cdr_writer_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigCdrWriter *)getCdrWriter:(NSString *)name
{
    return _cdr_writer_dict[name];
}

- (NSString *)addCdrWriter:(UMSS7ConfigCdrWriter *)cdrw
{
    if(_cdr_writer_dict[cdrw.name] == NULL)
    {
        _cdr_writer_dict[cdrw.name] = cdrw;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceCdrWriter:(UMSS7ConfigCdrWriter *)cdrw
{
    _cdr_writer_dict[cdrw.name] = cdrw;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteCdrWriter:(NSString *)name
{
    if(_cdr_writer_dict[name]==NULL)
    {
        return @"not found";
    }
    [_cdr_writer_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}

/*
 **************************************************
 ** Webserver
 **************************************************
 */
#pragma mark -
#pragma mark Webserver

- (NSArray *)getWebserverNames
{
    return [[_webserver_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigWebserver *)getWebserver:(NSString *)name
{
    return _webserver_dict[name];
}

- (NSString *)addWebserver:(UMSS7ConfigWebserver *)webserver
{
    if(_webserver_dict[webserver.name] == NULL)
    {
        _webserver_dict[webserver.name] = webserver;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceWebserver:(UMSS7ConfigWebserver *)webserver
{
    _webserver_dict[webserver.name] = webserver;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteWebserver:(NSString *)name
{
    if(_webserver_dict[name]==NULL)
    {
        return @"not found";
    }
    [_webserver_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}

/*
 **************************************************
 ** telnet server
 **************************************************
 */
#pragma mark -
#pragma mark Telnet

- (NSArray *)getTelnetNames
{
    return [[_telnet_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigTelnet *)getTelnet:(NSString *)name
{
    return _telnet_dict[name];
}

- (NSString *)addTelnet:(UMSS7ConfigTelnet *)telnet
{
    if(_telnet_dict[telnet.name] == NULL)
    {
        _telnet_dict[telnet.name] = telnet;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceTelnet:(UMSS7ConfigTelnet *)telnet
{
    _telnet_dict[telnet.name] = telnet;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteTelnet:(NSString *)name
{
    if(_telnet_dict[name]==NULL)
    {
        return @"not found";
    }
    [_telnet_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}

/*
 **************************************************
 ** Syslog Destinations
***************************************************
 */
#pragma mark -
#pragma mark Syslog Destination

- (NSArray *)getSyslogDestinationNames
{
    return [[_syslog_destination_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigSyslogDestination *)getSyslogDestination:(NSString *)name
{
    return _syslog_destination_dict[name];
}

- (NSString *)addSyslogDestination:(UMSS7ConfigSyslogDestination *)syslog
{
    if(_syslog_destination_dict[syslog.name] == NULL)
    {
        _syslog_destination_dict[syslog.name] = syslog;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceSyslogDestination:(UMSS7ConfigSyslogDestination *)syslog
{
    _syslog_destination_dict[syslog.name] = syslog;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteSyslogDestination:(NSString *)name
{
    if(_syslog_destination_dict[name]==NULL)
    {
        return @"not found";
    }
    [_syslog_destination_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}


/*
 **************************************************
 ** AdminUser
 **************************************************
 */
#pragma mark -
#pragma mark AdminUser

- (NSArray *)getAdminUserNames
{
    return [[_admin_user_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigAdminUser *)getAdminUser:(NSString *)name
{
    return _admin_user_dict[name];
}

- (UMSS7ConfigAdminUser *)getAdminUserByIp:(NSString *)ip
{
    NSArray *keys = [_admin_user_dict allKeys];
    for(NSString *key in keys)
    {
        UMSS7ConfigAdminUser *u = _admin_user_dict[key];
        if([u matchesIpAddress:ip])
        {
            return u;
        }
    }
    return NULL;
}

- (NSString *)addAdminUser:(UMSS7ConfigAdminUser *)user
{
    if(_admin_user_dict[user.name] == NULL)
    {
        _admin_user_dict[user.name] = user;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceAdminUser:(UMSS7ConfigAdminUser *)user
{
    _admin_user_dict[user.name] = user;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteAdminUser:(NSString *)name
{
    if(_admin_user_dict[name]==NULL)
    {
        return @"not found";
    }
    [_admin_user_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}


/*
 **************************************************
 ** ApiUser
 **************************************************
 */
#pragma mark -
#pragma mark ApiUser

- (NSArray *)getApiUserNames
{
    return [[_api_user_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigApiUser *)getApiUser:(NSString *)name
{
    return _api_user_dict[name];
}

- (NSString *)addApiUser:(UMSS7ConfigApiUser *)user
{
    if(_api_user_dict[user.name] == NULL)
    {
        _api_user_dict[user.name] = user;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceApiUser:(UMSS7ConfigApiUser *)user
{
    _api_user_dict[user.name] = user;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteApiUser:(NSString *)name
{
    if(_api_user_dict[name]==NULL)
    {
        return @"not found";
    }
    [_api_user_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}
///
/*
 **************************************************
 ** ServiceUser
 **************************************************
 */
#pragma mark -
#pragma mark ServiceUser

- (NSArray *)getServiceUserNames
{
    return [[_service_user_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigServiceUser *)getServiceUser:(NSString *)name
{
    return _service_user_dict[name];
}

- (NSString *)addServiceUser:(UMSS7ConfigServiceUser *)user
{
    if(_service_user_dict[user.name] == NULL)
    {
        _service_user_dict[user.name] = user;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceServiceUser:(UMSS7ConfigServiceUser *)user
{
    _service_user_dict[user.name] = user;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteServiceUser:(NSString *)name
{
    if(_service_user_dict[name]==NULL)
    {
        return @"not found";
    }
    [_service_user_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}

/*
 **************************************************
 ** ServiceUserProfile
 **************************************************
 */
#pragma mark -
#pragma mark ServiceUserProfile


- (NSArray *)getServiceUserProfileNames
{
    return [[_service_user_profile_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigServiceProfile *)getServiceUserProfile:(NSString *)name
{
    return _service_user_profile_dict[name];
}

- (NSString *)addServiceUserProfile:(UMSS7ConfigServiceProfile *)profile
{
    if(_service_user_profile_dict[profile.name] == NULL)
    {
        _service_user_profile_dict[profile.name] = profile;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceServiceUserProfile:(UMSS7ConfigServiceProfile *)profile
{
    _service_user_profile_dict[profile.name] = profile;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteServiceUserProfile:(NSString *)name
{
    if(_service_user_profile_dict[name]==NULL)
    {
        return @"not found";
    }
    [_service_user_profile_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}


/*
 **************************************************
 ** ServiceBillingEntity
 **************************************************
 */
#pragma mark -
#pragma mark ServiceBillingEntity


- (NSArray *)getServiceBillingEntityNames
{
    return [[_service_billing_entity_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigServiceBillingEntity *)getServiceBillingEntity:(NSString *)name
{
    return _service_billing_entity_dict [name];
}

- (NSString *)addServiceBillingEntity:(UMSS7ConfigServiceBillingEntity *)be
{
    if(_service_billing_entity_dict[be.name] == NULL)
    {
        _service_billing_entity_dict[be.name] = be;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceServiceBillingEntity:(UMSS7ConfigServiceBillingEntity *)be
{
    _service_billing_entity_dict[be.name] = be;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteServiceBillingEntitye:(NSString *)name
{
    if(_service_billing_entity_dict[name]==NULL)
    {
        return @"not found";
    }
    [_service_billing_entity_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}


/*
 **************************************************
 ** DiameterConnection
 **************************************************
 */
#pragma mark -
#pragma mark DiameterConnection

- (NSArray *)getDiameterConnectionNames
{
    return [[_diameter_connection_dict allKeys]sortedStringsArray];
}
- (UMSS7ConfigDiameterConnection *)getDiameterConnection:(NSString *)name
{
    return _diameter_connection_dict [name];
}

- (NSString *)addDiameterConnection:(UMSS7ConfigDiameterConnection *)dc
{
    if(_diameter_connection_dict[dc.name] == NULL)
    {
        _diameter_connection_dict[dc.name] = dc;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceDiameterConnection:(UMSS7ConfigDiameterConnection *)dc
{
    _diameter_connection_dict[dc.name] = dc;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteDiameterConnection:(NSString *)name
{
    if(_diameter_connection_dict[name]==NULL)
    {
        return @"not found";
    }
    [_diameter_connection_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}

/*
 **************************************************
 ** DiameterRouter
 **************************************************
 */
#pragma mark -
#pragma mark DiameterRouter

- (NSArray *)getDiameterRouterNames
{
    return [[_diameter_router_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigDiameterRouter *)getDiameterRouter:(NSString *)name
{
    return _diameter_router_dict [name];
}

- (NSString *)addDiameterRouter:(UMSS7ConfigDiameterRouter *)dc
{
    if(_diameter_router_dict[dc.name] == NULL)
    {
        _diameter_router_dict[dc.name] = dc;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceDiameterRouter:(UMSS7ConfigDiameterRouter *)dc
{
    _diameter_router_dict[dc.name] = dc;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteDiameterRouter:(NSString *)name
{
    if(_diameter_router_dict[name]==NULL)
    {
        return @"not found";
    }
    [_diameter_router_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}

/*
 **************************************************
 ** DiameterRouter
 **************************************************
 */
#pragma mark -
#pragma mark DiameterRoute

- (NSArray *)getDiameterRoutes
{
    return [[_diameter_route_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigDiameterRoute *)getDiameterRoute:(NSString *)name
{
    return _diameter_route_dict [name];
}

- (NSString *)addDiameterRoute:(UMSS7ConfigDiameterRoute *)dc
{
    if(_diameter_route_dict[dc.name] == NULL)
    {
        _diameter_route_dict[dc.name] = dc;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceDiameterRoute:(UMSS7ConfigDiameterRoute *)dc
{
    _diameter_route_dict[dc.name] = dc;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteDiameterRoute:(NSString *)name
{
    if(_diameter_route_dict[name]==NULL)
    {
        return @"not found";
    }
    [_diameter_route_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}

/*
 **************************************************
 ** PointcodeTranslationTable
 **************************************************
 */
#pragma mark -
#pragma mark PointcodeTranslationTable
- (NSArray *)getPointcodeTranslationTables
{
    return [[_mtp3_pctrans_dict allKeys]sortedStringsArray];

}

- (UMSS7ConfigMTP3PointCodeTranslationTable *)getPointcodeTranslationTable:(NSString *)name
{
    return _mtp3_pctrans_dict [name];
}

- (NSString *)addPointcodeTranslationTable:(UMSS7ConfigMTP3PointCodeTranslationTable *)pctt
{
    if(_mtp3_pctrans_dict[pctt.name] == NULL)
    {
        _mtp3_pctrans_dict[pctt.name] = pctt;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";

}

- (NSString *)replacePointcodeTranslationTable:(UMSS7ConfigMTP3PointCodeTranslationTable *)pctt
{
    _mtp3_pctrans_dict[pctt.name] = pctt;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deletePointcodeTranslationTable:(NSString *)name
{
    if(_mtp3_pctrans_dict[name]==NULL)
    {
        return @"not found";
    }
    [_mtp3_pctrans_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}
/*
 **************************************************
 ** Camel
 **************************************************
 */
#pragma mark -
#pragma mark CAMEL

- (NSArray *)getCAMELNames
{
    return [[_camel_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigCAMEL *)getCAMEL:(NSString *)name
{
    return _camel_dict[name];
}

- (NSString *)addCAMEL:(UMSS7ConfigCAMEL *)camel
{
    if(_camel_dict[camel.name] == NULL)
    {
        _camel_dict[camel.name] = camel;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";

}

- (NSString *)replaceCAMEL:(UMSS7ConfigCAMEL *)camel
{
    _camel_dict[camel.name] = camel;
    _dirty=YES;
    return @"ok";
}


- (NSString *)deleteCAMEL:(NSString *)name
{
    if(_camel_dict[name]==NULL)
    {
        return @"not found";
    }
    [_camel_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}

/*
 **************************************************
 ** MNP Databases
 **************************************************
 */
#pragma mark -
#pragma mark MNP

- (NSArray *)getMnpDatabaseNames
{
    return [[_mnpDatabases_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigMnpDatabase *)getMnpDatabase:(NSString *)name
{
    return _mnpDatabases_dict[name];
}

- (NSString *)addMnpDatabase:(UMSS7ConfigMnpDatabase *)mnpdb
{
    if(_mnpDatabases_dict[mnpdb.name] == NULL)
    {
        _mnpDatabases_dict[mnpdb.name] = mnpdb;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";

}

- (NSString *)replaceMnpDatabase:(UMSS7ConfigMnpDatabase *)mnpdb
{
    _mnpDatabases_dict[mnpdb.name] = mnpdb;
    _dirty=YES;
    return @"ok";
}


- (NSString *)deleteMnpDatabase:(NSString *)name
{
    if(_mnpDatabases_dict[name]==NULL)
    {
        return @"not found";
    }
    [_mnpDatabases_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}

/*
 **************************************************
 ** Mirror Port
 **************************************************
 */
#pragma mark -
#pragma mark Mirror Port

- (NSArray *)getMirrorPortNames
{
    return [[_mirrorPorts_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigMirrorPort *)getMirrorPort:(NSString *)name
{
    return _mirrorPorts_dict[name];
}

- (NSString *)addMirrorPort:(UMSS7ConfigMirrorPort *)mp
{
    if(_mirrorPorts_dict[mp.name] == NULL)
    {
        _mirrorPorts_dict[mp.name] = mp;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceMirrorPort:(UMSS7ConfigMirrorPort *)mp
{
    _mirrorPorts_dict[mp.name] = mp;
    _dirty=YES;
    return @"ok";
}
- (NSString *)deleteMirrorPort:(NSString *)name
{
    if(_mirrorPorts_dict[name]==NULL)
    {
        return @"not found";
    }
    [_mirrorPorts_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}


/*
 **************************************************
 ** SMS Delivery Providers
 **************************************************
 */

- (NSArray *)getSMSDeliveryProviderNames
{
    return [[_smsDeliveryProviders_dict allKeys]sortedStringsArray];
}
- (UMSS7ConfigSMSDeliveryProvider *)getSMSDeliveryProvider:(NSString *)name
{
    return _smsDeliveryProviders_dict[name];
}

- (NSString *)addSMSDeliveryProvider:(UMSS7ConfigSMSDeliveryProvider *)provider
{
    if(_smsDeliveryProviders_dict[provider.name] == NULL)
    {
        _smsDeliveryProviders_dict[provider.name] = provider;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceSMSDeliveryProvider:(UMSS7ConfigSMSDeliveryProvider *)provider
{
    _smsDeliveryProviders_dict[provider.name] = provider;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteSMSDeliveryProvider:(NSString *)name
{
    if(_smsDeliveryProviders_dict[name]==NULL)
    {
        return @"not found";
    }
    [_smsDeliveryProviders_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}


/*
 **************************************************
 ** SMPPServers
 **************************************************
 */

- (NSArray *)getSMPPServers
{
    return [[_smppServers_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigSMPPServer *)getSMPPServer:(NSString *)name
{
    return _smppServers_dict[name];
}

- (NSString *)addSMPPServer:(UMSS7ConfigSMPPServer *)provider
{
    if(_smppServers_dict[provider.name] == NULL)
    {
        _smppServers_dict[provider.name] = provider;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceSMPPServer:(UMSS7ConfigSMPPServer *)provider
{
    _smppServers_dict[provider.name] = provider;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteSMPPServer:(NSString *)name
{
    if(_smppServers_dict[name]==NULL)
    {
        return @"not found";
    }
    [_smppServers_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}


/*
 **************************************************
 ** SMPPConnections
 **************************************************
 */


- (NSArray *)getSMPPConnections
{
    return [[_smppConnections_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigSMPPConnection *)getSMPPConnections:(NSString *)name
{
    return _smppConnections_dict[name];
}

- (NSString *)addSMPPConnection:(UMSS7ConfigSMPPConnection *)provider
{
    if(_smppConnections_dict[provider.name] == NULL)
    {
        _smppConnections_dict[provider.name] = provider;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceSMPPConnection:(UMSS7ConfigSMPPConnection *)provider
{
    _smppConnections_dict[provider.name] = provider;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteSMPPConnection:(NSString *)name
{
    if(_smppConnections_dict[name]==NULL)
    {
        return @"not found";
    }
    [_smppConnections_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}

/*
 **************************************************
 ** SMPP Plugins
 **************************************************
 */

- (NSArray *)getSMPPPlugins
{
    return [[_smppPlugins_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigSMPPPlugin *)getSMPPPlugin:(NSString *)name
{
    return _smppPlugins_dict[name];
}

- (NSString *)addSMPPPlugin:(UMSS7ConfigSMPPPlugin *)provider
{
    if(_smppPlugins_dict[provider.name] == NULL)
    {
        _smppPlugins_dict[provider.name] = provider;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceSMPPPlugin:(UMSS7ConfigSMPPPlugin *)provider
{
    _smppPlugins_dict[provider.name] = provider;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteSMPPPlugin:(NSString *)name
{
    if(_smppPlugins_dict[name]==NULL)
    {
        return @"not found";
    }
    [_smppPlugins_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}

/*
 **************************************************
 ** AuthServer
 **************************************************
 */

- (NSArray *)getAuthServers
{
    return [[_authServers_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigAuthServer *)getAuthServer:(NSString *)name
{
    return _authServers_dict[name];
}

- (NSString *)addAuthServer:(UMSS7ConfigAuthServer *)provider
{
    if(_authServers_dict[provider.name] == NULL)
    {
        _authServers_dict[provider.name] = provider;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceAuthServer:(UMSS7ConfigAuthServer *)provider
{
    _authServers_dict[provider.name] = provider;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteAuthServer:(NSString *)name
{
    if(_authServers_dict[name]==NULL)
    {
        return @"not found";
    }
    [_authServers_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}

/*
 **************************************************
 ** StorageServer
 **************************************************
 */

- (NSArray *)getStorageServers
{
    return [[_storageServers_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigStorageServer *)getStorageServer:(NSString *)name
{
    return _storageServers_dict[name];
}

- (NSString *)addStorageServer:(UMSS7ConfigStorageServer *)provider
{
    if(_storageServers_dict[provider.name] == NULL)
    {
        _storageServers_dict[provider.name] = provider;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceStorageServer:(UMSS7ConfigStorageServer *)provider
{
    _storageServers_dict[provider.name] = provider;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteStorageServer:(NSString *)name
{
    if(_storageServers_dict[name]==NULL)
    {
        return @"not found";
    }
    [_storageServers_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}

/*
 **************************************************
 ** CdrServer
 **************************************************
 */

- (NSArray *)getCdrServers
{
    return [[_cdrServers_dict allKeys]sortedStringsArray];
}

- (UMSS7ConfigCdrServer *)getCdrServer:(NSString *)name
{
    return _cdrServers_dict[name];
}

- (NSString *)addCdrServer:(UMSS7ConfigCdrServer *)provider
{
    if(_cdrServers_dict[provider.name] == NULL)
    {
        _cdrServers_dict[provider.name] = provider;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceCdrServer:(UMSS7ConfigCdrServer *)provider
{
    _cdrServers_dict[provider.name] = provider;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteCdrServer:(NSString *)name
{
    if(_cdrServers_dict[name]==NULL)
    {
        return @"not found";
    }
    [_cdrServers_dict removeObjectForKey:name];
    _dirty=YES;
    return @"ok";
}


/***************************************************/
#pragma mark -


- (UMSS7ConfigStorage *)copyWithZone:(NSZone *)zone
{
    UMSS7ConfigStorage *n = [[UMSS7ConfigStorage alloc]init];

    n.commandLine = [_commandLine copy];
    n.productName = _productName;
    n.commandLineArguments = [_commandLineArguments copy];
    n.generalConfig = [_generalConfig copy];

    n.webserver_dict = [_webserver_dict copy];
    n.telnet_dict = [_telnet_dict copy];
    n.syslog_destination_dict = [_syslog_destination_dict copy];
    n.sctp_dict = [_sctp_dict copy];
    n.m2pa_dict = [_m2pa_dict copy];
    n.mtp3_dict = [_mtp3_dict copy];
    n.mtp3_route_dict = [_mtp3_route_dict copy];
    n.mtp3_filter_dict = [_mtp3_filter_dict copy];
    n.mtp3_link_dict = [_mtp3_link_dict copy];
    n.mtp3_linkset_dict = [_mtp3_linkset_dict copy];
    n.m3ua_as_dict = [_m3ua_as_dict copy];
    n.m3ua_asp_dict = [_m3ua_asp_dict copy];
    n.sccp_dict = [_sccp_dict copy];
    n.sccp_filter_dict = [_sccp_filter_dict copy];
    n.sccp_destination_dict = [_sccp_destination_dict copy];
    n.sccp_translation_table_dict = [_sccp_translation_table_dict copy];
    n.sccp_translation_table_entry_dict = [_sccp_translation_table_entry_dict copy];
    n.sccp_translation_table_map_dict = [_sccp_translation_table_map_dict copy];
    n.tcap_dict = [_tcap_dict copy];
    n.tcap_filter_dict = [_tcap_filter_dict copy];
    n.gsmmap_dict = [_gsmmap_dict copy];
    n.gsmmap_filter_dict = [_gsmmap_filter_dict copy];
    n.sms_dict = [_sms_dict copy];
    n.sms_filter_dict = [_sms_filter_dict copy];
    n.hlr_dict = [_hlr_dict copy];
    n.msc_dict = [_msc_dict copy];
    n.ggsn_dict = [_ggsn_dict copy];
    n.sgsn_dict = [_sgsn_dict copy];
    n.vlr_dict = [_vlr_dict copy];
    n.gsmscf_dict = [_gsmscf_dict copy];
    n.gmlc_dict = [_gmlc_dict copy];
    n.eir_dict = [_eir_dict copy];
    n.smsc_dict = [_smsc_dict copy];
    n.admin_user_dict = [_admin_user_dict copy];
    n.api_user_dict = [_api_user_dict copy];
    n.database_pool_dict = [_database_pool_dict copy];
    n.sccp_number_translation_dict = [_sccp_number_translation_dict copy];
    n.service_user_dict = [_service_user_dict copy];
    n.service_billing_entity_dict = [_service_billing_entity_dict copy];
    n.service_user_profile_dict = [_service_user_profile_dict copy];
    n.smsproxy_dict = [_smsproxy_dict copy];
    n.diameter_connection_dict = [_diameter_connection_dict copy];
    n.estp_dict = [_estp_dict copy];
    n.mapi_dict = [_mapi_dict copy];
    n.imsi_pool_dict = [_imsi_pool_dict copy];
    n.cdr_writer_dict = [_cdr_writer_dict copy];
    n.diameter_connection_dict = [_diameter_connection_dict copy];
    n.diameter_router_dict = [_diameter_router_dict copy];
    n.diameter_route_dict = [_diameter_route_dict copy];
    n.mtp3_pctrans_dict = [_mtp3_pctrans_dict copy];
    n.rwconfigFile = _rwconfigFile;
    n.camel_dict = [_camel_dict copy];
    n.mnpDatabases_dict = [_mnpDatabases_dict copy];
    n.mirrorPorts_dict = [_mirrorPorts_dict copy];
    n.smsDeliveryProviders_dict = [_smsDeliveryProviders_dict copy];
    n.smppServers_dict = [_smppServers_dict copy];
    n.smppConnections_dict = [_smppConnections_dict copy];
    n.smppPlugins_dict = [_smppPlugins_dict copy];
    n.authServers_dict = [_authServers_dict copy];
    n.storageServers_dict = [_storageServers_dict copy];
    n.cdrServers_dict = [_cdrServers_dict copy];

    return n;
}

@end

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
#import "UMSS7ConfigMTP3Linkset.h"
#import "UMSS7ConfigMTP3Link.h"
#import "UMSS7ConfigM3UAAS.h"
#import "UMSS7ConfigM3UAASP.h"
#import "UMSS7ConfigSCCP.h"
#import "UMSS7ConfigSCCPFilter.h"
#import "UMSS7ConfigSCCPFilterEntry.h"
#import "UMSS7ConfigSCCPTranslationTable.h"
#import "UMSS7ConfigSCCPTranslationTableEntry.h"
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
#import "UMSS7ConfigServiceUserProfile.h"
#import "UMSS7ConfigServiceBillingEntity.h"
#import "UMSS7ConfigIMSIPool.h"
#import "UMSS7ConfigCdrWriter.h"

#define CONFIG_ERROR(s)     [NSException exceptionWithName:[NSString stringWithFormat:@"CONFIG_ERROR FILE %s line:%ld",__FILE__,(long)__LINE__] reason:s userInfo:@{@"backtrace": UMBacktrace(NULL,0) }]

@implementation UMSS7ConfigStorage

- (void)generalInitialisation
{
    _webserver_dict= [[UMSynchronizedDictionary alloc]init];
    _telnet_dict= [[UMSynchronizedDictionary alloc]init];
    _syslog_destination_dict= [[UMSynchronizedDictionary alloc]init];
    _sctp_dict= [[UMSynchronizedDictionary alloc]init];
    _m2pa_dict= [[UMSynchronizedDictionary alloc]init];
    _mtp3_dict= [[UMSynchronizedDictionary alloc]init];
    _mtp3_route_dict= [[UMSynchronizedDictionary alloc]init];
    _mtp3_filter_dict= [[UMSynchronizedDictionary alloc]init];
    _mtp3_link_dict= [[UMSynchronizedDictionary alloc]init];
    _mtp3_linkset_dict= [[UMSynchronizedDictionary alloc]init];
    _m3ua_as_dict= [[UMSynchronizedDictionary alloc]init];
    _m3ua_asp_dict= [[UMSynchronizedDictionary alloc]init];
    _sccp_dict= [[UMSynchronizedDictionary alloc]init];
    _sccp_filter_dict= [[UMSynchronizedDictionary alloc]init];
    _sccp_destination_dict= [[UMSynchronizedDictionary alloc]init];
    _sccp_translation_table_dict= [[UMSynchronizedDictionary alloc]init];
    _tcap_dict= [[UMSynchronizedDictionary alloc]init];
    _tcap_filter_dict= [[UMSynchronizedDictionary alloc]init];
    _gsmmap_dict= [[UMSynchronizedDictionary alloc]init];
    _gsmmap_filter_dict= [[UMSynchronizedDictionary alloc]init];
    _sms_dict= [[UMSynchronizedDictionary alloc]init];
    _sms_filter_dict= [[UMSynchronizedDictionary alloc]init];
    _hlr_dict= [[UMSynchronizedDictionary alloc]init];
    _msc_dict= [[UMSynchronizedDictionary alloc]init];
    _vlr_dict= [[UMSynchronizedDictionary alloc]init];
    _gsmscf_dict= [[UMSynchronizedDictionary alloc]init];
    _gmlc_dict= [[UMSynchronizedDictionary alloc]init];
    _eir_dict= [[UMSynchronizedDictionary alloc]init];
    _smsc_dict= [[UMSynchronizedDictionary alloc]init];
    _admin_user_dict= [[UMSynchronizedDictionary alloc]init];
    _database_pool_dict= [[UMSynchronizedDictionary alloc]init];
    _sccp_number_translation_dict= [[UMSynchronizedDictionary alloc]init];
    _service_user_dict= [[UMSynchronizedDictionary alloc]init];
    _service_billing_entity_dict= [[UMSynchronizedDictionary alloc]init];
    _service_user_profile_dict= [[UMSynchronizedDictionary alloc]init];
    _smsproxy_dict= [[UMSynchronizedDictionary alloc]init];
    _estp_dict= [[UMSynchronizedDictionary alloc]init];
    _mapi_dict= [[UMSynchronizedDictionary alloc]init];
    _imsi_pool_dict= [[UMSynchronizedDictionary alloc]init];
    _cdr_writer_dict= [[UMSynchronizedDictionary alloc]init];

    _dirtyTimer = [[UMTimer alloc]initWithTarget:self
                                        selector:@selector(dirtyCheck)
                                          object:NULL
                                         seconds:10.0
                                            name:@"dirty-config-timer"
                                         repeats:YES];
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
    }
    return self;
}


- (void)startDirtyTimer
{
    [_dirtyTimer start];
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
    [cfg allowMultiGroup:[UMSS7ConfigMTP3Linkset type]];
    [cfg allowMultiGroup:[UMSS7ConfigMTP3Link type]];
    [cfg allowMultiGroup:[UMSS7ConfigMTP3Route type]];
    [cfg allowMultiGroup:[UMSS7ConfigM3UAAS type]];
    [cfg allowMultiGroup:[UMSS7ConfigM3UAASP type]];
    [cfg allowMultiGroup:[UMSS7ConfigSCCP type]];
    [cfg allowMultiGroup:[UMSS7ConfigSCCPDestination type]];
    [cfg allowMultiGroup:[UMSS7ConfigSCCPDestinationEntry type]];
    [cfg allowMultiGroup:[UMSS7ConfigSCCPTranslationTable type]];
    [cfg allowMultiGroup:[UMSS7ConfigSCCPTranslationTableEntry type]];
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
    [cfg allowMultiGroup:[UMSS7ConfigVLR type]];
    [cfg allowMultiGroup:[UMSS7ConfigGSMSCF type]];
    [cfg allowMultiGroup:[UMSS7ConfigGMLC type]];
    [cfg allowMultiGroup:[UMSS7ConfigEIR type]];
    [cfg allowMultiGroup:[UMSS7ConfigSMSC type]];
    [cfg allowMultiGroup:[UMSS7ConfigSMSProxy type]];
    [cfg allowMultiGroup:[UMSS7ConfigAdminUser type]];
    [cfg allowMultiGroup:[UMSS7ConfigDatabasePool type]];
    [cfg allowMultiGroup:[UMSS7ConfigCdrWriter type]];
    [cfg allowMultiGroup:[UMSS7ConfigSCCPNumberTranslation type]];
    [cfg allowMultiGroup:[UMSS7ConfigSCCPNumberTranslationEntry type]];
    [cfg allowMultiGroup:[UMSS7ConfigServiceUser type]];
    [cfg allowMultiGroup:[UMSS7ConfigServiceUserProfile type]];
    [cfg allowMultiGroup:[UMSS7ConfigServiceBillingEntity type]];
    [cfg allowMultiGroup:[UMSS7ConfigSMSProxy type]];
    [cfg allowMultiGroup:[UMSS7ConfigESTP type]];
    [cfg allowMultiGroup:[UMSS7ConfigIMSIPool type]];

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
    NSArray *mtp3_linkset_configs = [cfg getMultiGroups:[UMSS7ConfigMTP3Linkset type]];
    for(NSDictionary *mtp3_linkset_config in mtp3_linkset_configs)
    {
        UMSS7ConfigMTP3Linkset *mtp3_linkset = [[UMSS7ConfigMTP3Linkset alloc]initWithConfig:mtp3_linkset_config];
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
            [translation_table addSubEntry:sccp_translation_table_entry];
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

    NSArray *sccp_filter_entry_configs = [cfg getMultiGroups:[UMSS7ConfigSCCPFilterEntry type]];
    for(NSDictionary *sccp_filter_entry_config in sccp_filter_entry_configs)
    {
        UMSS7ConfigSCCPFilterEntry *sccp_filter_entry = [[UMSS7ConfigSCCPFilterEntry alloc]initWithConfig:sccp_filter_entry_config];
        if(sccp_filter_entry.filter.length  > 0)
        {
            UMSS7ConfigSCCPFilter *filter = _sccp_filter_dict[sccp_filter_entry.filter];
            if(filter)
            {
                [filter addSubEntry:sccp_filter_entry];
            }
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

    NSArray *service_user_profile_configs = [cfg getMultiGroups:[UMSS7ConfigServiceUserProfile type]];
    for(NSDictionary *service_user_profile_config in service_user_profile_configs)
    {
        UMSS7ConfigServiceUserProfile *up = [[UMSS7ConfigServiceUserProfile alloc]initWithConfig:service_user_profile_config];
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
    [self appendSection:s dict:_webserver_dict sectionName:@"webserver"];
    [self appendSection:s dict:_telnet_dict sectionName:@"telnet"];
    [self appendSection:s dict:_syslog_destination_dict sectionName:@"syslog-destination"];
    [self appendSection:s dict:_sctp_dict sectionName:@"sctp"];
    [self appendSection:s dict:_m2pa_dict sectionName:@"m2pa"];
    [self appendSection:s dict:_mtp3_dict sectionName:@"mtp3"];
    [self appendSection:s dict:_mtp3_linkset_dict sectionName:@"mtp3-linkset"];
    [self appendSection:s dict:_mtp3_link_dict sectionName:@"mtp3-link"];
    [self appendSection:s dict:_m3ua_as_dict sectionName:@"m3ua-as"];
    [self appendSection:s dict:_m3ua_asp_dict sectionName:@"m3ua-asp"];
    [self appendSection:s dict:_mtp3_filter_dict sectionName:@"mtp3-filter"];
    [self appendSection:s dict:_mtp3_route_dict sectionName:@"mtp3-route"];
    [self appendSection:s dict:_sccp_dict sectionName:@"sccp"];
    [self appendSectionWithEntries:s dict:_sccp_destination_dict sectionName:@"sccp-destination"];
    [self appendSection:s dict:_sccp_filter_dict sectionName:@"sccp-filter"];
    [self appendSectionWithEntries:s dict:_sccp_number_translation_dict sectionName:@"sccp-number-translation"];
    [self appendSectionWithEntries:s dict:_sccp_translation_table_dict sectionName:@"sccp-translation-table"];
    [self appendSection:s dict:_tcap_dict sectionName:@"tcap"];
    [self appendSectionWithEntries:s dict:_tcap_filter_dict sectionName:@"tcap-filter"];
    [self appendSection:s dict:_gsmmap_dict sectionName:@"gsmmap"];
    [self appendSectionWithEntries:s dict:_gsmmap_filter_dict sectionName:@"gsmmap-filter"];
    [self appendSection:s dict:_sms_dict sectionName:@"sms"];
    [self appendSectionWithEntries:s dict:_sms_filter_dict sectionName:@"sms-filter"];
    [self appendSection:s dict:_imsi_pool_dict sectionName:@"imsi-pool"];
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
    return [_sctp_dict allKeys];
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
    return [_m2pa_dict allKeys];
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
    return [_mtp3_dict allKeys];
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
    return [_mtp3_route_dict allKeys];
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
    return [_mtp3_filter_dict allKeys];
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
    return [_mtp3_link_dict allKeys];
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
 ** MTP3-Linkset
 **************************************************
 */
#pragma mark -
#pragma mark MTP3Linkset

- (NSArray *)getMTP3LinksetNames
{
    return [_mtp3_linkset_dict allKeys];
}

- (UMSS7ConfigMTP3Linkset *)getMTP3Linkset:(NSString *)name
{
    return _mtp3_linkset_dict[name];
}

- (NSString *)addMTP3Linkset:(UMSS7ConfigMTP3Linkset*)mtp3_linkset
{
    if(_mtp3_linkset_dict[mtp3_linkset.name] == NULL)
    {
        _mtp3_linkset_dict[mtp3_linkset.name] = mtp3_linkset;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceMTP3Linkset:(UMSS7ConfigMTP3Linkset *)mtp3_linkset
{
    _mtp3_linkset_dict[mtp3_linkset.name] = mtp3_linkset;
    _dirty=YES;
    return @"ok";
}

- (NSString *)deleteMTP3Linkset:(NSString *)name
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
    return [_m3ua_as_dict allKeys];
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
    return [_m3ua_asp_dict allKeys];
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
    return [_sccp_dict allKeys];
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
    return  [_sccp_filter_dict allKeys];
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
    return [_sccp_destination_dict allKeys];
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
    return [_sccp_translation_table_dict allKeys];
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
 ** SCCP-NumberTranslation
 **************************************************
 */
#pragma mark -
#pragma mark SCCP Number Translation

- (NSArray *)getSCCPNumberTranslationNames
{
    return [_sccp_number_translation_dict allKeys];
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
    return [_tcap_dict allKeys];
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
    return [_tcap_filter_dict allKeys];
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
    return [_gsmmap_dict allKeys];
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
    return [_gsmmap_filter_dict allKeys];
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
    return [_sms_dict allKeys];
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
    return [_sms_filter_dict allKeys];
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
#pragma mark GSMMAP

- (NSArray *)getMSCNames
{
    return [_msc_dict allKeys];
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
 ** HLR
 **************************************************
 */
#pragma mark -
#pragma mark HLR

- (NSArray *)getHLRNames
{
    return [_hlr_dict allKeys];
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
    return [_vlr_dict allKeys];
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
    return [_smsc_dict allKeys];
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
    return [_gsmscf_dict allKeys];
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
    return [_gmlc_dict allKeys];
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
    return [_eir_dict allKeys];
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
    return [_smsproxy_dict allKeys];
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
    return [_estp_dict allKeys];
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
    return [_mapi_dict allKeys];
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
    return [_imsi_pool_dict allKeys];
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
** CDRWriter
**************************************************
*/

#pragma mark -
#pragma mark IMSIPool

- (NSArray *)getCdrWriterNames
{
    return [_cdr_writer_dict allKeys];
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
    return [_webserver_dict allKeys];
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
    return [_telnet_dict allKeys];
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
    return [_syslog_destination_dict allKeys];
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
    return [_admin_user_dict allKeys];
}

- (UMSS7ConfigAdminUser *)getAdminUser:(NSString *)name
{
    return _admin_user_dict[name];
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
    return [_service_user_dict allKeys];
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
    return [_service_user_profile_dict allKeys];
}

- (UMSS7ConfigServiceUserProfile *)getServiceUserProfile:(NSString *)name
{
    return _service_user_profile_dict[name];
}

- (NSString *)addServiceUserProfile:(UMSS7ConfigServiceUserProfile *)profile
{
    if(_service_user_profile_dict[profile.name] == NULL)
    {
        _service_user_profile_dict[profile.name] = profile;
        _dirty=YES;
        return @"ok";
    }
    return @"already exists";
}

- (NSString *)replaceServiceUserProfile:(UMSS7ConfigServiceUserProfile *)profile
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
    return [_service_billing_entity_dict allKeys];
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
    n.tcap_dict = [_tcap_dict copy];
    n.tcap_filter_dict = [_tcap_filter_dict copy];
    n.gsmmap_dict = [_gsmmap_dict copy];
    n.gsmmap_filter_dict = [_gsmmap_filter_dict copy];
    n.sms_dict = [_sms_dict copy];
    n.sms_filter_dict = [_sms_filter_dict copy];
    n.hlr_dict = [_hlr_dict copy];
    n.msc_dict = [_msc_dict copy];
    n.vlr_dict = [_vlr_dict copy];
    n.gsmscf_dict = [_gsmscf_dict copy];
    n.gmlc_dict = [_gmlc_dict copy];
    n.eir_dict = [_eir_dict copy];
    n.smsc_dict = [_smsc_dict copy];
    n.admin_user_dict = [_admin_user_dict copy];
    n.database_pool_dict = [_database_pool_dict copy];
    n.sccp_number_translation_dict = [_sccp_number_translation_dict copy];
    n.service_user_dict = [_service_user_dict copy];
    n.service_billing_entity_dict = [_service_billing_entity_dict copy];
    n.service_user_profile_dict = [_service_user_profile_dict copy];
    n.smsproxy_dict = [_smsproxy_dict copy];
    n.estp_dict = [_estp_dict copy];
    n.mapi_dict = [_mapi_dict copy];
    n.imsi_pool_dict = [_imsi_pool_dict copy];
    n.cdr_writer_dict = [_cdr_writer_dict copy];

    n.rwconfigFile = _rwconfigFile;
    return n;

}


@end

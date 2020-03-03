//
//  SS7AppDelegate.m
//  ulibss7config
//
//  Created by Andreas Fink on 13.11.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//


#import "SS7AppDelegate.h"

#import <ulibtransport/ulibtransport.h>
#import <ulibcamel/ulibcamel.h>
#import <ulibdiameter/ulibdiameter.h>
#import <ulibmtp3/ulibmtp3.h>
#import <schrittmacherclient/schrittmacherclient.h>
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigGeneral.h"
#import "UMSS7ConfigWebserver.h"
#import "UMSS7ConfigAdminUser.h"
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
#import "UMSS7ConfigDiameterConnection.h"
#import "UMSS7ConfigDiameterRoute.h"
#import "UMSS7ConfigDiameterRouter.h"
#import "UMTTask.h"
#import "UMTTaskPing.h"
#import "UMTTaskGetVersion.h"
#import "SS7GenericInstance.h"
#import "SS7GenericSession.h"
#import "SS7AppTransportHandler.h"
#import "SS7TemporaryImsiPool.h"
#import "UMSS7ConfigApiUser.h"
#import "UMSS7ConfigDiameterRouter.h"
#import "UMSS7ApiSession.h"
#import "DiameterGenericInstance.h"
#import "UMSS7ConfigSS7FilterStagingArea.h"
#import "UMSS7ConfigSS7FilterTraceFile.h"
#import "filter/UMSS7FilterRuleSet.h"
#import "filter/UMSS7FilterActionList.h"
#import "objc/runtime.h"
#import "SS7CDRWriter.h"
#import "UMSS7ConfigMTP3PointCodeTranslationTable.h"

#ifdef __APPLE__
#import "/Library/Application Support/FinkTelecomServices/frameworks/uliblicense/uliblicense.h"
#else
#import <uliblicense/uliblicense.h>
#endif

extern UMLicenseDirectory * UMLicense_loadLicensesFromPath(NSString *directory, BOOL debug);

//@class SS7AppDelegate;

static SS7AppDelegate *ss7_app_delegate;
static int _signal_sigint = 0;
static int _signal_sighup = 0;
static int _signal_sigusr1 = 0;
static int _signal_sigusr2 = 0;
static void signalHandler(int signum);

#define CONFIG_ERROR(s)     [NSException exceptionWithName:[NSString stringWithFormat:@"CONFIG_ERROR FILE %s line:%ld",__FILE__,(long)__LINE__] reason:s userInfo:@{@"backtrace": UMBacktrace(NULL,0) }]

@implementation SS7AppDelegate
- (NSString *)layerName
{
		return @"SS7AppDelegate";
}

- (UMLogLevel)logLevel
{
    return _logLevel;
}


- (void)setLogLevel:(UMLogLevel)ll
{
    _logLevel = ll;
}


- (SS7AppDelegate *)init
{
    return [self initWithOptions:@{}];
}


- (SS7AppDelegate *)initWithOptions:(NSDictionary *)options
{
    self = [super init];
    if(self)
    {
        ss7_app_delegate = self;

        _applicationStart = [NSDate new];
        _enabledOptions                 = options;
        _logHandler                     = [[UMLogHandler alloc]initWithConsole];
        self.logFeed                    = [[UMLogFeed alloc]initWithHandler:_logHandler section:@"main"];
        _logLevel                       = UMLOG_DEBUG;
        _sctp_dict                      = [[UMSynchronizedDictionary alloc]init];
        _m2pa_dict                      = [[UMSynchronizedDictionary alloc]init];
        _mtp3_dict                      = [[UMSynchronizedDictionary alloc]init];
        _mtp3_link_dict                 = [[UMSynchronizedDictionary alloc]init];
        _mtp3_linkset_dict              = [[UMSynchronizedDictionary alloc]init];
        _m3ua_as_dict                   = [[UMSynchronizedDictionary alloc]init];
        _m3ua_asp_dict                  = [[UMSynchronizedDictionary alloc]init];
        _mtp3_pointcode_translation_tables_dict = [[UMSynchronizedDictionary alloc]init];
        _sccp_dict                      = [[UMSynchronizedDictionary alloc]init];
        _webserver_dict                 = [[UMSynchronizedDictionary alloc]init];
        _telnet_dict                    = [[UMSynchronizedDictionary alloc]init];
        _syslog_destination_dict        = [[UMSynchronizedDictionary alloc]init];
        _tcap_dict                      = [[UMSynchronizedDictionary alloc]init];
        _gsmmap_dict                    = [[UMSynchronizedDictionary alloc]init];
        _camel_dict                     = [[UMSynchronizedDictionary alloc]init];
        _sccp_number_translations_dict  = [[UMSynchronizedDictionary alloc]init];
        _diameter_connections_dict      = [[UMSynchronizedDictionary alloc]init];
        _diameter_router_dict           = [[UMSynchronizedDictionary alloc]init];
        _ss7FilterStagingAreas_dict     = [[UMSynchronizedDictionary alloc]init];
        _statistics_dict                = [[UMSynchronizedDictionary alloc]init];
        _apiSessions                    = [[UMSynchronizedDictionary alloc]init];
        _registry                       = [[UMSocketSCTPRegistry alloc]init];
        _registry.logLevel =            UMLOG_MINOR;
        _stagingAreaPath                =  [self defaultStagingAreaPath];
        _filterEnginesPath              =  [self defaultFilterEnginesPath];
        _appsPath                       =  [self defaultAppsPath];
        _statisticsPath                 =  [self defaultStatisticsPath];

        _mainDiameterInstance           = [[DiameterGenericInstance alloc]init];
        _namedLists = [[UMSynchronizedDictionary alloc]init];
        _namedListLock = [[UMMutex alloc]initWithName:@"namedlist-mutex"];
        _namedListsDirectory            = [self defaultNamedListPath];

        _ss7TraceFiles                  = [[UMSynchronizedDictionary alloc]init];
        _ss7TraceFilesDirectory         = [self defaultTracefilesPath];

        _active_ruleset_dict            = [[UMSynchronizedDictionary alloc]init];
        _active_action_list_dict        = [[UMSynchronizedDictionary alloc]init];
        _ss7FilterEngines               = [[UMSynchronizedDictionary alloc]init];

        _incomingLinksetFilters = [[UMSynchronizedDictionary alloc]init];
        _outgoingLinksetFilters = [[UMSynchronizedDictionary alloc]init];
        _incomingLocalSubsystemFilters = [[UMSynchronizedDictionary alloc]init];
        _outgoingLocalSubsystemFilters = [[UMSynchronizedDictionary alloc]init];

        _cdrWriters_dict               = [[UMSynchronizedDictionary alloc]init];

        if(_enabledOptions[@"name"])
        {
            self.logFeed.name =_enabledOptions[@"name"];
        }
        if([_enabledOptions[@"msc"] boolValue])
        {
            _msc_dict = [[UMSynchronizedDictionary alloc]init];
        }
        if([_enabledOptions[@"smsc"] boolValue])
        {
            _smsc_dict = [[UMSynchronizedDictionary alloc]init];
        }
        if([_enabledOptions[@"smsproxy"] boolValue])
        {
            _smsproxy_dict = [[UMSynchronizedDictionary alloc]init];
        }

        if([_enabledOptions[@"hlr"] boolValue])
        {
            _hlr_dict = [[UMSynchronizedDictionary alloc]init];
        }
        if([_enabledOptions[@"vlr"] boolValue])
        {
            _vlr_dict = [[UMSynchronizedDictionary alloc]init];
        }
        if([_enabledOptions[@"eir"] boolValue])
        {
            _eir_dict = [[UMSynchronizedDictionary alloc]init];
        }
        if([_enabledOptions[@"gsmscf"] boolValue])
        {
            _gsmscf_dict = [[UMSynchronizedDictionary alloc]init];
        }
        if([_enabledOptions[@"gmlc"] boolValue])
        {
            _gmlc_dict = [[UMSynchronizedDictionary alloc]init];
        }
        if([_enabledOptions[@"estp"] boolValue])
        {
            _estp_dict = [[UMSynchronizedDictionary alloc]init];
        }
        if([_enabledOptions[@"imsi-pool"] boolValue])
        {
            _imsi_pools_dict = [[UMSynchronizedDictionary alloc]init];
        }

        if(_enabledOptions[@"umtransport"])
        {
            _umtransportService = [[UMTransportService alloc]initWithTaskQueueMulti:_generalTaskQueue];
        }
        _tidPool = [[UMTCAP_TransactionIdPool alloc]initWithPrefabricatedIds:100000];
        _umtransportLock = [[UMMutex alloc]initWithName:@"SS7AppDelegate_umtransportLock"];
        _umtransportService = [[UMTransportService alloc]initWithTaskQueueMulti:_generalTaskQueue];
        _pendingUMT = [[UMSynchronizedDictionary alloc]init];

        _apiHousekeepingTimer = [[UMTimer alloc]initWithTarget:self
                                                      selector:@selector(apiHousekeeping)
                                                        object:NULL
                                                       seconds:6
                                                          name:@"api-housekeeping"
                                                       repeats:YES
                                               runInForeground:NO];

        _dirtyTimer = [[UMTimer alloc]initWithTarget:self
                                            selector:@selector(dirtyCheck)
                                              object:NULL
                                             seconds:10.0
                                                name:@"app-dirty-timer"
                                             repeats:YES
                                     runInForeground:NO];

        _globalLicenseDirectory = UMLicense_loadLicensesFromPath(NULL,NO);
        _coreFeature = [_globalLicenseDirectory getProduct:[self productName] feature:@"core"];
        _sctpFeature = [_globalLicenseDirectory getProduct:[self productName] feature:@"sctp"];
        _m2paFeature = [_globalLicenseDirectory getProduct:[self productName] feature:@"m2pa"];
        _mtp3Feature = [_globalLicenseDirectory getProduct:[self productName] feature:@"mtp3"];
        _m3uaFeature = [_globalLicenseDirectory getProduct:[self productName] feature:@"m3ua"];
        _sccpFeature = [_globalLicenseDirectory getProduct:[self productName] feature:@"sccp"];
        _tcapFeature = [_globalLicenseDirectory getProduct:[self productName] feature:@"tcap"];
        _gsmmapFeature = [_globalLicenseDirectory getProduct:[self productName] feature:@"gsmmap"];
        _smscFeature = [_globalLicenseDirectory getProduct:[self productName] feature:@"smsc"];
        _smsproxyFeature = [_globalLicenseDirectory getProduct:[self productName] feature:@"smsproxy"];
        _rerouterFeature = [_globalLicenseDirectory getProduct:[self productName] feature:@"rerouter"];
        _diameterFeature = [_globalLicenseDirectory getProduct:[self productName] feature:@"diameter"];

        _dbpool_dict = [[UMSynchronizedDictionary alloc]init];

        _filteringActive = YES;
        _sessionTimeout = 30.0*60.0;
    }
    return self;
}

- (NSDictionary *)appDefinition
{
    return @{
        @"version" : @"0.0.0",
        @"executable" : @"ss7-app",
        @"copyright" : @"© 2019 Andreas Fink",
    };
}

- (NSArray *)commandLineSyntax
{
    return @[
        @{
            @"name"  : @"version",
            @"short" : @"-V",
            @"long"  : @"--version",
            @"help"  : @"shows the software version"
        },
        @{
            @"name"  : @"verbose",
            @"short" : @"-v",
            @"long"  : @"--verbose",
            @"help"  : @"enables verbose mode"
        },
        @{
            @"name"  : @"help",
            @"short" : @"-h",
            @"long" : @"--help",
            @"help"  : @"shows the help screen",
        },
        @{
            @"name"  : @"config",
            @"short" : @"-c",
            @"long"  : @"--read-config",
            @"multi" : @(YES),
            @"argument" : @"filename",
            @"help"  : @"reads the indicated config (defaults to /etc/estp/estp.conf)",
        },
        @{
            @"name"  : @"readwriteconfig",
            @"short" : @"-C",
            @"long"  : @"--read-write-config",
            @"multi" : @(YES),
            @"argument" : @"filename",
            @"help"  : @"reads the indicated config and also writes changes to it",
        },
        @{
            @"name"  : @"rw",
            @"short" : @"-W",
            @"long"  : @"--rw",
            @"help"  : @"changes --read-config to --read-write-config",
        },
        @{
            @"name"  : @"autowrite",
            @"short" : @"-A",
            @"long"  : @"--autowrite",
            @"help"  : @"automatically write changes to config file. not waiting for api write",
        },
        @{
            @"name"  : @"print-config",
            @"short" : @"",
            @"long"  : @"--print-config",
            @"help"  : @"prints the combined config to stdout",
        },
        @{
            @"name"  : @"write-compact-config",
            @"short" : @"",
            @"long"  : @"--write-compact-config",
            @"argument" : @"filename",
            @"help"  : @"writes the combined config to a file",
        },
        @{
            @"name"  : @"write-split-config",
            @"short" : @"",
            @"long"  : @"--write-split-config",
            @"argument" : @"filename",
            @"help"  : @"writes the config to a file and the subsections to files in subdirectories at the same location",
        },
        @{
            @"name"  : @"pid-file",
            @"short" : @"",
            @"long"  : @"--pid-file",
            @"argument" : @"filename",
            @"help"  : @"writes the process-id to the indicated file",
        },
        @{
            @"name"  : @"quiet",
            @"short" : @"-q",
            @"long"  : @"--quiet",
            @"help"  : @"silences output",
        },
        @{
            @"name"  : @"debug",
            @"short" : @"-d",
            @"long"  : @"--debug",
            @"argument" : @"debug-option",
            @"multi" : @(YES),
            @"help"  : @"enables the named debug option(s)",
        },
        @{
            @"name"  : @"standby",
            @"short" : @"-s",
            @"long"  : @"--standby",
            @"help"  : @"start up in inactive standby mode",
        },
        @{
            @"name"  : @"hot",
            @"short" : @"-H",
            @"long"  : @"--hot",
            @"help"  : @"start up in active hot mode",
        },
        @{
            @"name"  : @"umobject-stat",
            @"short" : @"",
            @"long"  : @"--umobject-stat",
            @"help"  : @"Enable object statistics",
        },
        @{
            @"name"  : @"ummutex-stat",
            @"short" : @"",
            @"long"  : @"--ummutex-stat",
            @"help"  : @"Enable mutex statistics",
        },
        @{
            @"name"  : @"schrittmacher-id",
            @"short" : @"-i",
            @"long"  : @"--schrittmacher-id",
            @"argument" : @"id",
            @"help"  : @"set the schrittmacher id",
        },
        @{
            @"name"  : @"schrittmacher-port",
            @"short" : @"-p",
            @"long"  : @"--schrittmacher-port",
            @"argument" : @"port",
            @"help"  : @"set the schrittmacher udp port",
        },
        @{
            @"name"  : @"admin-http-port",
            @"short" : @"",
            @"long"  : @"--admin-http-port",
            @"argument" : @"port",
            @"help"  : @"enable a http admin interface on this port"
        },
        @{
            @"name"  : @"admin-https-port",
            @"short" : @"",
            @"long"  : @"--admin-https-port",
            @"argument" : @"port",
            @"help"  : @"enable a https admin interface on this port"
        },
        @{
            @"name"  : @"admin-https-key",
            @"short" : @"",
            @"long"  : @"--admin-http-port",
            @"argument" : @"filename",
            @"help"  : @"specify the SSL key file for the https admin interface"
        },
        @{
            @"name"  : @"admin-https-cert",
            @"short" : @"",
            @"long"  : @"--admin-https-cert",
            @"argument" : @"filename",
            @"help"  : @"specify the SSL certificate for the https admin interface"
        },
        @{
            @"name"  : @"tracefiles-path",
            @"long"  : @"--tracefiles-path",
            @"argument" : @"directory",
            @"help"  : @"set the path of the tracefiles directory",
        },
    ];
}

- (NSString *)defaultConfigFile
{
    return @"/etc/ss7.conf";
}

- (NSString *)defaultLogDirectory
{
    return @"/var/log";
}

- (int)defaultWebPort
{
    return 8080;
}
- (NSString *)defaultWebUser
{
    return @"admin";
}
- (NSString *)defaultWebPassword
{
    return @"admin";
}


- (NSString *)defaultApiUser
{
    return @"admin";
}
- (NSString *)defaultApiPassword
{
    return @"admin";
}

- (NSString *)defaultLicensePath
{
    return @"/opt/uliblicense";
}


- (NSString *)defaultFilterEnginesPath
{
    return @"/opt/ulibss7/filter-engines/";
}

- (NSString *)defaultAppsPath
{
    return @"/opt/ulibss7/apps/";
}


- (NSString *)defaultStatisticsPath
{
    return @"/opt/ulibss7/statistics/";
}

- (NSString *)defaultStagingAreaPath
{
    return @"/opt/ulibss7/filter/";
}


- (NSString *)defaultNamedListPath
{
    return @"/opt/ulibss7/named-lists/";
}

- (NSString *)defaultTracefilesPath
{
    return @"/opt/ulibss7/tracefiles/";
}

- (NSString *)productName
{
    return @"ss7-product";
}

- (NSString *)productVersion
{
    return @"0.0.0";
}

- (void)processCommandLine:(int)argc argv:(const char **)argv
{
    @autoreleasepool
    {
        NSDictionary    *appDefinition = [self appDefinition];
        NSArray         *commandLineDefinition = [self commandLineSyntax];

        _commandLine = [[UMCommandLine alloc]initWithCommandLineDefintion:commandLineDefinition
                                                            appDefinition:appDefinition
                                                                     argc:argc
                                                                     argv:argv];
        [_commandLine handleStandardArguments];
        _startupConfig = [[UMSS7ConfigStorage alloc]initWithCommandLine:_commandLine
                                                  defaultConfigFileName:[self defaultConfigFile]];
        _startupConfig.productName = [self productName];
        _runningConfig = [_startupConfig copy];
        if(_runningConfig.rwconfigFile.length > 0)
        {
            [_runningConfig startDirtyTimer];
        }

        [self startDirtyTimer];

        _concurrentThreads = ulib_cpu_count();
        if(self.generalTaskQueue == NULL)
        {
            if(_runningConfig.generalConfig.concurrentTasks!=NULL)
            {
                _concurrentThreads = [_runningConfig.generalConfig.concurrentTasks intValue];
            }
            if(_concurrentThreads<3)
            {
                _concurrentThreads = 3;
            }
            _generalTaskQueue = [[UMTaskQueueMulti alloc]initWithNumberOfThreads:_concurrentThreads
                                                                            name:@"general-task-queue"
                                                                   enableLogging:NO
                                                                  numberOfQueues:UMLAYER_QUEUE_COUNT];
        }

        _umtransportService.delegate = self;

        BOOL actionDone=NO;
        NSDictionary *params = _commandLine.params;
        if(params[@"pid-file"])
        {
            for(NSString *filename in  params[@"pid-file"])
            {
                pid_t pid = getpid();
                NSError *e = NULL;
                NSString *s = [NSString stringWithFormat:@"%llu",(unsigned long long)pid];
                [s writeToFile:filename atomically:YES encoding:NSUTF8StringEncoding error:&e];
                if(e)
                {
                    NSLog(@"Error %@",e);
                }
            }
        }

        /* path parameters */

        NSFileManager * fm = [NSFileManager defaultManager];
        NSError *e = NULL;


        if(params[@"staging-area"])
        {
            NSArray *a = params[@"staging-area"];
            NSString *path = a[a.count-1];
            _stagingAreaPath = path;
        }

        [fm createDirectoryAtPath:_stagingAreaPath withIntermediateDirectories:YES attributes:NULL error:&e];
        if(e)
        {
            NSLog(@"Error while creating directory %@\n%@",_stagingAreaPath,e);
        }

        if(params[@"named-lists-path"])
        {
            NSArray *a = params[@"named-lists-path"];
            NSString *path = a[a.count-1];
            _namedListsDirectory = path;
        }
        e = NULL;
        [fm createDirectoryAtPath:_namedListsDirectory withIntermediateDirectories:YES attributes:NULL error:&e];
        if(e)
        {
            NSLog(@"Error while creating directory %@\n%@",_namedListsDirectory,e);
        }

        _namedLists = [[UMSynchronizedDictionary alloc]init];
        [self loadNamedListsFromPath:_namedListsDirectory];

        if(params[@"ss7-filter-engines-path"])
        {
            for(NSString *path in params[@"ss7-filter-engines-path"])
            {
                [self loadSS7FilterEnginesFromDirectory:path];
                _filterEnginesPath = path;
            }
        }
        else
        {
            [self loadSS7FilterEnginesFromDirectory:_filterEnginesPath];
        }

        if(params[@"ss7-filter-staging-area-path"])
        {
            for(NSString *path in params[@"ss7-filter-staging-area-path"])
            {
                [self loadSS7StagingAreasFromPath:path];
                _stagingAreaPath = path;
            }
        }
        else
        {
            [self loadSS7StagingAreasFromPath:_stagingAreaPath];
        }



        if(params[@"tracefiles-path"])
        {
            NSArray *a = params[@"tracefiles-path"];
            NSString *path = a[a.count-1];
            _ss7TraceFilesDirectory = path;
        }
        e = NULL;
        [fm createDirectoryAtPath:_ss7TraceFilesDirectory withIntermediateDirectories:YES attributes:NULL error:&e];
        if(e)
        {
            NSLog(@"Error while creating directory %@\n%@",_ss7TraceFilesDirectory,e);
        }

        [self loadTracefilesFromPath:_ss7TraceFilesDirectory];




        if(params[@"print-config"])
        {
            NSError *e = NULL;
            NSString *s = [_startupConfig configString];
            [s writeToFile:@"/dev/stdout" atomically:NO encoding:NSUTF8StringEncoding error:&e];
            if(e)
            {
                NSLog(@"Error %@",e);
            }
            actionDone = YES;
        }
        if(params[@"write-compact-config"])
        {
            for(NSString *filename in  params[@"write-compact-config"])
            {
                NSError *e = NULL;
                NSString *s = [_startupConfig configString];
                fprintf(stderr,"writing compact config to %s\n",filename.UTF8String);
                [s writeToFile:filename atomically:NO encoding:NSUTF8StringEncoding error:&e];
                if(e)
                {
                    NSLog(@"Error %@",e);
                }
                actionDone = YES;
            }
        }
        if(params[@"write-split-config"])
        {
            for(NSString *filename in  params[@"write-split-config"])
            {
                NSString *configFile = [filename stringByStandardizingPath];
                NSString *dir = [configFile stringByDeletingLastPathComponent];
                fprintf(stderr,"writing split config to %s\n",filename.UTF8String);
                [_startupConfig writeConfigToDirectory:dir usingFilename:configFile singleFile:NO];
                actionDone = YES;
            }
        }
        if([params[@"umobject-stat"] boolValue])
        {
            umobject_enable_object_stat();
        }
        if([params[@"ummutex-stat"] boolValue])
        {
            ummutex_stat_enable();
        }
        if((!params[@"schrittmacher-id"]) && (params[@"schrittmacher-port"]))
        {
            NSLog(@"schrittmacher-port specified but no schrittmacher-id. Ignoring");
        }

        if(params[@"schrittmacher-id"])
        {
            int schrittmacherPort =7700;
            NSArray<NSString *> *a = params[@"schrittmacher-id"];
            NSString *schrittmacherResourceId = a[0];
            if(params[@"schrittmacher-port"])
            {
                NSArray<NSString *> *a2 = params[@"schrittmacher-port"];
                NSString *s = a2[0];
                schrittmacherPort = [s intValue];
            }
            _schrittmacherClient              = [[SchrittmacherClient alloc]init];
            _schrittmacherClient.resourceId   = schrittmacherResourceId;
            _schrittmacherClient.port         = schrittmacherPort;
            _schrittmacherClient.addressType  = 4;
            [_schrittmacherClient start];
            if(params[@"standby"])
            {
                _schrittmacherMode = SchrittmacherMode_standby;
                [_schrittmacherClient heartbeatStandby];
                _startInStandby = YES;
            }
            else if(params[@"hot"])
            {
                _schrittmacherMode = SchrittmacherMode_hot;
                [_schrittmacherClient heartbeatHot];
                _startInStandby = NO;
            }
            else
            {
                _schrittmacherMode = SchrittmacherMode_unknown;
                [_schrittmacherClient heartbeatUnknown];
            }
        }

        if(actionDone)
        {
            exit(0);
        }
        [self createInstances];
    }
}



- (void)createInstances
{
    /*****************************************************************/
    /* Section GENERAL */
    /*****************************************************************/
    [self.logFeed infoText:@"creatingInstances"];

    UMSS7ConfigGeneral *generalConfig = _runningConfig.generalConfig;
    if(generalConfig.logDirectory.length > 0)
    {
        _logDirectory = generalConfig.logDirectory;
    }
    else
    {
        _logDirectory = [self defaultLogDirectory];
    }
    if(generalConfig.logRotations!=NULL)
    {
        _logRotations = [generalConfig.logRotations intValue];
    }
    else
    {
        _logRotations = 5;
    }

    if(generalConfig.logLevel!=NULL)
    {
        _logLevel = [generalConfig.logLevel intValue];
    }
    else
    {
        _logLevel = UMLOG_MAJOR;
    }

    if(_concurrentThreads<4)
    {
        _concurrentThreads = ulib_cpu_count();
        if(self.generalTaskQueue == NULL)
        {
            if(_runningConfig.generalConfig.concurrentTasks!=NULL)
            {
                _concurrentThreads = [_runningConfig.generalConfig.concurrentTasks intValue];
            }
            if(_concurrentThreads<3)
            {
                _concurrentThreads = 3;
            }
            _generalTaskQueue = [[UMTaskQueueMulti alloc]initWithNumberOfThreads:_concurrentThreads
                                                                            name:@"general-task-queue"
                                                                   enableLogging:NO
                                                                  numberOfQueues:UMLAYER_QUEUE_COUNT];
        }
    }
    _sctpTaskQueue = [[UMTaskQueueMulti alloc]initWithNumberOfThreads:_concurrentThreads
                                                                 name:@"sctp"
                                                        enableLogging:NO
                                                       numberOfQueues:UMLAYER_QUEUE_COUNT];
    _m2paTaskQueue = [[UMTaskQueueMulti alloc]initWithNumberOfThreads:_concurrentThreads
                                                                 name:@"m2pa"
                                                        enableLogging:NO
                                                       numberOfQueues:UMLAYER_QUEUE_COUNT];
    _m3uaTaskQueue = [[UMTaskQueueMulti alloc]initWithNumberOfThreads:_concurrentThreads
                                                                 name:@"m3ua"
                                                        enableLogging:NO
                                                       numberOfQueues:UMLAYER_QUEUE_COUNT];
    _mtp3TaskQueue = [[UMTaskQueueMulti alloc]initWithNumberOfThreads:_concurrentThreads
                                                                 name:@"mtp3"
                                                        enableLogging:NO
                                                       numberOfQueues:UMLAYER_QUEUE_COUNT];
    _sccpTaskQueue = [[UMTaskQueueMulti alloc]initWithNumberOfThreads:_concurrentThreads
                                                                 name:@"sccp"
                                                        enableLogging:NO
                                                       numberOfQueues:UMLAYER_QUEUE_COUNT];
    _tcapTaskQueue = [[UMTaskQueueMulti alloc]initWithNumberOfThreads:_concurrentThreads
                                                                 name:@"tcap"
                                                        enableLogging:NO
                                                       numberOfQueues:UMLAYER_QUEUE_COUNT];
    _gsmmapTaskQueue = [[UMTaskQueueMulti alloc]initWithNumberOfThreads:_concurrentThreads
                                                                   name:@"gsmmap"
                                                          enableLogging:NO
                                                         numberOfQueues:UMLAYER_QUEUE_COUNT];

    _diameterTaskQueue = [[UMTaskQueueMulti alloc]initWithNumberOfThreads:_concurrentThreads
                                                                     name:@"diameter"
                                                            enableLogging:NO
                                                           numberOfQueues:UMLAYER_QUEUE_COUNT];


    _webClient = [[UMHTTPClient alloc]init];
    if(generalConfig.hostname)
    {
        _hostname = generalConfig.hostname;
    }
    else
    {
        _hostname = [UMHost localHostName];
    }

    if(generalConfig.queueHardLimit!=NULL)
    {
        _queueHardLimit = [generalConfig.queueHardLimit unsignedIntegerValue];
    }

    /*****************************************************************/
    /* Section USER */
    /*****************************************************************/

    NSArray *names;
    /* make sure we have at least one default user */
    names = [_runningConfig getAdminUserNames];
    if(names.count == 0)
    {
        UMSS7ConfigAdminUser *user = [[UMSS7ConfigAdminUser alloc]initWithConfig:
                                      @{
                                          @"group":@"user",
                                          @"name": [self defaultWebUser],
                                          @"password": [self defaultWebPassword],
                                      }
                                      ];
        [_runningConfig addAdminUser:user];
    }

    /* make sure we have at least one default user */
    names = [_runningConfig getApiUserNames];
    if(names.count == 0)
    {
        UMSS7ConfigApiUser *user = [[UMSS7ConfigApiUser alloc]initWithConfig:
                                    @{
                                        @"group":@"user",
                                        @"name": [self defaultApiUser],
                                        @"password": [self defaultApiPassword],
                                    }
                                    ];
        [_runningConfig addApiUser:user];
    }
    /* Webserver */
    names = [_runningConfig getWebserverNames];
    if(names.count == 0)
    {
        /* no config at all? lets set up a safe default on port 8086 */
        UMSS7ConfigWebserver *ws = [[UMSS7ConfigWebserver alloc]initWithConfig:
                                    @{ @"group" : @"webserver",
                                       @"name"  : @"default-webserver",
                                       @"port"  : @([self defaultWebPort]),
                                    }];
        [_runningConfig addWebserver:ws];
        names = @[@"default-webserver"];
    }
    for(NSString *name in names)
    {
        UMSS7ConfigObject *co = [_runningConfig getWebserver:name];
        NSDictionary *config = co.config.dictionaryCopy;
        if( [config configEnabledWithYesDefault])
        {
            UMHTTPServer *webServer = NULL;
            int webPort = [[config configEntry:@"port"] intValue];
            if(webPort == 0)
            {
                webPort = 8086;
            }
            if([[config configEntry:@"https"] boolValue])
            {
                NSString *keyFile = [config configEntry:@"https-key-file"];
                NSString *certFile = [config configEntry:@"https-cert-file"];
                webServer = [[UMHTTPSServer alloc]initWithPort:webPort
                                                    sslKeyFile:keyFile
                                                   sslCertFile:certFile];
            }
            else
            {
                webServer = [[UMHTTPServer alloc]initWithPort:webPort];
            }
            if(webServer)
            {
                webServer.enableKeepalive = YES;
                webServer.httpGetPostDelegate = self;
                webServer.httpOptionsDelegate = self;
                webServer.logFeed = [[UMLogFeed alloc]initWithHandler:_logHandler section:@"http"];
                webServer.logFeed.name = name;
                _webserver_dict[name] = webServer;
                webServer.authenticateRequestDelegate = self;
                webServer.documentRoot = [config configEntry:@"document-root"];
                [webServer start];
            }
            _webserver_dict[name] = webServer;
        }
    }

    [self.logFeed infoText:@"configuring syslog"];

    /*****************************************************************/
    /* Section Syslog */
    /*****************************************************************/
    names = [_runningConfig getSyslogDestinationNames];
    for(NSString *name in names)
    {
        UMSS7ConfigObject *co = [_runningConfig getSyslogDestination:name];
        NSDictionary *config = co.config.dictionaryCopy;
        if( [config configEnabledWithYesDefault])
        {
            UMMTP3SyslogClient *syslog = [[UMMTP3SyslogClient alloc]init];
            /* FIXME: we shall do something here */
            _syslog_destination_dict[name] = syslog;
        }
    }

    /*****************************************************************/
    /* SCTP */
    /*****************************************************************/
    names = [_runningConfig getSCTPNames];
    if(names.count > 0)
    {
        if(_sctpFeature.isAvailable==NO)
        {
            [self.logFeed majorErrorText:@"No license for SCTP available but SCTP objects configured"];
        }
        else
        {
            for(NSString *name in names)
            {
                UMSS7ConfigObject *co = [_runningConfig getSCTP:name];
                NSDictionary *config = co.config.dictionaryCopy;
                if( [config configEnabledWithYesDefault])
                {
                    [self addWithConfigSCTP:config];
                }
            }
        }
    }


    /*****************************************************************/
    /* M2PA */
    /*****************************************************************/
    names = [_runningConfig getM2PANames];
    if(names.count > 0)
    {
        if(_m2paFeature.isAvailable==NO)
        {
            [self.logFeed majorErrorText:@"No license for M2PA available but M2PA objects configured"];
        }
        else
        {
            for(NSString *name in names)
            {
                UMSS7ConfigObject *co = [_runningConfig getM2PA:name];
                NSDictionary *config = co.config.dictionaryCopy;
                if( [config configEnabledWithYesDefault])
                {
                    [self addWithConfigM2PA:config];
                }
            }
        }
    }

    /*****************************************************************/
    /* MTP3 */
    /*****************************************************************/
    names = [_runningConfig getMTP3Names];
    if(names.count > 0)
    {
        if(_mtp3Feature.isAvailable==NO)
        {
            [self.logFeed majorErrorText:@"No license for MTP3 available but MTP3 objects configured"];
        }
        else
        {
            for(NSString *name in names)
            {
                UMSS7ConfigObject *co = [_runningConfig getMTP3:name];
                NSDictionary *config = co.config.dictionaryCopy;
                if( [config configEnabledWithYesDefault])
                {
                    [self addWithConfigMTP3:config];
                }
            }
            /*****************************************************************/
            /* MTP3 LinkSet*/
            /*****************************************************************/
            names = [_runningConfig getMTP3LinkSetNames];
            for(NSString *name in names)
            {
                UMSS7ConfigObject *co = [_runningConfig getMTP3LinkSet:name];
                NSDictionary *config = co.config.dictionaryCopy;
                if( [config configEnabledWithYesDefault])
                {
                    [self addWithConfigMTP3LinkSet:config];
                }
            }

            /*****************************************************************/
            /* MTP3 Link */
            /*****************************************************************/
            names = [_runningConfig getMTP3LinkNames];
            for(NSString *name in names)
            {
                UMSS7ConfigObject *co = [_runningConfig getMTP3Link:name];
                NSDictionary *config = co.config.dictionaryCopy;
                if( [config configEnabledWithYesDefault])
                {
                    [self addWithConfigMTP3Link:config];
                }
            }
        }
    }


    /*****************************************************************/
    /* M3UAAS */
    /*****************************************************************/

    names = [_runningConfig getM3UAASNames];
    if(names.count > 0)
    {
        if(_m3uaFeature.isAvailable==NO)
        {
            [self.logFeed majorErrorText:@"No license for M3UA available but M3UA objects configured"];
        }
        else
        {
            for(NSString *name in names)
            {
                UMSS7ConfigObject *co = [_runningConfig getM3UAAS:name];
                NSDictionary *config = co.config.dictionaryCopy;
                if( [config configEnabledWithYesDefault])
                {
                    [self addWithConfigM3UAAS:config];
                }
            }
            /*****************************************************************/
            /* M3UAASP */
            /*****************************************************************/
            names = [_runningConfig getM3UAASPNames];
            for(NSString *name in names)
            {
                UMSS7ConfigObject *co = [_runningConfig getM3UAASP:name];
                NSDictionary *config = co.config.dictionaryCopy;
                if( [config configEnabledWithYesDefault])
                {
                    [self addWithConfigM3UAASP:config];
                }
            }
        }
    }


    /*****************************************************************/
    /* MTP3Routes */
    /*****************************************************************/

    names = [_runningConfig getMTP3RouteNames];
    for(NSString *name in names)
    {
        UMSS7ConfigMTP3Route *co = [_runningConfig getMTP3Route:name];
        NSDictionary *cfg = co.config.dictionaryCopy;
        if( [cfg configEnabledWithYesDefault])
        {
            NSString *instance = [[cfg configEntry:@"mtp3"] stringValue];
            NSString *route = [[cfg configEntry:@"dpc"] stringValue];
            NSString *linkset = [[cfg configEntry:@"ls"] stringValue];
            NSString *as = [[cfg configEntry:@"as"] stringValue];
            NSString *priority = [[cfg configEntry:@"priority"] stringValue];
            int prio;
            if(priority.length > 0)
            {
                prio = [priority intValue];
            }
            else
            {
                prio = 2;
            }
            if(linkset==NULL)
            {
                linkset = as;
            }

            UMLayerMTP3 *mtp3_instance = [self getMTP3:instance];
            if(mtp3_instance)
            {
                UMMTP3LinkSet *mtp3_linkset = [mtp3_instance getLinkSetByName:linkset];
                if(mtp3_linkset)
                {
                    if([route isEqualToString:@"default"])
                    {
                        route = @"0/0";
                    }
                    NSArray *a = [route componentsSeparatedByString:@"/"];
                    UMMTP3PointCode *pc = [[UMMTP3PointCode alloc]initWithString:a[0] variant:mtp3_instance.variant];
                    if([a count] == 1)
                    {
                        [mtp3_instance.routingTable addStaticRoute:pc
                                                     mask:pc.maxmask
                                              linksetName:linkset
                                                 priority:prio];

                    }
                    else if([a count]==2)
                    {
                        UMMTP3PointCode *pc = [[UMMTP3PointCode alloc]initWithString:a[0] variant:mtp3_instance.variant];
                        int mask = [a[1] intValue];
                        [mtp3_instance.routingTable addStaticRoute:pc
                                                     mask:mask
                                              linksetName:linkset
                                                 priority:prio];
                    }
                }
            }
        }
    }

    /* *************************************************************** */
    /* MTP3 Pointcode Translations                                     */
    /* *************************************************************** */

    names = [_runningConfig getPointcodeTranslationTables];
    for(NSString *name in names)
    {
       UMSS7ConfigMTP3PointCodeTranslationTable *co = [_runningConfig getPointcodeTranslationTable:name];
       NSDictionary *cfg = co.config.dictionaryCopy;
       if( [cfg configEnabledWithYesDefault])
       {
           [self addWithConfigMTP3PointCodeTranslationTable:cfg];
       }
    }
    /* ******************************* */
    /* Setup SccpNumberTranslations    */
    /* ******************************* */

    names = [_runningConfig getSCCPNumberTranslationNames];
    for(NSString *name in names)
    {
        UMSS7ConfigSCCPNumberTranslation *co = [_runningConfig getSCCPNumberTranslation:name];
        NSDictionary *config = co.config.dictionaryCopy;

        SccpNumberTranslation *translation = [[SccpNumberTranslation alloc]initWithConfig:config];
        NSMutableArray<UMSS7ConfigObject *> *entries = [co subEntries];
        for(UMSS7ConfigSCCPNumberTranslationEntry *e in entries)
        {
            SccpNumberTranslationEntry *entry = [[SccpNumberTranslationEntry alloc]initWithConfig:e.config.dictionaryCopy];
            [translation addEntry:entry];
        }
        _sccp_number_translations_dict[translation.name] = translation;
    }

    /* *************************************************************** */
    /* SCCP                                                            */
    /* *************************************************************** */

    names = [_runningConfig getSCCPNames];
    if(names.count > 0)
    {
        if(_sccpFeature.isAvailable==NO)
        {
            [self.logFeed majorErrorText:@"No license for SCCP available but SCCP objects configured"];
        }
        else
        {
            for(NSString *name in names)
            {
                UMSS7ConfigObject *co = [_runningConfig getSCCP:name];
                NSDictionary *config = co.config.dictionaryCopy;
                if( [config configEnabledWithYesDefault])
                {
                    [self addWithConfigSCCP:config];
                }
            }

            /* SCCP Destinations */
            names = [_runningConfig getSCCPDestinationNames];
            for(NSString *name in names)
            {
                UMSS7ConfigObject *co = [_runningConfig getSCCPDestination:name];
                NSDictionary *config = co.config.dictionaryCopy;
                if( [config configEnabledWithYesDefault])
                {
                    UMLayerSCCP *sccp = [self getSCCP:config[@"sccp"]];
                    [self addWithConfigSCCPDestination:config subConfigs:co.subConfigs variant:sccp.mtp3.variant];
                }
            }
            /* FIXME: check if there's more in ESTP which we should add here */
        }
    }
    /*****************************************************************/
    /* TCAP */
    /*****************************************************************/
    names = [_runningConfig getTCAPNames];
    if(names.count > 0)
    {
        if(_tcapFeature.isAvailable==NO)
        {
            [self.logFeed majorErrorText:@"No license for TCAP available but TCAP objects configured"];
        }
        else
        {
            for(NSString *name in names)
            {
                UMSS7ConfigObject *co = [_runningConfig getTCAP:name];
                NSDictionary *config = co.config.dictionaryCopy;
                if( [config configEnabledWithYesDefault])
                {
                    [self addWithConfigTCAP:config];
                }
            }
        }
    }
    /*****************************************************************/
    /* GSMMAP */
    /*****************************************************************/
    names = [_runningConfig getGSMMAPNames];
    if(names.count > 0)
    {
        if(_sccpFeature.isAvailable==NO)
        {
            [self.logFeed majorErrorText:@"No license for GSMMAP available but GSMMAP objects configured"];
        }
        else
        {
            for(NSString *name in names)
            {
                UMSS7ConfigObject *co = [_runningConfig getGSMMAP:name];
                NSDictionary *config = co.config.dictionaryCopy;
                if( [config configEnabledWithYesDefault])
                {
                    [self addWithConfigGSMMAP:config];
                }
            }
        }
    }
    /*****************************/
    /* Setup GTT Routing Tables  */
    /*****************************/

    names = [_runningConfig getSCCPTranslationTableNames];
    for(NSString *name in names)
    {
        UMSS7ConfigSCCPTranslationTable *co = [_runningConfig getSCCPTranslationTable:name];
        NSDictionary *config = co.config.dictionaryCopy;

        SccpGttSelector *selector = [[SccpGttSelector alloc]initWithConfig:config];

        if(selector.preTranslationName.length > 0)
        {
            selector.preTranslation = _sccp_number_translations_dict[selector.preTranslationName];
        }
        if(selector.postTranslationName.length > 0)
        {
            selector.postTranslation = _sccp_number_translations_dict[selector.postTranslationName];
        }
        UMLayerSCCP *sccp = [self getSCCP:config[@"sccp"]];
        [sccp.gttSelectorRegistry addEntry:selector];

        if(co.defaultDestination)
        {
            UMSS7ConfigSCCPTranslationTableEntry *e = [[UMSS7ConfigSCCPTranslationTableEntry alloc]init];
            e.translationTableName = name;
            e.gta=@"default";
            e.sccpDestination = co.defaultDestination;
            SccpGttRoutingTableEntry *entry = [[SccpGttRoutingTableEntry alloc]initWithConfig:e.config.dictionaryCopy];
            [selector.routingTable addEntry:entry];
        }
        NSMutableArray<UMSS7ConfigObject *> *entries = [co subEntries];
        for(UMSS7ConfigSCCPTranslationTableEntry *e in entries)
        {
            SccpGttRoutingTableEntry *entry = [[SccpGttRoutingTableEntry alloc]initWithConfig:e.config.dictionaryCopy];
            if(entry.postTranslationName)
            {
                entry.postTranslation = _sccp_number_translations_dict[entry.postTranslationName];
            }
            /*
             if(entry.routeToName)
             {
             entry.routeTo = [self getSCCPDestination: entry.routeToName];
             }*/
            [selector.routingTable addEntry:entry];
        }


    }

    NSArray *sccp_names = [_sccp_dict allKeys];
    for(NSString *sccp_name in sccp_names)
    {
        UMLayerSCCP *sccp = _sccp_dict[sccp_name];
        [sccp.gttSelectorRegistry finishUpdate];
    }

    /*****************************************************************/
    /* Section IMSI Pool */
    /*****************************************************************/
    if([_enabledOptions[@"imsi-pool"] boolValue])
    {
        names = [_runningConfig getIMSIPoolNames];
        for(NSString *name in names)
        {
            UMSS7ConfigObject *co = [_runningConfig getIMSIPool:name];
            NSDictionary *config = co.config.dictionaryCopy;
            if( [config configEnabledWithYesDefault])
            {
                SS7TemporaryImsiPool *pool = [[SS7TemporaryImsiPool alloc]initWithConfig:config];
                _imsi_pools_dict[pool.name] = pool;

            }
        }
    }

    /*****************************************************************/
    /* Configuring App and set up a ULibTransport entity for it     */
    /*****************************************************************/
    if([_enabledOptions[@"estp"] boolValue])
    {
        names = [_runningConfig getESTPNames];
        if(names.count==1)
        {
            NSString *name = names[0];
            UMSS7ConfigESTP *co = [_runningConfig getESTP:name];
            UMLayerSCCP *sccp  = [self getSCCP:co.sccp];
            if(sccp==NULL)
            {
                CONFIG_ERROR(@"can not find sccp entry for estp config");
            }

            NSMutableDictionary *tcapConfig = [[NSMutableDictionary alloc]init];
            NSString *tcapName = [NSString stringWithFormat:@"_ulibtransport-tcap-%@",co.sccp];
            tcapConfig[@"name"] = tcapName;
            tcapConfig[@"attach-to"] = co.sccp;
            tcapConfig[@"variant"] = @"itu";
            tcapConfig[@"subsystem"] = @(SCCP_SSN_ULIBTRANSPORT);
            tcapConfig[@"timeout"] = @(30);
            tcapConfig[@"number"] =co.number;


            UMLayerTCAP *tcap = [[UMLayerTCAP alloc]initWithTaskQueueMulti:_tcapTaskQueue tidPool:_tidPool];
            tcap.logFeed = [[UMLogFeed alloc]initWithHandler:self.logHandler section:@"tcap"];
            tcap.logFeed.name = tcapName;
            tcap.attachedLayer = sccp;
            [tcap setConfig:tcapConfig applicationContext:self];
            _tcap_dict[tcapName] = tcap;
            _umtransportService.tcap = tcap;

            SccpSubSystemNumber *ssn = [[SccpSubSystemNumber alloc]initWithInt:SCCP_SSN_ULIBTRANSPORT];
            SccpAddress *sccpAddr =  [[SccpAddress alloc] initWithHumanReadableString:co.number sccpVariant:sccp.sccpVariant mtp3Variant:sccp.mtp3.variant];
            _umtransportService.localAddress = sccpAddr;
            [sccp setUser:tcap forSubsystem:ssn number:sccpAddr];
            [sccp setUser:tcap forSubsystem:ssn];

            /*****************************************************************************/
            /* we are creating a destination group for umtransport                       */
            /*****************************************************************************/
            SccpDestinationGroup *dstgrp = [[SccpDestinationGroup alloc]init];
            [dstgrp setConfig:@{ @"name" : @"_umtransport" } applicationContext:self];
            SccpDestination *destination = [[SccpDestination alloc]initWithConfig:
                                            @{ @"name" : @"_umtransport-1",
                                               @"ssn"  : @(SCCP_SSN_ULIBTRANSPORT) }
                                                                          variant:UMMTP3Variant_ITU];
            [dstgrp addEntry:destination];
            [sccp.gttSelectorRegistry addDestinationGroup:dstgrp];
            /*****************************************************************************/
            /* we add a GT route to the destination                                      */
            /*****************************************************************************/
            NSMutableDictionary *sConfig = [[NSMutableDictionary alloc]init];
            sConfig[@"gta"] = co.number;
            sConfig[@"destination"] = co.number;
            SccpGttRoutingTableEntry *entry = [[SccpGttRoutingTableEntry alloc]initWithConfig:
                                               @{ @"gta" : co.number, @"destination" : @"_umtransport" }];
            SccpGttSelector *selector = [sccp.gttSelectorRegistry selectorForInstance:co.sccp
                                                                                   tt:0
                                                                                  gti:4
                                                                                   np:1
                                                                                  nai:4];
            [selector.routingTable addEntry:entry];
        }
        else
        {
            CONFIG_ERROR(@"One and only one ESTP config section is required and it must have a name");
        }
    }


    /*****************************************************************/
    /* DiameterRouter */
    /*****************************************************************/
    names = [_runningConfig getDiameterRouterNames];
    if(names.count > 0)
    {
        if(_sccpFeature.isAvailable==NO)
        {
            [self.logFeed majorErrorText:@"No license for Diameter available but Diameter objects configured"];
        }
        else
        {
            for(NSString *name in names)
            {
                UMSS7ConfigDiameterRouter *co = [_runningConfig getDiameterRouter:name];
                NSDictionary *config = co.config.dictionaryCopy;
                if( [config configEnabledWithYesDefault])
                {
                    [self addWithConfigDiameterRouter:config];
                }
            }

            /*****************************************************************/
            /* DiameterRoutes */
            /*****************************************************************/
            names = [_runningConfig getDiameterRoutes];
            for(NSString *name in names)
            {
                UMSS7ConfigDiameterRoute *routeconfig = [_runningConfig getDiameterRoute:name];
                UMSynchronizedSortedDictionary *d = [routeconfig config];
                NSDictionary *dict = [d dictionaryCopy];
                if( [dict configEnabledWithYesDefault])
                {
                    UMDiameterRouter *router = [self getDiameterRouter:routeconfig.router];
                    if(router==NULL)
                    {
                        NSString *s = [NSString stringWithFormat:@"Can not find router '%@'",router];
                        CONFIG_ERROR(s);
                    }
                    UMDiameterRoute *route = [[UMDiameterRoute alloc]initWithConfig:dict];
                    [router addRoute:route];
                }
            }

            /*****************************************************************/
            /* DiameterConnections */
            /*****************************************************************/
            names = [_runningConfig getDiameterConnectionNames];
            for(NSString *name in names)
            {
                UMSS7ConfigDiameterConnection *co = [_runningConfig getDiameterConnection:name];
                NSDictionary *config = co.config.dictionaryCopy;
                if( [config configEnabledWithYesDefault])
                {
                    [self addWithConfigDiameterConnection:config];
                    NSString *routerName = co.router;
                    UMDiameterRouter *router = [self getDiameterRouter:routerName];
                    if(router==NULL)
                    {
                        NSString *s = [NSString stringWithFormat:@"diameter connection '%@' points to non existing router '%@'",name,routerName];
                        CONFIG_ERROR(s);
                    }

                    UMDiameterPeer *peer = [[UMDiameterPeer alloc]initWithTaskQueueMulti:_diameterTaskQueue];
                    peer.logFeed = [[UMLogFeed alloc]initWithHandler:_logHandler section:@"diameter-connection"];
                    peer.logFeed.name = name;
                    [peer setConfig:config applicationContext:self];
                    [router addPeer:peer];
                    _diameter_connections_dict[name] = peer;
                }
            }
        }
    }

    [self startDatabaseConnections];

    /*****************************************************************/
    /* CDR Writers */
    /*****************************************************************/
    {
        [self setupDatabaseTaskQueue];

        NSArray *names = [_runningConfig getCdrWriterNames];
        for (NSString *name in names)
        {
            UMSS7ConfigCdrWriter *co = [_runningConfig getCdrWriter:name];
            NSDictionary *cdr_config = co.config.dictionaryCopy;
            NSString *enableString = cdr_config[@"enable"];
            if(enableString!= NULL)
            {
                if([enableString boolValue]==YES)
                {
                    SS7CDRWriter *cdrWriter = [[SS7CDRWriter alloc]initWithTaskQueueMulti:_databaseQueue usingBatchInsert:YES];
                    cdrWriter.logLevel = _logLevel;
                    [cdrWriter setConfig:cdr_config applicationContext:self];
                    NSString *name = cdrWriter.name;
                    if(name.length > 0)
                    {
                        _cdrWriters_dict[name] = cdrWriter;
                    }
                }
            }
        }
    }

    if(_coreFeature.isAvailable)
    {
        if(_coreFeature.licenseExpiration)
        {
            NSTimeInterval remainingSeconds = [_coreFeature.licenseExpiration timeIntervalSinceDate:[NSDate date]];
            UMTimer *_terminationTimer = [[UMTimer alloc]initWithTarget:self
                                                               selector:@selector(licenseExpiration)
                                                                 object:NULL
                                                                seconds:remainingSeconds
                                                                   name:@"termination-timer"
                                                                repeats:NO
                                                        runInForeground:YES];
            [_terminationTimer start];
        }
    }
    else
    {
        [self.logFeed majorErrorText:@"No license available. Will run for 30 minutes"];
        UMTimer *_terminationTimer = [[UMTimer alloc]initWithTarget:self
                                                           selector:@selector(licenseExpiration)
                                                             object:NULL
                                                            seconds:(30*60)
                                                               name:@"termination-timer"
                                                            repeats:NO
                                                    runInForeground:YES];
        [_terminationTimer start];
    }

}

- (void)licenseExpiration
{
    _must_quit = YES;
    [self.logFeed majorErrorText:@"license expired. Terminating"];
    sleep(120);
    exit(-1);
}

- (void)startInstances
{
    [self.logFeed infoText:@"Starting Instances"];
    NSArray *names = [_mtp3_dict allKeys];
    for(NSString *name in names)
    {
        UMLayerMTP3 *mtp3 = [self getMTP3:name];
        NSLog(@"mtp3 %@ starting",mtp3.layerName);
        [mtp3 start];
        NSLog(@"mtp3 %@ started",mtp3.layerName);
    }

    names = [_diameter_router_dict allKeys];
    for(NSString *name in names)
    {
        UMDiameterRouter *dr = [self getDiameterRouter:name];
        NSLog(@"diameter %@ starting",dr.layerName);
        [dr start];
        NSLog(@"diameter %@ started",dr.layerName);
    }
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    if(!self.startInStandby)
    {
        [self.logFeed infoText:@"Stating instances"];
        [self startInstances];
    }
    else
    {
        [self.logFeed infoText:@"Stating up in standby"];
    }
}



- (void)applicationWillTerminate:(NSNotification *)aNotification
{
    // Insert code here to tear down your application
}

- (void)applicationGoToHot
{
    /* FIXME: do something */
}
- (void)applicationGoToStandby
{
    /* FIXME: do something */
}

/************************************************************/
#pragma mark -
#pragma mark Web Service Functions
/************************************************************/

- (void)  httpGetPost:(UMHTTPRequest *)req
{
    @autoreleasepool
    {
        NSString *path = req.url.relativePath;

        /* hardcoded paths which can not be overwritten */

        if([path isEqualToString:@"/debug"])
        {
            NSString *s = [self webIndexDebug];
            [req setResponseHtmlString:s];
        }
        else if([path isEqualToString:@"/debug/umobject-stat"])
        {
            [self umobjectStat:req];
        }
        else if([path isEqualToString:@"/debug/ummutex-stat"])
        {
            [self ummutexStat:req];
        }
        else if([path isEqualToString:@"/status/sccp/route"])
        {
            [self hanldeSCCPRouteStatus:req];
        }
        else if([path isEqualToString:@"/status/mtp3/route"])
        {
            [self handleMTP3RouteStatus:req];
        }
        else if([path isEqualToString:@"/status/m2pa"])
        {
            [self handleM2PAStatus:req];
        }
        else if([path isEqualToString:@"/status/m3ua"])
        {
            [self handleM3UAStatus:req];
        }
        else if([path isEqualToString:@"/status/sctp"])
        {
            [self handleSCTPStatus:req];
        }


        /* DECODING MENU */

        else if([path isEqualToString:@"/decode"])
        {
            [self handleDecode:req];
        }
        else if(([path isEqualToString:@"/decode/mtp3"])
                ||([path isEqualToString:@"/mtp3/decode"]))
        {
            [self handleDecodeMtp3:req];
        }
        else if(([path isEqualToString:@"/decode/sccp"])
                ||([path isEqualToString:@"/sccp/decode"]))
        {
            [self handleDecodeSccp:req];
        }
        else if(([path isEqualToString:@"/decode/tcap"])
                ||  ([path isEqualToString:@"/tcap/decode"]))
        {
            [self handleDecodeTcap:req];
        }
        else if([path isEqualToString:@"/decode/tcap2"])
        {
            [self handleDecodeTcap2:req];
        }
        else if(([path isEqualToString:@"/decode/asn1"])
                || ([path isEqualToString:@"/asn1/decode"]))
        {
            [self handleDecodeAsn1:req];
        }
        else if(([path isEqualToString:@"/decode/sms"])
                ||  ([path isEqualToString:@"/sms/decode"]))
        {
            [self handleDecodeSms:req];
        }
        else
        {
            BOOL urlServed = NO;
            if(req.documentRoot)
            {
                NSString *fullPath = [NSString stringWithFormat:@"%@/%@",req.documentRoot,req.url.relativePath];
                NSFileManager *fm = [NSFileManager defaultManager];
                BOOL isDirectory=NO;
                if([fm fileExistsAtPath:fullPath isDirectory:&isDirectory])
                {
                    if(isDirectory==NO)
                    {
                        NSData *data = [NSData dataWithContentsOfFile:fullPath];
                        req.responseData = data;
                        req.responseCode = HTTP_RESPONSE_CODE_OK;
                        NSString *extension = [fullPath pathExtension];
                        [req setMimeTypeFromExtension:extension];
                        urlServed=YES;
                    }
                }
            }
            if(urlServed==NO)
            {
                /* default files which can be overriden */
                if([path isEqualToString:@"/"])
                {
                    NSString *s = [self webIndex];
                    [req setResponseHtmlString:s];
                }
                else if([path isEqualToString:@"/css/style.css"])
                {
                    [req setResponseCssString:[SS7AppDelegate css]];
                }
                else if([path isEqualToString:@"/status"])
                {
                    [self handleStatus:req];
                }
                else if([path isEqualToString:@"/route-test"])
                {
                    [self handleRouteTest:req];
                }


                else
                {
                    NSString *s = @"Result: Error\nReason: Unknown request\n";
                    [req setResponseTypeText];
                    req.responseData = [s dataUsingEncoding:NSUTF8StringEncoding];
                    req.responseCode =  HTTP_RESPONSE_CODE_NOT_FOUND;
                }
            }
        }
    }
}

- (void)umobjectStat:(UMHTTPRequest *)req
{
    NSDictionary *p = req.params;
    if (p[@"disable"])
    {
        if(umobject_object_stat_is_enabled())
        {
            umobject_disable_object_stat();
            NSString *path = req.path;
            NSArray *a = [path componentsSeparatedByString:@"?"];
            if(a.count > 1)
            {
                path=a[0];
            }
            [req redirect:path];
            return;
        }
    }
    if (p[@"enable"])
    {
        if(umobject_object_stat_is_enabled()==NO)
        {
            umobject_enable_object_stat();
            NSString *path = req.path;
            NSArray *a = [path componentsSeparatedByString:@"?"];
            if(a.count > 1)
            {
                path=a[0];
            }
            [req redirect:path];
            return;
        }
    }

    NSMutableString *s = [[NSMutableString alloc]init];
    [s appendString:@"<html>\n"];
    [s appendString:@"<head>\n"];
    [s appendString:@"    <link rel=\"stylesheet\" href=\"/css/style.css\" type=\"text/css\">\n"];
    [s appendFormat:@"    <title>Debug: UMObject Statistic</title>\n"];
    [s appendString:@"</head>\n"];
    [s appendString:@"<body>\n"];

    [s appendString:@"<h2>Debug: UMObject Statistic</h2>\n"];
    [s appendString:@"<UL>\n"];
    [s appendString:@"<LI><a href=\"/\">main</a></LI>\n"];
    [s appendString:@"<LI><a href=\"/debug\">debug</a></LI>\n"];
    [s appendString:@"</UL>\n"];



    if(umobject_object_stat_is_enabled())
    {

        [s appendFormat:@"<form method=get><input type=submit name=\"disable\" value=\"disable\"></form>"];

        NSArray *arr = umobject_object_stat(NO);
        [s appendString:@"<table class=\"object_table\">\n"];
        [s appendString:@"    <tr>\r\n"];
        [s appendString:@"        <th class=\"object_title\">Object Type</th>\r\n"];
        [s appendString:@"        <th class=\"object_title\">Alloc Count</th>\r\n"];
        [s appendString:@"        <th class=\"object_title\">Dealloc Count</th>\r\n"];
        [s appendString:@"        <th class=\"object_title\">Currently Allocated</th>\r\n"];
        [s appendString:@"    </tr>\r\n"];
        for(UMObjectStatisticEntry *entry in arr)
        {
            [s appendString:@"    <tr>\r\n"];
            long long allocCounter = entry.allocCounter;
            long long deallocCounter = entry.deallocCounter;
            long long inUseCounter      =  entry.inUseCounter;

            [s appendFormat:@"        <td class=\"smsc_value\">%s</th>\r\n", entry.name];
            [s appendFormat:@"        <td class=\"smsc_value\">%lld</th>\r\n",allocCounter];
            [s appendFormat:@"        <td class=\"smsc_value\">%lld</th>\r\n",deallocCounter];
            [s appendFormat:@"        <td class=\"smsc_value\">%lld</th>\r\n",inUseCounter];
            [s appendString:@"    </tr>\r\n"];

        }
        [s appendString:@"</table>\r\n"];
    }
    else
    {
        [s appendFormat:@"<form method=get><input type=submit name=\"enable\" value=\"enable\"></form>"];
    }
    [s appendString:@"</body>\r\n"];
    [s appendString:@"</html>\r\n"];
    [req setResponseHtmlString:s];
}

- (void)hanldeSCCPRouteStatus:(UMHTTPRequest *)req
{
    UMSynchronizedSortedDictionary *d = [[UMSynchronizedSortedDictionary alloc]init];
    NSArray *names = [_sccp_dict allKeys];
    for(NSString *name in names)
    {
        UMLayerSCCP *sccp = _sccp_dict[name];
        d[name] = [sccp routeStatus];
    }
    [req setResponseJsonString:[d jsonString]];
}

- (void)handleMTP3RouteStatus:(UMHTTPRequest *)req
{
    UMSynchronizedSortedDictionary *d = [[UMSynchronizedSortedDictionary alloc]init];
    NSArray *names = [_mtp3_dict allKeys];
    for(NSString *name in names)
    {
        UMLayerMTP3 *mtp3 = _mtp3_dict[name];
        d[name] = [mtp3 routeStatus];
    }
    [req setResponseJsonString:[d jsonString]];

}
- (void)handleM2PAStatus:(UMHTTPRequest *)req
{
}
- (void)handleM3UAStatus:(UMHTTPRequest *)req
{
}
- (void)handleSCTPStatus:(UMHTTPRequest *)req
{
}

- (void)ummutexStat:(UMHTTPRequest *)req
{
    NSDictionary *p = req.params;
    if (p[@"disable"])
    {
        if(ummutex_stat_is_enabled()==YES)
        {
            ummutex_stat_disable();
            NSString *path = req.path;
            NSArray *a = [path componentsSeparatedByString:@"?"];
            if(a.count > 1)
            {
                path=a[0];
            }
            [req redirect:path];
            return;
        }
    }
    if (p[@"enable"])
    {
        if(ummutex_stat_is_enabled()==NO)
        {
            ummutex_stat_enable();
            NSString *path = req.path;
            NSArray *a = [path componentsSeparatedByString:@"?"];
            if(a.count > 1)
            {
                path=a[0];
            }
            [req redirect:path];
            return;
        }
    }


    NSMutableString *s = [[NSMutableString alloc]init];

    [s appendString:@"<html>\n"];
    [s appendString:@"<head>\n"];
    [s appendString:@"    <link rel=\"stylesheet\" href=\"/css/style.css\" type=\"text/css\">\n"];
    [s appendFormat:@"    <title>Debug: UMMutex Statistic</title>\n"];
    [s appendString:@"</header>\n"];
    [s appendString:@"<body>\n"];

    [s appendString:@"<h2>Debug: UMMutex Statistic</h2>\n"];
    [s appendString:@"<UL>\n"];
    [s appendString:@"<LI><a href=\"/\">main</a></LI>\n"];
    [s appendString:@"<LI><a href=\"/debug\">debug</a></LI>\n"];
    [s appendString:@"</UL>\n"];

    if(ummutex_stat_is_enabled())
    {
        [s appendFormat:@"<form method=get><input type=submit name=\"disable\" value=\"disable\"></form>"];
        NSArray *arr = ummutex_stat(YES);
        [s appendString:@"<table class=\"object_table\">\n"];
        [s appendString:@"    <tr>\r\n"];
        [s appendString:@"        <th class=\"object_title\">Mutex Name</th>\r\n"];
        [s appendString:@"        <th class=\"object_title\">Lock Count</th>\r\n"];
        [s appendString:@"        <th class=\"object_title\">Trylock Count</th>\r\n"];
        [s appendString:@"        <th class=\"object_title\">Unlock Count</th>\r\n"];
        [s appendString:@"        <th class=\"object_title\">Waiting Count</th>\r\n"];
        [s appendString:@"        <th class=\"object_title\">Currently Locked</th>\r\n"];
        [s appendString:@"    </tr>\r\n"];
        for(UMMutexStat *entry in arr)
        {
            [s appendString:@"    <tr>\r\n"];
            [s appendFormat:@"        <td class=\"object_value\">%@</td>\r\n", entry.name];
            [s appendFormat:@"        <td class=\"object_value\">%ld</td>\r\n",(long)entry.lock_count];
            [s appendFormat:@"        <td class=\"object_value\">%ld</td>\r\n",(long)entry.trylock_count];
            [s appendFormat:@"        <td class=\"object_value\">%ld</td>\r\n",(long)entry.unlock_count];
            [s appendFormat:@"        <td class=\"object_value\">%ld</td>\r\n",(long)entry.waiting_count];
            if(entry.currently_locked)
            {
                [s appendFormat:@"        <td class=\"object_value\">YES</td>\r\n"];
            }
            else
            {
                [s appendFormat:@"        <td class=\"object_value\">no</td>\r\n"];
            }
            [s appendString:@"    </tr>\r\n"];
        }
    }
    else
    {
        [s appendFormat:@"<form method=get><input type=submit name=\"enable\" value=\"enable\"></form>"];
    }
    [s appendString:@"</table>\r\n"];
    [s appendString:@"</body>\r\n"];
    [s appendString:@"</html>\r\n"];
    [req setResponseHtmlString:s];
}

- (NSString *)webIndexDebug
{
    static NSMutableString *s = NULL;
    if(s)
    {
        return s;
    }
    s = [[NSMutableString alloc]init];

    [s appendString:@"<html>\n"];
    [s appendString:@"<head>\n"];
    [s appendString:@"    <link rel=\"stylesheet\" href=\"/css/style.css\" type=\"text/css\">\n"];
    [s appendFormat:@"    <title>Debug Menu</title>\n"];
    [s appendString:@"</head>\n"];
    [s appendString:@"<body>\n"];

    [s appendString:@"<h2>Debug Menu</h2>\n"];
    [s appendString:@"<UL>\n"];
    [s appendString:@"<LI><a href=\"/\">&lt-- main-menu</a></LI>\n"];
    [s appendString:@"<LI><a href=\"/debug/umobject-stat\">umobject-stat</a></LI>\n"];
    [s appendString:@"</UL>\n"];
    [s appendString:@"</body>\n"];
    [s appendString:@"</html>\n"];
    return s;
}

- (NSString *)webIndex
{
    static NSMutableString *s = NULL;
    if(s)
    {
        return s;
    }
    s = [[NSMutableString alloc]init];
    [SS7GenericInstance webHeader:s title:@"Main Menu"];

    [s appendString:@"<h2>Main Menu</h2>\n"];
    [s appendString:@"<UL>\n"];
    [s appendString:@"<LI><a href=\"/status\">status</a></LI>\n"];
    [s appendString:@"<LI><a href=\"/route-test\">route-test</a></LI>\n"];
    /* FIXME
     if(mainMscInstance)
     {
     [s appendString:@"<LI><a href=\"/msc\">msc</a></LI>\n"];
     }
     else
     {
     [s appendString:@"<LI><i>msc</i></LI>\n"];
     }

     if(mainHlrInstance)
     {
     [s appendString:@"<LI><a href=\"/hlr\">hlr</a></LI>\n"];
     }
     else
     {
     [s appendString:@"<LI><i>hlr</i></LI>\n"];
     }
     */
    [s appendString:@"</UL>\n"];
    [s appendString:@"</body>\n"];
    [s appendString:@"</html>\n"];
    return s;
}

- (NSString *)routeTestForm:(NSString *)err
{
    NSMutableString *s = [[NSMutableString alloc]init];
    [SS7GenericInstance webHeader:s title:@"Route Test"];

    [s appendString:@"<h2>Route Test</h2>\n"];
    [s appendString:@"<UL>\n"];
    [s appendString:@"<LI><a href=\"/\">main-menu</a></LI>\n"];
    [s appendString:@"</UL>\n"];

    if(err)
    {
        [s appendFormat:@"<p>%@</p>\n",err];
    }
    [s appendString:@"<pre>\n"];
    [s appendString:@"<form>\n"];
    [s appendString:@"SCCP:   <select name=\"sccp\">"];
    NSArray *sccpNames = [self getSCCPNames];
    for(NSString *name in sccpNames)
    {
        [s appendFormat:@"<option value=\"%@\">%@</option>",name,name];
    }
    [s appendString:@"</select>\n"];
    [s appendString:@"MSISDN: <input name=\"msisdn\">\n"];
    [s appendString:@"TT:     <input name=\"tt\" value=0>\n"];
    [s appendString:@"        <input type=submit>\n"];

    [s appendString:@"</form>\n"];
    [s appendString:@"</pre>\n"];


    [s appendString:@"</body>\n"];
    [s appendString:@"</html>\n"];
    return s;
}

- (void)handleRouteTest:(UMHTTPRequest *)req
{
    NSDictionary *p = req.params;
    NSString *msisdn    =    [[p[@"msisdn"]urldecode] stringByTrimmingCharactersInSet:[UMObject whitespaceAndNewlineCharacterSet]];
    NSString *sccp_name = [[p[@"sccp"]urldecode] stringByTrimmingCharactersInSet:[UMObject whitespaceAndNewlineCharacterSet]];
    int tt        = [p[@"tt"] intValue];


    if((msisdn.length == 0) || (sccp_name.length == 0))
    {
        [req setResponseHtmlString:[self routeTestForm:NULL] ];
        return;
    }

    UMLayerSCCP *sccp = [self getSCCP:sccp_name];
    if(sccp==NULL)
    {
        [req setResponseHtmlString:[self routeTestForm:@"can not find SCCP object"] ];
        return;
    }

    UMSynchronizedSortedDictionary *resutlDict = [sccp routeTestForMSISDN:msisdn
                                                          translationType:tt
                                                                fromLocal:NO];
    [req setResponseJsonObject:resutlDict];
    return;
}

- (void)  handleStatus:(UMHTTPRequest *)req
{
    NSMutableString *status = [[NSMutableString alloc]init];
    NSArray *keys = [_sctp_dict allKeys];
    keys = [keys sortedArrayUsingSelector:@selector(compare:)];
    for(NSString *key in keys)
    {
        UMLayerSctp *sctp = _sctp_dict[key];
        [status appendFormat:@"SCTP:%@:%@\n",sctp.layerName,sctp.statusString];
    }

    keys = [_m2pa_dict allKeys];
    keys = [keys sortedArrayUsingSelector:@selector(compare:)];

    for(NSString *key in keys)
    {
        UMLayerM2PA *m2pa = _m2pa_dict[key];

        [status appendFormat:@"M2PA-LINK:%@:%@\n",m2pa.layerName,[m2pa m2paStatusString:m2pa.m2pa_status]];
        [status appendFormat:@"    lscState: %@\n", m2pa.lscState.description];
        [status appendFormat:@"    iacState: %@\n", m2pa.iacState.description];
        [status appendFormat:@"    alignmentsReceived: %d\n", (int)m2pa.alignmentsReceived];
        [status appendFormat:@"    alignmentsSent: %d\n", (int)m2pa.alignmentsReceived];
        [status appendFormat:@"    provingReceived: %d\n", m2pa.provingReceived];
        [status appendFormat:@"    provingSent: %d\n", m2pa.provingSent];
        [status appendFormat:@"    local_processor_outage: %@\n", (m2pa.local_processor_outage ? @"YES" : @"NO")];
        [status appendFormat:@"    remote_processor_outage: %@\n", (m2pa.remote_processor_outage ? @"YES" : @"NO")];
        [status appendFormat:@"    outstanding: %d\n", m2pa.outstanding];
    }

    keys = [_mtp3_linkset_dict allKeys];
    keys = [keys sortedArrayUsingSelector:@selector(compare:)];
    for(NSString *key in keys)
    {
        UMMTP3LinkSet *linkset = _mtp3_linkset_dict[key];
        [linkset updateLinkSetStatus];
        if(linkset.activeLinks > 0)
        {
            [status appendFormat:@"MTP3-LINKSET:%@:IS:%d/%d/%d\n",
             linkset.name,
             linkset.readyLinks,
             linkset.activeLinks,
             linkset.totalLinks];
            [status appendString:[linkset webStatus]];
        }
        else
        {
            [status appendFormat:@"MTP3-LINKSET:%@:OOS:%d/%d/%d\n",
             linkset.name,
             linkset.readyLinks,
             linkset.activeLinks,
             linkset.totalLinks];
            [status appendString:[linkset webStatus]];
        }
    }

    keys = [_m3ua_asp_dict allKeys];
    keys = [keys sortedArrayUsingSelector:@selector(compare:)];
    for(NSString *key in keys)
    {
        UMM3UAApplicationServerProcess *m3ua_asp = _m3ua_asp_dict[key];
        [status appendFormat:@"M3UA-ASP:%@:%@\n",m3ua_asp.layerName,m3ua_asp.statusString];
    }

    keys = [_m3ua_as_dict allKeys];
    keys = [keys sortedArrayUsingSelector:@selector(compare:)];
    for(NSString *key in keys)
    {
        UMM3UAApplicationServer *as = _m3ua_as_dict[key];
        [status appendFormat:@"M3UA-AS:%@:%@",as.layerName,as.statusString];
        [as updateLinkSetStatus];
        [status appendFormat:@":%d/%d/%d\n",as.readyLinks,as.activeLinks,as.totalLinks];
    }

    keys = [_mtp3_dict allKeys];
    keys = [keys sortedArrayUsingSelector:@selector(compare:)];
    for(NSString *key in keys)
    {
        UMLayerMTP3 *mtp3 = _mtp3_dict[key];
        if(mtp3.ready)
        {
            [status appendFormat:@"MTP3-INSTANCE:%@:IS\n",mtp3.layerName];
        }
        else
        {
            [status appendFormat:@"MTP3-INSTANCE:%@:OOS\n",mtp3.layerName];
        }
    }

    keys = [_sccp_dict allKeys];
    keys = [keys sortedArrayUsingSelector:@selector(compare:)];
    for(NSString *key in keys)
    {
        UMLayerSCCP *sccp = _sccp_dict[key];
        [status appendFormat:@"SCCP-INSTANCE:%@:%@\n",sccp.layerName,sccp.status];
    }

    keys = [_tcap_dict allKeys];
    keys = [keys sortedArrayUsingSelector:@selector(compare:)];
    for(NSString *key in keys)
    {
        UMLayerTCAP *tcap = _tcap_dict[key];
        [status appendFormat:@"TCAP-INSTANCE:%@:%@\n",tcap.layerName,tcap.status];
    }

    keys = [_gsmmap_dict allKeys];
    keys = [keys sortedArrayUsingSelector:@selector(compare:)];
    for(NSString *key in keys)
    {
        UMLayerGSMMAP *map = _gsmmap_dict[key];
        [status appendFormat:@"GSMMAP-INSTANCE:%@:%@\n",map.layerName,map.status];
    }

    keys = [_camel_dict allKeys];
    keys = [keys sortedArrayUsingSelector:@selector(compare:)];
    for(NSString *key in keys)
    {
        UMLayerCamel *map = _camel_dict[key];
        [status appendFormat:@"CAMEL-INSTANCE:%@:%@\n",map.layerName,map.status];
    }
    [req setResponsePlainText:status];
    return;
}

+ (NSString *)css
{
    static NSMutableString *s = NULL;

    if(s)
    {
        return s;
    }
    s = [[NSMutableString alloc]init];

    [s appendString:@"/*-- [START] css/mainarea.css --*/\n"];
    [s appendString:@"\n"];
    [s appendString:@"body\n"];
    [s appendString:@"{\n"];
    [s appendString:@"    border: none;\n"];
    [s appendString:@"    padding: 20px;\n"];
    [s appendString:@"    margin: 0px;\n"];
    [s appendString:@"    background-color:white;\n"];
    [s appendString:@"    color: black;\n"];
    [s appendString:@"    font-family: 'Metrophobic', \"Lucida Grande\", \"Lucida Sans Unicode\", arial, Helvetica, Verdana;\n"];
    [s appendString:@"    font-size: 11px;\n"];
    [s appendString:@"}\n"];
    [s appendString:@"\n"];
    [s appendString:@"h1 {\n"];
    [s appendString:@"    font-size: 22px;\n"];
    [s appendString:@"    font-weight: normal;\n"];
    [s appendString:@"    padding-left: 0px;\n"];
    [s appendString:@"    margin-top: 15px;\n"];
    [s appendString:@"    margin-bottom: 20px;\n"];
    [s appendString:@"    color: #639c35;\n"];
    [s appendString:@"}\n"];
    [s appendString:@"\n"];
    [s appendString:@"h2 {\n"];
    [s appendString:@"    font-size: 16px;\n"];
    [s appendString:@"    margin-bottom: 8px;\n"];
    [s appendString:@"    margin-top: 10px;\n"];
    [s appendString:@"    color: #639c35;\n"];
    [s appendString:@"}\n"];
    [s appendString:@"\n"];
    [s appendString:@"\n"];
    [s appendString:@"h3 {\n"];
    [s appendString:@"    font-size: 13px;\n"];
    [s appendString:@"    margin-bottom: 8px;\n"];
    [s appendString:@"    margin-top: 10px;\n"];
    [s appendString:@"    \n"];
    [s appendString:@"    color: black;\n"];
    [s appendString:@"    font-weight: bold;\n"];
    [s appendString:@"    font-family: 'Metrophobic', \"Lucida Grande\", \"Lucida Sans Unicode\", arial, Helvetica, Verdana;\n"];
    [s appendString:@"    font-size: 13px;\n"];
    [s appendString:@"\n"];
    [s appendString:@"}\n"];
    [s appendString:@"\n"];
    [s appendString:@"a {\n"];
    [s appendString:@"    color: #000066;\n"];
    [s appendString:@"    text-decoration: underline;\n"];
    [s appendString:@"    font-weight: bold;\n"];
    [s appendString:@"}\n"];
    [s appendString:@"\n"];
    [s appendString:@"a:hover {\n"];
    [s appendString:@"}\n"];
    [s appendString:@"\n"];
    [s appendString:@"\n"];
    [s appendString:@"hr {\n"];
    [s appendString:@"    height: 1px;\n"];
    [s appendString:@"    margin-bottom: 1em;\n"];
    [s appendString:@"    border-width: 0px;\n"];
    [s appendString:@"    border-bottom-width: 1px;\n"];
    [s appendString:@"    border-color: #000000;\n"];
    [s appendString:@"    border-style: solid;\n"];
    [s appendString:@"}\n"];
    [s appendString:@"\n"];
    [s appendString:@"\n"];
    [s appendString:@".mandatory {\n"];
    [s appendString:@"    color: red;\n"];
    [s appendString:@"    font-weight: bold;\n"];
    [s appendString:@"    font-family: 'Metrophobic', \"Lucida Grande\", \"Lucida Sans Unicode\", arial, Helvetica, Verdana;\n"];
    [s appendString:@"    font-size: 11px;\n"];
    [s appendString:@"}\n"];
    [s appendString:@"\n"];
    [s appendString:@".optional {\n"];
    [s appendString:@"    color: green;\n"];
    [s appendString:@"    font-weight: lighter;\n"];
    [s appendString:@"    font-family: 'Metrophobic', \"Lucida Grande\", \"Lucida Sans Unicode\", arial, Helvetica, Verdana;\n"];
    [s appendString:@"    font-size: 11px;\n"];
    [s appendString:@".conditional {\n"];
    [s appendString:@"    color: brown;\n"];
    [s appendString:@"    font-weight: lighter;\n"];
    [s appendString:@"    font-family: 'Metrophobic', \"Lucida Grande\", \"Lucida Sans Unicode\", arial, Helvetica, Verdana;\n"];
    [s appendString:@"    font-size: 11px;\n"];
    [s appendString:@"}\n"];
    [s appendString:@"\n"];
    [s appendString:@".subtitle {\n"];
    [s appendString:@"    color: black;\n"];
    [s appendString:@"    font-weight: bold;\n"];
    [s appendString:@"    font-family: 'Metrophobic', \"Lucida Grande\", \"Lucida Sans Unicode\", arial, Helvetica, Verdana;\n"];
    [s appendString:@"    font-size: 12px;\n"];
    [s appendString:@"}\n"];
    [s appendString:@".object_table     {  border: solid black; border-width: 1px; border-collapse: collapse; }\n"];
    [s appendString:@".object_title     {  border: solid black; border-width: 1px; background-color: #DDDDDD; }\n"];
    [s appendString:@".object_value     {  border: solid gray; border-width: 1px; }\n"];
    [s appendString:@".object_value_r   {  border: solid gray; border-width: 1px; text-align: right; }\n"];
    [s appendString:@"}\n"];
    return s;
}

- (UMHTTPAuthenticationStatus)httpAuthenticateRequest:(UMHTTPRequest *)req
                                                realm:(NSString **)realm
{
    return UMHTTP_AUTHENTICATION_STATUS_NOT_REQUESTED;

    return UMHTTP_AUTHENTICATION_STATUS_UNTESTED;
}

- (void)webHeader:(NSMutableString *)s title:(NSString *)t
{
    [s appendString:@"<html>\n"];
    [s appendString:@"<head>\n"];
    [s appendString:@"    <link rel=\"stylesheet\" href=\"/css/style.css\" type=\"text/css\">\n"];
    [s appendFormat:@"    <title>%@</title>\n",t];
    [s appendString:@"</head>\n"];
    [s appendString:@"<body>\n"];
}

/************************************************************/
#pragma mark -
#pragma mark Console Handling
/************************************************************/

/* this is used for incoming telnet sessions to authorize by IP */
- (BOOL) isAddressWhitelisted:(NSString *)ipAddress
{
    return YES;
}

/************************************************************/
#pragma mark -
#pragma mark Signal Handling
/************************************************************/

- (void)signal_SIGINT
{
    if (_must_quit == 0)
    {
        NSLog(@"SIGINT received, aborting program...");
        _must_quit = 1;
        [self applicationWillTerminate:NULL];
    }
    else
    {
        NSLog(@"SIGINT received again, force quitting program...");
        _must_quit = 2;
        exit(-1);
    }
}

- (void)signal_SIGUSR1
{
    _schrittmacherMode = SchrittmacherMode_hot;
    NSLog(@"SIGUSR1 received, going to hot...");
    [self applicationGoToHot];
}

- (void)signal_SIGUSR2
{
    _schrittmacherMode = SchrittmacherMode_standby;
    NSLog(@"SIGUSR2 received, going to standby...");
    [self applicationGoToStandby];
}
- (void)signal_SIGHUP
{
    NSLog(@"SIGHUP received, should be reopening logfile...");
}


/************************************************************/
#pragma mark -
#pragma mark SCTP Service Functions
/************************************************************/

- (UMLayerSctp *)getSCTP:(NSString *)name
{
    return _sctp_dict[name];
}

- (void)addWithConfigSCTP:(NSDictionary *)config
{
    NSString *name = config[@"name"];
    if(name)
    {
        UMSS7ConfigSCTP *co = [[UMSS7ConfigSCTP alloc]initWithConfig:config];
        [_runningConfig addSCTP:co];

        config = co.config.dictionaryCopy;
        NSString *name = [config[@"name"]stringValue];
        UMLayerSctp *sctp = [[UMLayerSctp alloc]initWithTaskQueueMulti:_sctpTaskQueue name:name];
        sctp.registry = _registry;
        sctp.logFeed = [[UMLogFeed alloc]initWithHandler:_logHandler section:@"sctp"];
        sctp.logFeed.name = name;
        [sctp setConfig:config applicationContext:self];
        _sctp_dict[name] = sctp;
    }
}


- (void)deleteSCTP:(NSString *)name
{
    UMLayerSctp *instance = _sctp_dict[name];
    [_sctp_dict removeObjectForKey:name];
    [instance stopDetachAndDestroy];

}

- (void)renameSCTP:(NSString *)oldName to:(NSString *)newName
{
    UMLayerSctp *layer =  _sctp_dict[oldName];
    [_sctp_dict removeObjectForKey:oldName];
    layer.layerName = newName;
    _sctp_dict[newName] = layer;
}

/************************************************************/
#pragma mark -
#pragma mark M2PA Service Functions
/************************************************************/

- (UMLayerM2PA *)getM2PA:(NSString *)name
{
    return _m2pa_dict[name];
}

- (void)addWithConfigM2PA:(NSDictionary *)config
{
    NSString *name = config[@"name"];
    if(name)
    {
        UMSS7ConfigM2PA *co = [[UMSS7ConfigM2PA alloc]initWithConfig:config];
        [_runningConfig addM2PA:co];
        UMLayerM2PA *m2pa = [[UMLayerM2PA alloc]initWithTaskQueueMulti:_m2paTaskQueue];
        m2pa.logFeed = [[UMLogFeed alloc]initWithHandler:_logHandler section:@"m2pa"];
        m2pa.logFeed.name = name;
        [m2pa setConfig:config applicationContext:self];
        _m2pa_dict[name] = m2pa;
    }
}

- (void)deleteM2PA:(NSString *)name
{
    UMLayerM2PA *instance = _m2pa_dict[name];
    [_m2pa_dict removeObjectForKey:name];
    [instance stopDetachAndDestroy];
}

- (void)renameM2PA:(NSString *)oldName to:(NSString *)newName
{
    UMLayerM2PA *layer =  _m2pa_dict[oldName];
    [_m2pa_dict removeObjectForKey:oldName];
    layer.layerName = newName;
    _m2pa_dict[newName] = layer;
}

/************************************************************/
#pragma mark -
#pragma mark MTP3 Service Functions
/************************************************************/

- (UMLayerMTP3 *)getMTP3:(NSString *)name
{
    return _mtp3_dict[name];
}



- (void)addWithConfigMTP3:(NSDictionary *)config
{
    NSString *name = config[@"name"];
    if(name)
    {
        UMSS7ConfigMTP3 *co = [[UMSS7ConfigMTP3 alloc]initWithConfig:config];
        [_runningConfig addMTP3:co];

        UMLayerMTP3 *mtp3 = [[UMLayerMTP3 alloc]initWithTaskQueueMulti:_mtp3TaskQueue];
        mtp3.logFeed = [[UMLogFeed alloc]initWithHandler:_logHandler section:@"mtp3"];
        mtp3.logFeed.name = name;
        [mtp3 setConfig:config applicationContext:self];
        _mtp3_dict[name] = mtp3;
    }
}

- (void)deleteMTP3:(NSString *)name
{
    UMLayerMTP3 *instance = _mtp3_dict[name];
    [_mtp3_dict removeObjectForKey:name];
    [instance stopDetachAndDestroy];
}

- (void)renameMTP3:(NSString *)oldName to:(NSString *)newName
{
    UMLayerMTP3 *layer =  _mtp3_dict[oldName];
    [_mtp3_dict removeObjectForKey:oldName];
    layer.layerName = newName;
    _mtp3_dict[newName] = layer;
}

/************************************************************/
#pragma mark -
#pragma mark MTP3 Pointcode Translation Service Functions
/************************************************************/


- (NSArray<NSString *> *)getMTP3PointCodeTranslationTables
{
    return _mtp3_pointcode_translation_tables_dict.allKeys;
}

- (UMMTP3PointCodeTranslationTable *)getMTP3PointCodeTranslationTable:(NSString *)name
{
    return _mtp3_pointcode_translation_tables_dict[name];
}



- (void)addWithConfigMTP3PointCodeTranslationTable:(NSDictionary *)config
{
    NSString *name = config[@"name"];
    if(name)
    {
        UMSS7ConfigMTP3PointCodeTranslationTable *co = [[UMSS7ConfigMTP3PointCodeTranslationTable alloc]initWithConfig:config];
        [_runningConfig addPointcodeTranslationTable:co];

        UMMTP3PointCodeTranslationTable *pctt = [[UMMTP3PointCodeTranslationTable alloc]initWithConfig:config];
        _mtp3_pointcode_translation_tables_dict[name] = pctt;
    }
}

- (void)deleteMTP3PointCodeTranslationTable:(NSString *)name
{
    [_runningConfig deletePointcodeTranslationTable:name];
    [_mtp3_pointcode_translation_tables_dict removeObjectForKey:name];
}

- (void)renameMTP3PointCodeTranslationTable:(NSString *)oldName to:(NSString *)newName
{
    UMMTP3PointCodeTranslationTable *pctt =  _mtp3_pointcode_translation_tables_dict[oldName];
    [_mtp3_pointcode_translation_tables_dict removeObjectForKey:oldName];
    pctt.name = newName;
    _mtp3_pointcode_translation_tables_dict[newName] = pctt;
}


/************************************************************/
#pragma mark -
#pragma mark MTP3Link Service Functions
/************************************************************/

- (UMMTP3Link *)getMTP3Link:(NSString *)name
{
    return _mtp3_link_dict[name];
}

- (void)addWithConfigMTP3Link:(NSDictionary *)config
{
    NSString *name = config[@"name"];
    if(name)
    {
        UMSS7ConfigMTP3Link *co = [[UMSS7ConfigMTP3Link alloc]initWithConfig:config];
        [_runningConfig addMTP3Link:co];

        UMMTP3Link *mtp3link = [[UMMTP3Link alloc]init];
        mtp3link.logFeed = [[UMLogFeed alloc]initWithHandler:_logHandler section:@"mtp3-link"];
        mtp3link.logFeed.name = name;
        [mtp3link setConfig:config applicationContext:self];
        _mtp3_link_dict[name] = mtp3link;
    }
}


- (void)deleteMTP3Link:(NSString *)name
{
    /* FIXME: to be implemented */
}

- (void)renameMTP3Link:(NSString *)oldName to:(NSString *)newName
{
    UMMTP3Link *layer =  _mtp3_link_dict[oldName];
    [_mtp3_link_dict removeObjectForKey:oldName];
    layer.name = newName;
    _mtp3_link_dict[newName] = layer;
}

/************************************************************/
#pragma mark -
#pragma mark MTP3LinkSet Service Functions
/************************************************************/

- (UMMTP3LinkSet *)getMTP3LinkSet:(NSString *)name
{
    return _mtp3_linkset_dict[name];
}

- (void)addWithConfigMTP3LinkSet:(NSDictionary *)config
{
    NSString *name = config[@"name"];
    if(name)
    {
        UMSS7ConfigMTP3LinkSet *co = [[UMSS7ConfigMTP3LinkSet alloc]initWithConfig:config];
        [_runningConfig addMTP3LinkSet:co];

        UMMTP3LinkSet *mtp3linkset = [[UMMTP3LinkSet alloc]init];
        mtp3linkset.logFeed = [[UMLogFeed alloc]initWithHandler:_logHandler section:@"mtp3-linkset"];
        mtp3linkset.logFeed.name = name;
        [mtp3linkset setConfig:config applicationContext:self];
        _mtp3_linkset_dict[name] = mtp3linkset;
        if(co.inbound_filter_rulesets)
        {
            _incomingLinksetFilters[name] = co.inbound_filter_rulesets;
        }
        if(co.outbound_filter_rulesets)
        {
            _outgoingLinksetFilters[name] = co.outbound_filter_rulesets;
        }
    }
}

- (void)deleteMTP3LinkSet:(NSString *)name
{
    /* FIXME: we should probably do more than just remove the object.
     shut it down, unlink it from mtp etc */
    [_mtp3_linkset_dict removeObjectForKey:name];
    [_incomingLinksetFilters removeObjectForKey:name];
    [_outgoingLinksetFilters removeObjectForKey:name];
}

- (void)renameMTP3LinkSet:(NSString *)oldName to:(NSString *)newName
{
    UMMTP3LinkSet *layer =  _mtp3_linkset_dict[oldName];
    [_mtp3_linkset_dict removeObjectForKey:oldName];
    layer.name = newName;
    _mtp3_linkset_dict[newName] = layer;
}



/************************************************************/
#pragma mark -
#pragma mark M3UAAS Service Functions
/************************************************************/

- (UMM3UAApplicationServer *)getM3UAAS:(NSString *)name
{
    return  _m3ua_as_dict[name];
}

- (void)addWithConfigM3UAAS:(NSDictionary *)config
{
    NSString *name = config[@"name"];
    if(name)
    {
        UMSS7ConfigM3UAAS *co = [[UMSS7ConfigM3UAAS alloc]initWithConfig:config];
        [_runningConfig addM3UAAS:co];
        UMM3UAApplicationServer *m3ua_as = [[UMM3UAApplicationServer alloc]init];
        m3ua_as.logFeed = [[UMLogFeed alloc]initWithHandler:_logHandler section:@"m3ua-as"];
        m3ua_as.logFeed.name = name;
        [m3ua_as setConfig:config applicationContext:self];
        _m3ua_as_dict[name] = m3ua_as;
        if(co.inbound_filter_rulesets)
        {
            _incomingLinksetFilters[name] = co.inbound_filter_rulesets;
        }
        if(co.outbound_filter_rulesets)
        {
            _outgoingLinksetFilters[name] = co.outbound_filter_rulesets;
        }
    }
}

- (void)deleteM3UAAS:(NSString *)name
{
    //UMM3UAApplicationServer *instance =  _m3ua_as_dict[name];
    /* FIXME: we should probably do more than just remove the object.
     shut it down, unlink it from mtp etc */
    [_m3ua_as_dict removeObjectForKey:name];
    [_incomingLinksetFilters removeObjectForKey:name];
    [_outgoingLinksetFilters removeObjectForKey:name];
    //    [instance stopDetachAndDestroy];

}

- (void)renameM3UAAS:(NSString *)oldName to:(NSString *)newName
{
    UMM3UAApplicationServer *layer =  _m3ua_as_dict[oldName];
    [_m3ua_as_dict removeObjectForKey:oldName];
    layer.name = newName;
    _m3ua_as_dict[newName] = layer;
}


/************************************************************/
#pragma mark -
#pragma mark M3UAASP Service Functions
/************************************************************/

- (UMM3UAApplicationServerProcess *)getM3UAASP:(NSString *)name
{
    return _m3ua_asp_dict[name];
}


- (void)addWithConfigM3UAASP:(NSDictionary *)config
{
    NSString *name = config[@"name"];
    if(name)
    {
        UMSS7ConfigM3UAASP *co = [[UMSS7ConfigM3UAASP alloc]initWithConfig:config];
        [_runningConfig addM3UAASP:co];

        UMM3UAApplicationServerProcess *m3ua_asp = [[UMM3UAApplicationServerProcess alloc]initWithTaskQueueMulti:_m3uaTaskQueue];
        m3ua_asp.logFeed = [[UMLogFeed alloc]initWithHandler:_logHandler section:@"m3ua-asp"];
        m3ua_asp.logFeed.name = name;
        [m3ua_asp setConfig:config applicationContext:self];
        _m3ua_asp_dict[name] = m3ua_asp;
    }
}

- (void)deleteM3UAASP:(NSString *)name
{
    /* FIXME: to be implemented */
}

- (void)renameM3UAASP:(NSString *)oldName to:(NSString *)newName
{
    UMM3UAApplicationServerProcess *layer =  _m3ua_asp_dict[oldName];
    [_m3ua_asp_dict removeObjectForKey:oldName];
    layer.name = newName;
    _m3ua_asp_dict[newName] = layer;
}


/************************************************************/
#pragma mark -
#pragma mark SCCP Service Functions
/************************************************************/

- (UMLayerSCCP *)getSCCP:(NSString *)name
{
    return _sccp_dict[name];
}

- (NSArray *)getSCCPNames
{
    return [_sccp_dict allKeys];
}

- (void)addWithConfigSCCP:(NSDictionary *)config
{
    NSString *name = config[@"name"];
    if(name)
    {
        UMSS7ConfigSCCP *co = [[UMSS7ConfigSCCP alloc]initWithConfig:config];
        [_runningConfig addSCCP:co];

        UMLayerSCCP *sccp = [[UMLayerSCCP alloc]initWithTaskQueueMulti:_sccpTaskQueue];
        sccp.logFeed = [[UMLogFeed alloc]initWithHandler:_logHandler section:@"sccp"];
        sccp.logFeed.name = name;
        [sccp setConfig:config applicationContext:self];
        _sccp_dict[name] = sccp;
        [sccp.gttSelectorRegistry setSccp_number_translations_dict:_sccp_number_translations_dict];

        if(co.problematicPacketsTraceFile)
        {
            sccp.problematicTraceDestination = _ss7TraceFiles[co.problematicPacketsTraceFile];
        }
        if(co.unrouteablePacketsTraceFile)
        {
            sccp.unrouteablePacketsTraceDestination = _ss7TraceFiles[co.unrouteablePacketsTraceFile];
        }
    }
}

- (void)deleteSCCP:(NSString *)name
{
    UMLayerSCCP *instance = _sccp_dict[name];
    [_sccp_dict removeObjectForKey:name];
    [instance stopDetachAndDestroy];
}

- (void)renameSCCP:(NSString *)oldName to:(NSString *)newName
{
    UMLayerSCCP *layer =  _sccp_dict[oldName];
    [_sccp_dict removeObjectForKey:oldName];
    layer.layerName = newName;
    _sccp_dict[newName] = layer;
}

/************************************************************/
#pragma mark -
#pragma mark SCCP Destinations Functions
/************************************************************/

- (SccpDestinationGroup *)getSCCPDestination:(NSString *)name sccpInstance:(NSString *)sccp_name
{
    UMLayerSCCP *sccp = [self getSCCP:sccp_name];
    return [sccp.gttSelectorRegistry getDestinationGroupByName:name];
}

- (void)addWithConfigSCCPDestination:(NSDictionary *)config
{
    NSString *name = config[@"name"];
    if(name)
    {
        UMSS7ConfigSCCPDestination *co = [[UMSS7ConfigSCCPDestination alloc]initWithConfig:config];
        [_runningConfig addSCCPDestination:co];
        UMLayerSCCP *sccp = [self getSCCP:co.sccp];
        SccpDestinationGroup *dstgrp = [[SccpDestinationGroup alloc]init];
        [dstgrp setConfig:config applicationContext:self];
        [sccp.gttSelectorRegistry addDestinationGroup:dstgrp];
    }
}

- (void)addWithConfigSCCPDestination:(NSDictionary *)config
                          subConfigs:(NSArray<NSDictionary *>*)subConfigs
                             variant:(UMMTP3Variant)variant
{
    NSString *name = config[@"name"];
    if(name)
    {
        UMSS7ConfigSCCPDestination *co = [[UMSS7ConfigSCCPDestination alloc]initWithConfig:config];
        [_runningConfig addSCCPDestination:co];
        UMLayerSCCP *sccp = [self getSCCP:co.sccp];

        SccpDestinationGroup *dstgrp = [[SccpDestinationGroup alloc]init];
        [dstgrp setConfig:config applicationContext:self];
        for(NSDictionary *subConfig in subConfigs)
        {
            UMSS7ConfigSCCPDestinationEntry *coe = [[UMSS7ConfigSCCPDestinationEntry alloc]initWithConfig:subConfig];
            SccpDestination *destination = [[SccpDestination alloc]initWithConfig:subConfig variant:variant];
            [dstgrp addEntry:destination];
            [co addSubEntry:coe];
        }
        [sccp.gttSelectorRegistry addDestinationGroup:dstgrp];
    }
}

- (void)deleteSCCPDestination:(NSString *)name sccpInstance:(NSString *)sccp_name
{
    UMLayerSCCP *sccp = [self getSCCP:sccp_name];
    [sccp.gttSelectorRegistry removeDestinationGroup:name];
}

- (void)renameSCCPDestination:(NSString *)oldName to:(NSString *)newName
{
    /* FIXME: this is now moved into SCCP gttSelectorRegistry */
#if 0

    SccpDestinationGroup *dst =  _sccp_destinations_dict[oldName];
    [_sccp_destinations_dict removeObjectForKey:oldName];
    dst.name = newName;
    _sccp_destinations_dict[newName] = dst;
#endif
}

/************************************************************/
#pragma mark -
#pragma mark SCCP Destination Entry Functions
/************************************************************/

- (SccpDestination *)getSCCPDestinationEntry:(NSString *)name sccpName:(NSString *)sccp_name index:(int)idx
{
    /* FIXME: this is now moved into SCCP gttSelectorRegistry */
#if 0

    SccpDestinationGroup *dst =  _sccp_destinations_dict[name];
    if(dst)
    {
        return [dst entryAtIndex:idx];
    }
#endif
    return NULL;
}

- (void)deleteSCCPDestinationEntry:(NSString *)name sccpName:(NSString *)sccp_name
{
    /* FIXME: this is now moved into SCCP gttSelectorRegistry */
#if 0
    _registry
    [_sccp_destinations_dict removeObjectForKey:name];
#endif
}

- (void)renameSCCPDestinationEntry:(NSString *)oldName to:(NSString *)newName
{
    /* FIXME: this is now moved into SCCP gttSelectorRegistry */

#if 0
    SccpDestinationGroup *dst =  _sccp_destinations_dict[oldName];
    [_sccp_destinations_dict removeObjectForKey:oldName];
    dst.name = newName;
    _sccp_destinations_dict[newName] = dst;
#endif
}




/************************************************************/
#pragma mark -
#pragma mark SCCP NumberTranslation Service Functions
/************************************************************/

- (SccpNumberTranslation *)getSCCPNumberTranslation:(NSString *)name
{
    return _sccp_number_translations_dict[name];
}

- (NSNumber *)concurrentTasksForConfig:(UMSS7ConfigObject *)co
{
    NSNumber *n =  [co concurrentTasks];
    if(n!=NULL)
    {
        return n;
    }
    if(_runningConfig.generalConfig.concurrentTasks!=NULL)
    {
        return _runningConfig.generalConfig.concurrentTasks;
    }
    return @(ulib_cpu_count());
}


/************************************************************/
#pragma mark -
#pragma mark TCAP Service Functions
/************************************************************/


- (UMLayerTCAP *)getTCAP:(NSString *)name
{
    return _tcap_dict[name];
}

- (void)addWithConfigTCAP:(NSDictionary *)config
{
    NSString *name = config[@"name"];
    if(name)
    {
        UMSS7ConfigTCAP *co = [[UMSS7ConfigTCAP alloc]initWithConfig:config];
        [_runningConfig addTCAP:co];

        config = co.config.dictionaryCopy;

        UMLayerTCAP *tcap = [[UMLayerTCAP alloc]initWithTaskQueueMulti:_tcapTaskQueue tidPool:_tidPool];

        tcap.logFeed = [[UMLogFeed alloc]initWithHandler:_logHandler section:@"tcap"];
        tcap.logFeed.name = name;
        [tcap setConfig:config applicationContext:self];
        _tcap_dict[name] = tcap;
        UMLayerSCCP *sccp  = [self getSCCP:co.attachTo];
        if(sccp==NULL)
        {
            [self.logFeed majorErrorText:[NSString stringWithFormat:@"TCAP %@ can not attach to SCCP %@",name,co.attachTo]];
        }
        else
        {
            SccpSubSystemNumber *ssn = [[SccpSubSystemNumber alloc]initWithName:co.subsystem];
            if(co.number)
            {

                SccpAddress *sccpAddr =  [[SccpAddress alloc] initWithHumanReadableString:co.number sccpVariant:sccp.sccpVariant mtp3Variant:sccp.mtp3.variant];
                [sccp setUser:tcap forSubsystem:ssn number:sccpAddr];
            }
            else
            {
                [sccp setUser:tcap forSubsystem:ssn];
            }
            tcap.attachedLayer = sccp;
        }
    }
}

- (void)deleteTCAP:(NSString *)name
{
    // UMLayerTCAP *instance =  _tcap_dict[name];
    [_tcap_dict removeObjectForKey:name];
    //    [instance stopDetachAndDestroy];

}

- (void)renameTCAP:(NSString *)oldName to:(NSString *)newName
{
    UMLayerTCAP *layer =  _tcap_dict[oldName];
    [_tcap_dict removeObjectForKey:oldName];
    layer.layerName = newName;
    _tcap_dict[newName] = layer;
}

/************************************************************/
#pragma mark -
#pragma mark GSMMAP Service Functions
/************************************************************/

- (UMLayerSctp *)getGSMMAP:(NSString *)name
{
    return _gsmmap_dict[name];
}

- (void)addWithConfigGSMMAP:(NSDictionary *)config
{
    NSString *name = config[@"name"];
    if(name)
    {
        UMSS7ConfigGSMMAP *co = [[UMSS7ConfigGSMMAP alloc]initWithConfig:config];
        [_runningConfig addGSMMAP:co];

        config = co.config.dictionaryCopy;


        UMLayerGSMMAP *gsmmap = [[UMLayerGSMMAP alloc]initWithTaskQueueMulti:_gsmmapTaskQueue];
        gsmmap.logFeed = [[UMLogFeed alloc]initWithHandler:_logHandler section:@"tcap"];
        gsmmap.logFeed.name = name;
        [gsmmap setConfig:config applicationContext:self];
        _gsmmap_dict[name] = gsmmap;

        UMLayerTCAP *tcap  = [self getTCAP:co.attachTo];
        if(tcap==NULL)
        {
            [self.logFeed majorErrorText:[NSString stringWithFormat:@"GSM-MAP %@ can not attach to TCAP %@",name,co.attachTo]];
        }
        else
        {
            gsmmap.tcap = tcap;
            tcap.tcapDefaultUser = gsmmap;
        }
    }
}

- (void)deleteGSMMAP:(NSString *)name
{
    // UMLayerGSMMAP *instance =  _gsmmap_dict[name];
    [_gsmmap_dict removeObjectForKey:name];
    //    [instance stopDetachAndDestroy];

}

- (void)renameGSMMAP:(NSString *)oldName to:(NSString *)newName
{
    UMLayerGSMMAP *layer =  _gsmmap_dict[oldName];
    [_gsmmap_dict removeObjectForKey:oldName];
    layer.layerName = newName;
    _gsmmap_dict[newName] = layer;
}

/************************************************************/
#pragma mark -
#pragma mark Diameter Connection Functions
/************************************************************/

- (UMDiameterPeer *)getDiameterConnection:(NSString *)name
{
    return _diameter_connections_dict[name];
}

- (NSArray *)getDiameterConnectionNames
{
    return [_diameter_connections_dict allKeys];
}

- (void)addWithConfigDiameterConnection:(NSDictionary *)config
{
    NSString *name = config[@"name"];
    if(name)
    {
        UMSS7ConfigDiameterConnection *co = [[UMSS7ConfigDiameterConnection alloc]initWithConfig:config];
        [_runningConfig addDiameterConnection:co];
    }
}

- (void)deleteDiameterConnection:(NSString *)name
{
    UMDiameterPeer *peer = _diameter_connections_dict[name];
    [_diameter_connections_dict removeObjectForKey:name];
    [peer stopDetachAndDestroy];
}

- (void)renameDiameterConnection:(NSString *)oldName to:(NSString *)newName
{
    UMDiameterPeer *peer =  _diameter_connections_dict[oldName];
    [_diameter_connections_dict removeObjectForKey:oldName];
    peer.layerName = newName;
    _diameter_connections_dict[newName] = peer;
}


/************************************************************/
#pragma mark -
#pragma mark Diameter Router Functions
/************************************************************/

- (UMDiameterRouter *)getDiameterRouter:(NSString *)name
{
    return _diameter_router_dict[name];
}

- (NSArray *)getDiameterRouterNames
{
    return [_diameter_router_dict allKeys];
}

- (void)addWithConfigDiameterRouter:(NSDictionary *)config
{
    NSString *name = config[@"name"];
    if(name)
    {
        UMSS7ConfigDiameterRouter *co = [[UMSS7ConfigDiameterRouter alloc]initWithConfig:config];
        [_runningConfig addDiameterRouter:co];

        UMDiameterRouter *router = [[UMDiameterRouter alloc]initWithTaskQueueMulti:_diameterTaskQueue name:@"diameter-router"];
        router.logFeed = [[UMLogFeed alloc]initWithHandler:_logHandler section:@"diameter-router"];
        router.logFeed.name = name;
        router.localUser = _mainDiameterInstance;
        _mainDiameterInstance.diameterRouter = router;

        [router setConfig:config applicationContext:self];
        _diameter_router_dict[name] = router;
    }
}

- (void)deleteDiameterRouter:(NSString *)name
{
    /* FIXME */
}

- (void)renameDiameterRouter:(NSString *)oldName to:(NSString *)newName
{
    /* FIXME */
}

/************************************************************/
#pragma mark -
#pragma mark IMSI Pool Service Functions
/************************************************************/

- (SS7TemporaryImsiPool *)getIMSIPool:(NSString *)name
{
    return _imsi_pools_dict[name];
}


- (void)addWithConfigIMSIPool:(NSDictionary *)config
{

    SS7TemporaryImsiPool *pool = [[SS7TemporaryImsiPool alloc]initWithConfig:config];
    _imsi_pools_dict[pool.name] = pool;
}

- (void)deleteIMSIPool:(NSString *)name
{
    [_imsi_pools_dict removeObjectForKey:name];
}

- (void)renameIMSIPool:(NSString *)oldName to:(NSString *)newName
{
    SS7TemporaryImsiPool *pool = _imsi_pools_dict[oldName];
    [_imsi_pools_dict removeObjectForKey:oldName];
    pool.name = newName;
    _imsi_pools_dict[pool.name] = pool;
}







/************************************************************/
#pragma mark -
#pragma mark API Handling
/************************************************************/

- (void)addApiSession:(UMSS7ApiSession *)session
{
    session.timeout = _sessionTimeout;
    _apiSessions[session.sessionKey] = session;
}

- (void)removeApiSession:(NSString *)sessionKey
{
    [_apiSessions removeObjectForKey:sessionKey];
}

- (UMSS7ApiSession *)getApiSession:(NSString *)sessionKey
{
    return _apiSessions[sessionKey];
}

- (UMSynchronizedDictionary *)getAllSessionsSessions
{
    return [_apiSessions copy];
}

- (UMSynchronizedSortedDictionary *)activateSCCPTranslationTable:(NSString *)name tt:(NSNumber *)tt gti:(NSNumber *)gti np:(NSNumber *)np nai:(NSNumber *)nai on:(BOOL)on
{
    return NULL;
}


- (UMSynchronizedSortedDictionary *)cloneSCCPTranslationTable:(NSDictionary *)config
{
    return NULL;
}





- (void)deleteSCCPTranslationTable:(NSString *)name tt:(NSNumber *)tt gti:(NSNumber *)gti np:(NSNumber *)np nai:(NSNumber *)nai
{
    /* FIXME */
}


- (UMSynchronizedSortedDictionary *)modifySCCPTranslationTable:(NSDictionary *)new_config old:(NSDictionary *)old_config
{
    /*FIXME */
    return NULL;
}


- (UMSynchronizedSortedDictionary *)readSCCPTranslationTable:(NSString *)name
                                                          tt:(NSNumber *)tt
                                                         gti:(NSNumber *)gti
                                                          np:(NSNumber *)np
                                                         nai:(NSNumber *)nai
{
    /*FIXME */
    return NULL;
}


- (UMSynchronizedSortedDictionary *)statusSCCPTranslationTable:(NSString *)name tt:(NSNumber *)tt gti:(NSNumber *)gti np:(NSNumber *)np nai:(NSNumber *)nai
{
    /*FIXME */
    return NULL;
}




- (void)apiHousekeeping
{
    NSArray *keys = [_apiSessions allKeys];
    for(NSString *key in keys)
    {
        UMSS7ApiSession *session = [self getApiSession:key];
        if(session)
        {
            if(session.lastUsed.timeIntervalSinceNow > (30*60))
            {
                [self removeApiSession:key];
            }
        }
    }
    [self namedlist_flushAll];
}

- (void)addAccessControlAllowOriginHeaders:(UMHTTPRequest *)req
{
    if(_runningConfig.generalConfig.hostname)
    {
        NSArray *keys = [_webserver_dict allKeys];
        for(NSString *key in keys)
        {
            UMHTTPServer *ws = _webserver_dict[key];
            if(ws.enableSSL)
            {
                if(ws.listenerSocket.localPort == 443)
                {
                    [req setResponseHeader:@"Access-Control-Allow-Origin" withValue:[NSString stringWithFormat:@"https://%@/",_runningConfig.generalConfig.hostname]];
                }
                else
                {
                    [req setResponseHeader:@"Access-Control-Allow-Origin" withValue:[NSString stringWithFormat:@"https://%@:%d/",_runningConfig.generalConfig.hostname,ws.listenerSocket.localPort]];
                }
            }
            else
            {
                if(ws.listenerSocket.localPort == 80)
                {
                    [req setResponseHeader:@"Access-Control-Allow-Origin" withValue:[NSString stringWithFormat:@"http://%@/",_runningConfig.generalConfig.hostname]];
                }
                else
                {
                    [req setResponseHeader:@"Access-Control-Allow-Origin" withValue:[NSString stringWithFormat:@"http://%@:%d/",_runningConfig.generalConfig.hostname,ws.listenerSocket.localPort]];
                }
            }
        }
    }
    else
    {
        [req setResponseHeader:@"Access-Control-Allow-Origin" withValue:@"*"];
    }
    [req setResponseHeader:@"Access-Control-Allow-Methods" withValue:@"GET, POST"];
}

- (void) httpOptions:(UMHTTPRequest *)req
{
    [self addAccessControlAllowOriginHeaders:req];
    req.responseCode =  200;
}

- (void)attachAppTransport:(SS7AppTransportHandler *)transport
                      sccp:(UMLayerSCCP *)sccp
                    number:(NSString *)number
           transactionPool:(UMTCAP_TransactionIdPool *)pool
{
    NSMutableDictionary *tcapConfig = [[NSMutableDictionary alloc]init];
    NSString *tcapName = [NSString stringWithFormat:@"_ulibtransport-tcap-%@",sccp.layerName];
    tcapConfig[@"name"] = tcapName;
    tcapConfig[@"attach-to"] = sccp.layerName;
    tcapConfig[@"variant"] = @"itu";
    tcapConfig[@"subsystem"] = @(SCCP_SSN_ULIBTRANSPORT);
    tcapConfig[@"timeout"] = @(30);
    tcapConfig[@"number"] = number;
    UMLayerTCAP *tcap = [[UMLayerTCAP alloc]initWithTaskQueueMulti:_tcapTaskQueue tidPool:pool];
    tcap.logFeed = [[UMLogFeed alloc]initWithHandler:_logHandler section:@"tcap"];
    tcap.logFeed.name = tcapName;
    tcap.attachedLayer = sccp;
    [tcap setConfig:tcapConfig applicationContext:self];
    _tcap_dict[tcapName] = tcap;
    transport.transportService.tcap = tcap;

    SccpSubSystemNumber *ssn = [[SccpSubSystemNumber alloc]initWithInt:SCCP_SSN_ULIBTRANSPORT];
    SccpAddress *sccpAddr =  [[SccpAddress alloc] initWithHumanReadableString:number
                                                                  sccpVariant:sccp.sccpVariant
                                                                  mtp3Variant:sccp.mtp3.variant];
    transport.transportService.localAddress = sccpAddr;
    [sccp setUser:tcap forSubsystem:ssn number:sccpAddr];
    [sccp setUser:tcap forSubsystem:ssn];
}

- (void) setupSignalHandlers
{
    struct sigaction act;
    act.sa_handler = signalHandler;
    sigemptyset(&act.sa_mask);
    act.sa_flags = 0;
    sigaction(SIGINT, &act, NULL);
    sigaction(SIGHUP, &act, NULL);
    sigaction(SIGUSR1, &act, NULL);
    sigaction(SIGUSR2, &act, NULL);
}

- (int)main:(int)argc argv:(const char **)argv
{
    [self setupSignalHandlers];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [self processCommandLine:argc argv:argv];


    [NSOperationQueue mainQueue];
    /* this initializes some stuff for the main run loop on Linux/GNUStep */

    [self applicationDidFinishLaunching:NULL];

    while(_must_quit==0)
    {
        @autoreleasepool
        {
            [runLoop runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:1.0]];
            [self checkSignals];
        }
    }
    return 0;
}


- (void) writePidFile:(NSString *)filename
{
    if(filename)
    {
        long pid = (long)getpid();
        FILE *f = fopen(filename.UTF8String,"w");
        if(f)
        {
            fprintf(f,"%ld",pid);
            fclose(f);
        }
        else
        {
            fprintf(stderr,"Sorry, can not write pid to '%s'",filename.UTF8String);
        }
    }
}



- (void)checkSignals
{
    if(_signal_sighup>0)
    {
        [self signal_SIGHUP];
        _signal_sighup--;
    }
    if(_signal_sigint>0)
    {
        [self signal_SIGINT];
        _signal_sigint--;
    }
    if(_signal_sigusr1>0)
    {
        [self signal_SIGUSR1];/* go into Hot mode */
        _signal_sigusr1--;
    }
    if(_signal_sigusr2>0)
    {
        [self signal_SIGUSR2]; /* go into Standby Mode */
        _signal_sigusr2--;
    }
}


- (UMHTTPAuthenticationStatus)authenticateUser:(NSString *)user pass:(NSString *)pass
{
    return UMHTTP_AUTHENTICATION_STATUS_UNTESTED;
}


- (NSString *)umtransportGetNewUserReference
{
    static int64_t lastUmtransportDialogId =1;
    int64_t did;
    [_umtransportLock lock];
    lastUmtransportDialogId = (lastUmtransportDialogId + 1 ) % 0x7FFFFFFF;
    did = lastUmtransportDialogId;
    [_umtransportLock unlock];
    return [NSString stringWithFormat:@"%08llX",(long long)did];
}

/* the UMTransportService tells us about a new dialog connecting to us */
- (void)umtransportOpenIndication:(UMTransportOpen *)pdu
                    userReference:(NSString *)userDialogRef
                         dialogId:(UMTCAP_UserDialogIdentifier *)dialogId
                    remoteAddress:(SccpAddress *)address
{
    NSLog(@"UMTransport[%@] OpenIndication from %@",userDialogRef,[address stringValueE164]);
    NSLog(@"PDU: %@",pdu.objectValue);
}

/* the UMTransportService tells us the dialog is closed now */
- (void)umtransportCloseIndication:(UMTransportClose *)pdu
                     userReference:(NSString *)userDialogRef
                          dialogId:(UMTCAP_UserDialogIdentifier *)dialogId
{
    NSLog(@"UMTransport[%@] CloseIndication",userDialogRef);
    NSLog(@"PDU: %@",pdu.objectValue);
}

/* the UMTransportService tells us the remote side has issued an invoke towards us which we should respond with a dialogTransportResponse */
- (void)umtransportTransportIndication:(UMTransportRequest *)pdu
                         userReference:(NSString *)userDialogRef
                              dialogId:(UMTCAP_UserDialogIdentifier *)dialogId
                              invokeId:(int64_t)invokeId
{
    NSLog(@"UMTransport[%@:%llu] TransportIndication",userDialogRef,(unsigned long long)invokeId);
    NSLog(@"PDU: %@",pdu.objectValue);
    switch(pdu.requestOperationCode)
    {
        case UMTransportCMD_Ping:
            [self umtPing:pdu
            userReference:userDialogRef
                 dialogId:dialogId
                 invokeId:invokeId];

            break;
        case UMTransportCMD_GetVersion:
            [self umtGetVersion:pdu
                  userReference:userDialogRef
                       dialogId:dialogId
                       invokeId:invokeId];
            break;

        case UMTransportCMD_ReportVersion:
            [self umtReportVersion:pdu
                     userReference:userDialogRef
                          dialogId:dialogId
                          invokeId:invokeId];

            break;

        case UMTransportCMD_GetHardware:
            [self umtGetHardware:pdu
                   userReference:userDialogRef
                        dialogId:dialogId
                        invokeId:invokeId];

            break;

        case UMTransportCMD_ReportHardware:
            [self umtReportHardware:pdu
                      userReference:userDialogRef
                           dialogId:dialogId
                           invokeId:invokeId];

            break;

        case UMTransportCMD_GetLicense:
            [self umtGetLicense:pdu
                  userReference:userDialogRef
                       dialogId:dialogId
                       invokeId:invokeId];

            break;

        case UMTransportCMD_ReportLicense:
            [self umtReportLicense:pdu
                     userReference:userDialogRef
                          dialogId:dialogId
                          invokeId:invokeId];

            break;

        case UMTransportCMD_UpdateLicense:
            [self umtUpdateLicense:pdu
                     userReference:userDialogRef
                          dialogId:dialogId
                          invokeId:invokeId];

            break;
    }
}


- (void)umtransportTransportConfirmation:(UMTransportResponse *)pdu
                           userReference:(NSString *)userDialogRef
                                dialogId:(UMTCAP_UserDialogIdentifier *)dialogId
                                invokeId:(int64_t)invokeId
{
    NSString *key = [NSString stringWithFormat:@"%@:%llu",dialogId.dialogId,(unsigned long long)invokeId];
    UMTTask *task = _pendingUMT[key];
    [_pendingUMT removeObjectForKey:key];
    [task processResponse:pdu];
}


- (void)umtPing:(UMTransportRequest *)pdu
  userReference:(NSString *)userDialogRef
       dialogId:(UMTCAP_UserDialogIdentifier *)dialogId
       invokeId:(int64_t)invokeId
{
    UMTransportMessage *msg = [[UMTransportMessage alloc]init];
    msg.response = [[UMTransportResponse alloc]init];
    msg.response.requestReference = pdu.requestReference;
    msg.response.requestOperationCode = pdu.requestOperationCode;
    msg.response.responsePayload = pdu.requestPayload;
    [_umtransportService umtransportTransportResponse:msg
                                             dialogId:dialogId
                                             invokeId:invokeId];
}

- (void)umtGetVersion:(UMTransportRequest *)pdu
        userReference:(NSString *)userDialogRef
             dialogId:(UMTCAP_UserDialogIdentifier *)dialogId
             invokeId:(int64_t)invokeId
{
    UMTransportMessage *msg = [[UMTransportMessage alloc]init];
    msg.response = [[UMTransportResponse alloc]init];
    msg.response.requestReference = pdu.requestReference;
    msg.response.requestOperationCode = pdu.requestOperationCode;

    UMTransportVersionResp *r = [[UMTransportVersionResp alloc]init];
    r.product = [self productName];
    r.version = [self productVersion];
    msg.response.responsePayload = [r berEncoded];
    [_umtransportService umtransportTransportResponse:msg
                                             dialogId:dialogId
                                             invokeId:invokeId];
}

- (void)umtReportVersion:(UMTransportRequest *)pdu
           userReference:(NSString *)userDialogRef
                dialogId:(UMTCAP_UserDialogIdentifier *)dialogId
                invokeId:(int64_t)invokeId
{
    UMTransportVersionResp *ver = [[UMTransportVersionResp alloc]initWithBerData:pdu.requestPayload];
    NSLog(@"remote reports its version to be :%@",ver);

    UMTransportMessage *msg = [[UMTransportMessage alloc]init];
    msg.response = [[UMTransportResponse alloc]init];
    msg.response.requestReference = pdu.requestReference;
    msg.response.requestOperationCode = pdu.requestOperationCode;
    msg.response.responsePayload = NULL;
    [_umtransportService umtransportTransportResponse:msg
                                             dialogId:dialogId
                                             invokeId:invokeId];
}

- (void)umtGetHardware:(UMTransportRequest *)pdu
         userReference:(NSString *)userDialogRef
              dialogId:(UMTCAP_UserDialogIdentifier *)dialogId
              invokeId:(int64_t)invokeId
{
    UMTransportMessage *msg = [[UMTransportMessage alloc]init];
    msg.response = [[UMTransportResponse alloc]init];
    msg.response.requestReference = pdu.requestReference;
    msg.response.requestOperationCode = pdu.requestOperationCode;

    UMTransportHardwareIdentifierList *r = [[UMTransportHardwareIdentifierList alloc]init];

    NSArray *macs = [UMUtil getArrayOfMacAddresses];
    for(NSString *mac in macs)
    {
        UMTransportHardwareIdentifier *hi = [[UMTransportHardwareIdentifier alloc]init];
        hi.macAddress = mac;
        [r addHardwareIdentifier:hi];
    }

    NSArray *ips = [UMUtil getNonLocalIPs];
    for(NSString *ip in ips)
    {
        UMTransportHardwareIdentifier *hi = [[UMTransportHardwareIdentifier alloc]init];
        hi.ip = ip;
        [r addHardwareIdentifier:hi];
    }
    NSString *serial = [UMUtil getMachineSerialNumber];
    if(serial)
    {
        UMTransportHardwareIdentifier *hi = [[UMTransportHardwareIdentifier alloc]init];
        hi.serial = serial;
        [r addHardwareIdentifier:hi];
    }
    NSString *uuid = [UMUtil getMachineUUID];
    if(uuid)
    {
        UMTransportHardwareIdentifier *hi = [[UMTransportHardwareIdentifier alloc]init];
        hi.uuid = uuid;
        [r addHardwareIdentifier:hi];
    }

#if defined(__APPLE__)
    {
        UMTransportHardwareIdentifier *hi = [[UMTransportHardwareIdentifier alloc]init];
        hi.os = @"macos";
        [r addHardwareIdentifier:hi];
    }
#endif
#if defined(LINUX)
    {
        UMTransportHardwareIdentifier *hi = [[UMTransportHardwareIdentifier alloc]init];
        hi.os = @"linux";
        [r addHardwareIdentifier:hi];
    }
#endif

    NSString *sysname = [UMUtil sysName];
    if(sysname)
    {
        UMTransportHardwareIdentifier *hi = [[UMTransportHardwareIdentifier alloc]init];
        hi.sysname = sysname;
        [r addHardwareIdentifier:hi];
    }
    NSString *nodename = [UMUtil nodeName];
    if(nodename)
    {
        UMTransportHardwareIdentifier *hi = [[UMTransportHardwareIdentifier alloc]init];
        hi.nodeName = nodename;
        [r addHardwareIdentifier:hi];
    }
    NSString *osRelease = [UMUtil osRelease];
    if(osRelease)
    {
        UMTransportHardwareIdentifier *hi = [[UMTransportHardwareIdentifier alloc]init];
        hi.osRelease = osRelease;
        [r addHardwareIdentifier:hi];
    }
    NSString *osVersion = [UMUtil version];
    if(osVersion)
    {
        UMTransportHardwareIdentifier *hi = [[UMTransportHardwareIdentifier alloc]init];
        hi.osVersion = osVersion;
        [r addHardwareIdentifier:hi];
    }
    NSString *osMachine = [UMUtil machine];
    if(osMachine)
    {
        UMTransportHardwareIdentifier *hi = [[UMTransportHardwareIdentifier alloc]init];
        hi.osMachine = osMachine;
        [r addHardwareIdentifier:hi];
    }
    msg.response.responsePayload = [r berEncoded];
    [_umtransportService umtransportTransportResponse:msg
                                             dialogId:dialogId
                                             invokeId:invokeId];
}

- (void)umtReportHardware:(UMTransportRequest *)pdu
            userReference:(NSString *)userDialogRef
                 dialogId:(UMTCAP_UserDialogIdentifier *)dialogId
                 invokeId:(int64_t)invokeId
{

}
- (void)umtGetLicense:(UMTransportRequest *)pdu
        userReference:(NSString *)userDialogRef
             dialogId:(UMTCAP_UserDialogIdentifier *)dialogId
             invokeId:(int64_t)invokeId
{

}

- (void)umtReportLicense:(UMTransportRequest *)pdu
           userReference:(NSString *)userDialogRef
                dialogId:(UMTCAP_UserDialogIdentifier *)dialogId
                invokeId:(int64_t)invokeId
{

}

- (void)umtUpdateLicense:(UMTransportRequest *)pdu
           userReference:(NSString *)userDialogRef
                dialogId:(UMTCAP_UserDialogIdentifier *)dialogId
                invokeId:(int64_t)invokeId
{

}


/* the UMTransportService tells us about an answer to our request we sent to a remote */
- (void)umtransportTransportConfirmation:(UMTransportResponse *)pdu
                           userReference:(NSString *)userDialogRef
                                invokeId:(int64_t)invokeId
{
    NSLog(@"UMTransport[%@:%llu] TransportConfirmation",userDialogRef,(unsigned long long)invokeId);
    NSLog(@"PDU: %@",pdu.objectValue);
}

- (NSString *)umtWebIndexForm
{
    static NSMutableString *s = NULL;

    if(s)
    {
        return s;
    }
    s = [[NSMutableString alloc]init];
    [self webHeader:s title:@"UMT Main Menu"];
    [s appendString:@"<h2>UMT Main Menu</h2>\n"];
    [s appendString:@"<UL>\n"];
    [s appendString:@"<LI><a href=\"/umt/ping\">ping</a>\n"];
    [s appendString:@"<LI><a href=\"/umt/get-version\">get-version</a>\n"];
    [s appendString:@"<LI><a href=\"/umt/get-hardware\">get-hardware</a>\n"];
    [s appendString:@"</UL>\n"];
    [s appendString:@"</body>\n"];
    [s appendString:@"</html>\n"];
    return s;
}

- (void)webFormStart:(NSMutableString *)s title:(NSString *)t
{
    [self webHeader:s title:t];
    [s appendString:@"\n"];
    [s appendString:@"<a href=\"index.php\">menu</a>\n"];
    [s appendFormat:@"<h2>%@</h2>\n",t];
    [s appendString:@"<form method=\"get\">\n"];
    [s appendString:@"<table>\n"];

}

- (void)webFormEnd:(NSMutableString *)s
{
    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td>&nbsp</td>\n"];
    [s appendString:@"    <td><input type=submit></td>\n"];
    [s appendString:@"</tr>\n"];
    [s appendString:@"</table>\n"];
    [s appendString:@"</form>\n"];
    [s appendString:@"</body>\n"];
    [s appendString:@"</html>\n"];
    [s appendString:@"\n"];
}

- (void)webMapTitle:(NSMutableString *)s
{
    [s appendString:@"<tr><td colspan=2 class=subtitle>GSMMAP Parameters:</td></tr>\n"];
}

- (void)webDialogTitle:(NSMutableString *)s
{
    [s appendString:@"<tr><td colspan=2 class=subtitle>Dialogue Parameters:</td></tr>\n"];
}

- (void)webDialogOptions:(NSMutableString *)s
{
    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>map-open-destination-msisdn</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"map-open-destination-msisdn\" type=text placeholder=\"+12345678\"> msisdn in map-open destination reference</td>\n"];
    [s appendString:@"</tr>\n"];
    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>map-open-destination-imsi</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"map-open-destination-imsi\" type=text> imsi in map-open destination reference</td>\n"];
    [s appendString:@"</tr>\n"];
    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>map-open-origination-msisdn</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"map-open-origination-msisdn\" type=text placeholder=\"+12345678\"> msisdn in map-open origination reference</td>\n"];
    [s appendString:@"</tr>\n"];
    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>map-open-origination-imsi</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"map-open-origination-imsi\" type=text> imsi in map-open origination reference</td>\n"];
    [s appendString:@"</tr>\n"];
}

- (void)webTcapTitle:(NSMutableString *)s
{
    [s appendString:@"<tr><td colspan=2 class=subtitle>TCAP Parameters:</td></tr>\n"];
}

- (void)webVariousTitle:(NSMutableString *)s
{
    [s appendString:@"<tr><td colspan=2 class=subtitle>Various Extensions:</td></tr>\n"];
}

- (void)webTcapOptions:(NSMutableString *)s
            appContext:(NSString *)ac
        appContextName:(NSString *)acn
{
    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>tcap-handshake</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"tcap-handshake\" type=\"text\" value=\"0\"> 0 |&nbsp;1</td>\n"];
    [s appendString:@"</tr>\n"];
    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>timeout</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"timeout\" type=\"text\" value=\"30\"> timeout in seconds</td>\n"];
    [s appendString:@"</tr>\n"];
    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>application-context</td>\n"];
    [s appendFormat:@"    <td class=optional><input name=\"application-context\" type=\"text\" value=\"%@\"> %@</td>\n",ac,acn];
    [s appendString:@"</tr>\n"];
}

- (void)webSccpTitle:(NSMutableString *)s
{
    [s appendString:@"<tr><td colspan=2 class=subtitle>SCCP Parameters:</td></tr>\n"];
}

- (void)webSccpOptions:(NSMutableString *)s
        callingComment:(NSString *)callingComment
         calledComment:(NSString *)calledComment
            callingSSN:(NSString *)callingSSN
             calledSSN:(NSString *)calledSSN
{
    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>calling-address</td>\n"];
    [s appendFormat:@"    <td class=optional><input name=\"calling-address\" type=\"text\" placeholder=\"+12345678\" value=\"default\"> %@</td>\n",callingComment];
    [s appendString:@"</tr>\n"];
    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>called-address</td>\n"];
    [s appendFormat:@"    <td class=optional><input name=\"called-address\" type=\"text\" placeholder=\"+12345678\" value=\"default\"> %@</td>\n",calledComment];
    [s appendString:@"</tr>\n"];
    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>calling-ssn</td>\n"];
    [s appendFormat:@"    <td class=optional><input name=\"calling-ssn\" type=\"text\" value=\"%@\"></td>\n",callingSSN];
    [s appendString:@"</tr>\n"];
    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>called-ssn</td>\n"];
    [s appendFormat:@"    <td class=optional><input name=\"called-ssn\" type=\"text\" value=\"%@\"></td>\n",calledSSN];
    [s appendString:@"</tr>\n"];
    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>calling-tt</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"calling-tt\" type=\"text\" value=\"0\"></td>\n"];
    [s appendString:@"</tr>\n"];
    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>called-tt</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"called-tt\" type=\"text\" value=\"0\"></td>\n"];
    [s appendString:@"</tr>\n"];
}

- (void)webMtp3Title:(NSMutableString *)s
{
    [s appendString:@"<tr><td colspan=2 class=subtitle>MTP3 Parameters:</td></tr>\n"];
}

- (void)webMtp3Options:(NSMutableString *)s
{
    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>opc</td>\n"];
    [s appendFormat:@"    <td class=optional><input name=\"opc\" type=\"text\" placeholder=\"0-000-0\" value=\"default\">originating pointcode</td>\n"];
    [s appendString:@"</tr>\n"];
    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>dpc</td>\n"];
    [s appendFormat:@"    <td class=optional><input name=\"dpc\" type=\"text\" placeholder=\"0-000-0\" value=\"default\">destination pointcode</td>\n"];
    [s appendString:@"</tr>\n"];
}

- (NSString *)umtPingForm:(int)variant
{
    static NSMutableString *s = NULL;

    if(s)
    {
        return s;
    }
    s = [[NSMutableString alloc]init];

    [self webFormStart:s title:@"UMT Ping"];

    [s appendString:@"<tr><td colspan=2 class=subtitle>UMT Ping Destination:</td></tr>\n"];
    [s appendString:@"<tr>\n"];
    [s appendString:@"    <td class=optional>sccp-destination</td>\n"];
    [s appendString:@"    <td class=optional><input name=\"sccp-destination\" type=text placeholder=\"+12345678\">(E.164 number))</td>\n"];
    [s appendString:@"</tr>\n"];
    [self webFormEnd:s];
    return s;
}

- (void)  umtGetPost:(UMHTTPRequest *)req
{
    NSDictionary *p = req.params;
    int pcount=0;
    for(NSString *n in p.allKeys)
    {
        if(([n isEqualToString:@"user"])  || ([n isEqualToString:@"pass"]))
        {
            continue;
        }
        pcount++;
    }

    @autoreleasepool
    {
        @try
        {
            NSString *path = req.url.relativePath;

            if([path hasSuffix:@".php"])
            {
                path = [path substringToIndex:path.length - 4];
            }
            if([path hasSuffix:@".html"])
            {
                path = [path substringToIndex:path.length - 5];
            }
            if([path hasSuffix:@"/"])
            {
                path = [path substringToIndex:path.length - 1];
            }

            if([path isEqualToStringCaseInsensitive:@"/umt/index"])
            {
                path = @"/umt";
            }

            if([path isEqualToStringCaseInsensitive:@"/umt"])
            {
                [req setResponseHtmlString:[self umtWebIndexForm]];
            }
            else if([path isEqualToStringCaseInsensitive:@"/umt/ping"])
            {
                if(pcount==0)
                {
                    [req setResponseHtmlString:[self umtPingForm:0]];
                }
                else
                {
                    NSString *addr = [p[@"sccp-destination"] urldecode];
                    UMTTaskPing *t = [[UMTTaskPing alloc]init];
                    t.req = req;
                    t.remoteAddr = [[SccpAddress alloc]initWithHumanReadableString:addr variant:UMMTP3Variant_ITU];
                    t.transportService = _umtransportService;
                    [req makeAsyncWithTimeout:6];
                    [self.generalTaskQueue queueTask:t toQueueNumber:0];
                }
            }
            else if([path isEqualToStringCaseInsensitive:@"/umt/get-version"])
            {
                if(pcount==0)
                {
                    [req setResponseHtmlString:[self umtPingForm:0]];
                }
                else
                {
                    /* FIXME: create a request and remember the req in a dict */
                    UMTTaskGetVersion *t = [[UMTTaskGetVersion alloc]init];
                    t.req = req;
                    NSString *addr = p[@"destination"];
                    t.remoteAddr = [[SccpAddress alloc]initWithHumanReadableString:addr variant:UMMTP3Variant_ITU];
                    [self.generalTaskQueue queueTask:t toQueueNumber:0];
                }
            }
        }
        @catch(NSException *e)
        {

            NSMutableDictionary *d1 = [[NSMutableDictionary alloc]init];
            if(e.name)
            {
                d1[@"name"] = e.name;
            }
            if(e.reason)
            {
                d1[@"reason"] = e.reason;
            }
            if(e.userInfo)
            {
                d1[@"user-info"] = e.userInfo;
            }
            NSDictionary *d =   @{ @"error" : @{ @"exception": d1 } };
            [req setResponsePlainText:[d jsonString]];
        }
    }
}

- (UMTTask *)getPendingUMTTaskForDialog:(UMTCAP_UserDialogIdentifier *)dialogId
                               invokeId:(int64_t)invokeId
{
    NSString *key = [NSString stringWithFormat:@"%@:%llu",dialogId.dialogId,(unsigned long long)invokeId];
    UMTTask *task = _pendingUMT[key];
    return task;
}

- (UMTTask *)getAndRemovePendingUMTTaskForDialog:(UMTCAP_UserDialogIdentifier *)dialogId
                                        invokeId:(int64_t)invokeId
{
    NSString *key = [NSString stringWithFormat:@"%@:%llu",dialogId.dialogId,(unsigned long long)invokeId];
    UMTTask *task = _pendingUMT[key];
    [_pendingUMT removeObjectForKey:key];
    return task;
}

- (void)addPendingUMTTask:(UMTask *)task
                   dialog:(UMTCAP_UserDialogIdentifier *)_dialogId
                 invokeId:(int64_t)_invokeId
{
    NSString *key = [NSString stringWithFormat:@"%@:%llu",_dialogId.dialogId,(unsigned long long)_invokeId];
    _pendingUMT[key]=task;
}


- (void)umtransportOpenConfirmation:(UMTransportOpenAccept *)pdu
                           dialogId:(UMTCAP_UserDialogIdentifier *)dialogId
                           invokeId:(int64_t)invokeId
{
    UMTTask *task = [self getAndRemovePendingUMTTaskForDialog:dialogId invokeId:invokeId];
    [task openConfirmation:pdu];
}

- (void)umtransportCloseConfirmation:(UMTransportCloseAccept *)pdu
                            dialogId:(UMTCAP_UserDialogIdentifier *)dialogId
                            invokeId:(int64_t)invokeId
{
    UMTTask *task = [self getAndRemovePendingUMTTaskForDialog:dialogId invokeId:invokeId];
    [task closeConfirmation:pdu];
}



- (void)addSCCPTranslationTable:(NSDictionary *)config
{
    NSString *name = config[@"name"];
    if(name)
    {
        UMLayerSCCP *sccp = [self getSCCP:config[@"sccp"]];
        if(sccp)
        {
            SccpGttSelector *selector = [[SccpGttSelector alloc]initWithConfig:config];
            selector.logLevel = self.logLevel;
            selector.logFeed = self.logFeed;
            [sccp.gttSelectorRegistry addEntry:selector];
        }
    }
}


- (void)  handleMtp3Status:(UMHTTPRequest *)req
{
    NSMutableString *status = [[NSMutableString alloc]init];
    NSArray *keys = [_mtp3_dict allKeys];
    for(NSString *key in keys)
    {
        UMLayerMTP3 *mtp3 = _mtp3_dict[key];
        if(mtp3.ready)
        {
            [status appendFormat:@"MTP3-INSTANCE:%@:IS\n",mtp3.layerName];
        }
        else
        {
            [status appendFormat:@"MTP3-INSTANCE:%@:OOS\n",mtp3.layerName];

        }

        UMSynchronizedSortedDictionary *rt = mtp3.routingTable.objectValue;
        [status appendFormat: @"Routes:\n%@",rt.jsonString];
    }
    [req setResponsePlainText:status];
    return;
}

- (void)  handleDecodeMtp3:(UMHTTPRequest *)req
{
    NSString *standard = req.params[@"standard"];
    NSString *pdu = req.params[@"hexpdu"];
    if(pdu==NULL)
    {
        NSMutableString *s = [[NSMutableString alloc]init];
        [SS7GenericInstance webHeader:s title:@"MTP3 Decode"];
        [s appendString:@"<h2>MTP3 Decode</h2>\n"];

        [s appendString:@"<UL>\n"];
        [s appendString:@"<LI><a href=\"/\">&lt&lt-- main-menu</a></LI>\n"];
        [s appendString:@"<LI><a href=\"/decode/\">&lt-- Decode Menu</a></LI>\n"];
        [s appendString:@"</UL>\n"];

        [s appendFormat:@"<form>\r"];
        [s appendFormat:@"<select name=standard><option selected value=itu>itu</option><option value=ansi>ansi</option><option value=china>china</option><option value=japan>japan</option></select><br>\r"];
        [s appendFormat:@"MTP3 HEX PDU:<input type=text name=hexpdu size=80><br>\r"];
        [s appendFormat:@"<input type=submit>\r"];
        [s appendFormat:@"</form>\r"];
        [s appendFormat:@"</body>\r"];
        [s appendFormat:@"</html>\r"];
        [req setResponseHtmlString:s];
    }

   else
    {
        UMMTP3Variant variant = UMMTP3Variant_ITU;
        if([standard isEqualToStringCaseInsensitive:@"itu"])
        {
            variant = UMMTP3Variant_ITU;
        }
        else if([standard isEqualToStringCaseInsensitive:@"ansi"])
        {
            variant = UMMTP3Variant_ANSI;
        }
        else if([standard isEqualToStringCaseInsensitive:@"china"])
        {
            variant = UMMTP3Variant_China;
        }
        else if([standard isEqualToStringCaseInsensitive:@"japan"])
        {
            variant = UMMTP3Variant_Japan;
        }
        else
        {
            [req setResponsePlainText:@"Unknown standard"];
            return;
        }
        NSData *pduData = [pdu unhexedData];
        const unsigned char *bytes = pduData.bytes;
        int len = (int)pduData.length;
        int pos = 0;

        if(len<7)
        {
            [req setResponsePlainText:@"can not decode (packet too short)"];
            return;
        }

        int sio = bytes[pos++];
        int si; /* service indicator */
        int ni; /* network indicator */
        int mp=-1; /* message priority */
        switch (variant)
        {
            case UMMTP3Variant_Japan:
                mp = -1; /* this is in the MTP2 length indicator which we have no access to here */
                si  = (sio & 0x0F);
                ni  = (sio >> 6) & 0x03;
                break;
            case UMMTP3Variant_ANSI:
                mp = (sio >> 4 ) & 0x03;
                si  = (sio & 0x0F);
                ni  = (sio >> 6) & 0x03;
                break;
            default:
                mp = (sio >> 4 ) & 0x03;
                si  = (sio & 0x0F);
                ni  = (sio >> 6) & 0x03;
                break;
        }

        UMSynchronizedSortedDictionary *dict = [[UMSynchronizedSortedDictionary alloc]init];
        dict[@"sio"] = @(sio);
        dict[@"ni"] = @(ni);
        dict[@"si"] = @(si);
        UMMTP3Label *label = [[UMMTP3Label alloc]initWithBytes:bytes pos:&pos variant:variant];
        NSData *mtp3payload = [NSData dataWithBytes:&bytes[pos] length:(len-pos)];
        dict[@"opc"] = label.opc.description;
        dict[@"dpc"] = label.dpc.description;
        dict[@"sls"] = @(label.sls);
        if(mp>=0)
        {
            dict[@"mp"] = @(mp);
        }
        dict[@"mtp3-payload"] = mtp3payload;
        if(si==3)
        {
            NSArray *sccpLayerKeys = [_sccp_dict allKeys];
            if([sccpLayerKeys count]>=1)
            {
                NSString *key = sccpLayerKeys[0];
                UMLayerSCCP *sccp = _sccp_dict[key];
                UMSCCP_mtpTransfer *task = [[UMSCCP_mtpTransfer alloc]initForSccp:sccp
                                                     mtp3:NULL
                                                      opc:label.opc
                                                      dpc:label.dpc
                                                       si:3
                                                       ni:0
                                                     data:mtp3payload
                                                  options:@{ @"decode-only" : @YES }];
                [task main];
                dict[@"sccp"] = task.decodedJson;
            }
        }
        [req setResponseJsonObject:dict];
    }
    return;
}


- (void)  handleDecodeSccp:(UMHTTPRequest *)req
{

    NSString *pdu = req.params[@"hexpdu"];
    if(pdu==NULL)
    {
        NSMutableString *s = [[NSMutableString alloc]init];
        [SS7GenericInstance webHeader:s title:@"SCCP Decode"];

        [s appendString:@"<h2>SCCP Decode</h2>\n"];

        [s appendString:@"<UL>\n"];
        [s appendString:@"<LI><a href=\"/\">&lt&lt-- main-menu</a></LI>\n"];
        [s appendString:@"<LI><a href=\"/decode/\">&lt-- Decode Menu</a></LI>\n"];
        [s appendString:@"</UL>\n"];

        [s appendFormat:@"<form>\r"];
        [s appendFormat:@"SCCP HEX PDU:<input type=text name=hexpdu size=80><br>\r"];
        [s appendFormat:@"<input type=submit>\r"];
        [s appendFormat:@"</form>\r"];
        [s appendFormat:@"</body>\r"];
        [s appendFormat:@"</html>\r"];
        [req setResponseHtmlString:s];
    }
    else
    {

        NSArray *sccpLayerKeys = [_sccp_dict allKeys];
        if([sccpLayerKeys count]>=1)
        {
            NSString *key = sccpLayerKeys[0];
            UMLayerSCCP *sccp = _sccp_dict[key];

            UMSCCP_mtpTransfer *task;
            UMMTP3PointCode *pc = [[UMMTP3PointCode alloc]initWitPc:1 variant:UMMTP3Variant_ITU];
            task = [[UMSCCP_mtpTransfer alloc]initForSccp:sccp
                                                     mtp3:NULL
                                                      opc:pc
                                                      dpc:pc
                                                       si:3
                                                       ni:0
                                                     data:[pdu unhexedData]
                                                  options:@{ @"decode-only" : @YES }];
            [task main];

            NSString *json = [task.decodedJson jsonString];
            [req setResponsePlainText:json];
        }
        else
        {
            [req setResponseHtmlString:@"no sccp found"];
        }
    }
    return;
}

- (void)  handleDecodeTcap:(UMHTTPRequest *)req
{
    NSString *pdu = req.params[@"hexpdu"];
    NSString *ssn_string = req.params[@"ssn"];
    if(pdu==NULL)
    {
        NSMutableString *s = [[NSMutableString alloc]init];
        [SS7GenericInstance webHeader:s title:@"TCAP Decode"];

        [s appendString:@"<h2>TCAP Decode</h2>\n"];

        [s appendString:@"<UL>\n"];
        [s appendString:@"<LI><a href=\"/\">&lt&lt-- main-menu</a></LI>\n"];
        [s appendString:@"<LI><a href=\"/decode/\">&lt-- Decode Menu</a></LI>\n"];
        [s appendString:@"</UL>\n"];

        [s appendFormat:@"<form>\r"];
        [s appendFormat:@"TCAP HEX PDU:<input type=text name=hexpdu size=80><br>\r"];
        [s appendFormat:@"SSN:<input type=text name=ssn value=\"default\"><br>\r"];
        [s appendFormat:@"<input type=submit>\r"];
        [s appendFormat:@"</form>\r"];
        [s appendFormat:@"</body>\r"];
        [s appendFormat:@"</html>\r"];
        [req setResponseHtmlString:s];

    }
    else
    {
        SccpSubSystemNumber *ssn = [[SccpSubSystemNumber alloc]initWithName:ssn_string];
        NSArray *sccpLayerKeys = [_sccp_dict allKeys];
        if([sccpLayerKeys count]>=1)
        {
            NSString *key = sccpLayerKeys[0];
            UMLayerSCCP *sccp = _sccp_dict[key];
            SccpAddress *src = [[SccpAddress alloc]init];
            SccpAddress *dst = [[SccpAddress alloc]init];
            UMLayerTCAP *tcap = [sccp getUserForSubsystem:ssn number:dst];
            if(tcap==NULL)
            {
                tcap = [[UMLayerTCAP alloc]init];
            }
            UMTCAP_sccpNUnitdata *task;
            task = [[UMTCAP_sccpNUnitdata alloc]initForTcap:tcap
                                                       sccp:sccp
                                                   userData: [pdu unhexedData]
                                                    calling:src
                                                     called:dst
                                           qualityOfService:0
                                                    options:@{ @"decode-only" : @YES }];
            [task main];

            NSLog(@"Decoded %@",[task.asn1.objectValue jsonString]);
            UMASN1Object *asn1 = task.asn1;

            NSMutableString *s = [[NSMutableString alloc]init];
            [SS7GenericInstance webHeader:s title:@"TCAP Decode"];
            [s appendFormat:@"<form>\r"];
            [s appendFormat:@"TCAP HEX PDU:<input type=text name=hexpdu value=\"%@\" size=80><br>\r",pdu];
            [s appendFormat:@"SSN:<input type=text name=ssn value=\"default\"><br>\r"];
            [s appendFormat:@"<input type=submit>\r"];
            [s appendFormat:@"</form>\r"];
            [s appendFormat:@"<pre>%@ = %@</pre>\r",asn1.objectName,[asn1.objectValue jsonString]];
            [s appendFormat:@"</pre>\r"];
            [s appendFormat:@"</body>\r"];
            [s appendFormat:@"</html>\r"];
            [req setResponseHtmlString:s];
        }
        else
        {
            [req setResponseHtmlString:@"no sccp found"];
        }
    }
    return;
}

- (void)  handleDecodeTcap2:(UMHTTPRequest *)req
{

    NSString *pdu = req.params[@"hexpdu"];
    NSString *ssn_string = req.params[@"ssn"];
    if(pdu==NULL)
    {
        NSMutableString *s = [[NSMutableString alloc]init];
        [SS7GenericInstance webHeader:s title:@"TCAP2 Decode"];
        [s appendFormat:@"<form>\r"];
        [s appendFormat:@"TCAP HEX PDU:<input type=text name=hexpdu size=80><br>\r"];
        [s appendFormat:@"SSN:<input type=text name=ssn value=\"default\"><br>\r"];
        [s appendFormat:@"<input type=submit>\r"];
        [s appendFormat:@"</form>\r"];
        [s appendFormat:@"</body>\r"];
        [s appendFormat:@"</html>\r"];
        [req setResponseHtmlString:s];

    }
    else
    {
        SccpSubSystemNumber *ssn = [[SccpSubSystemNumber alloc]initWithName:ssn_string];
        NSArray *sccpLayerKeys = [_sccp_dict allKeys];
        if([sccpLayerKeys count]>=1)
        {
            NSString *key = sccpLayerKeys[0];
            UMLayerSCCP *sccp = _sccp_dict[key];
            SccpAddress *src = [[SccpAddress alloc]init];
            SccpAddress *dst = [[SccpAddress alloc]init];
            UMLayerTCAP *tcap = [sccp getUserForSubsystem:ssn number:dst];

            UMTCAP_sccpNUnitdata *task;
            task = [[UMTCAP_sccpNUnitdata alloc]initForTcap:tcap
                                                       sccp:sccp
                                                   userData: [pdu unhexedData]
                                                    calling:src
                                                     called:dst
                                           qualityOfService:0
                                                    options:@{ @"decode-only" : @YES }];
            [task main];

            NSLog(@"Decoded %@",task.asn1.objectValue);
            UMASN1Object *asn1 = task.asn1;

            NSMutableString *s = [[NSMutableString alloc]init];
            [SS7GenericInstance webHeader:s title:@"TCAP2 Decode"];
            [s appendFormat:@"<form>\r"];
            [s appendFormat:@"TCAP HEX PDU:<input type=text name=hexpdu value=\"%@\" size=80><br>\r",pdu];
            [s appendFormat:@"SSN:<input type=text name=ssn value=\"default\"><br>\r"];
            [s appendFormat:@"<input type=submit>\r"];
            [s appendFormat:@"</form>\r"];
            [s appendFormat:@"<pre>%@ = %@</pre>\r",asn1.objectName,asn1.description];
            [s appendFormat:@"</pre>\r"];
            [s appendFormat:@"</body>\r"];
            [s appendFormat:@"</html>\r"];
            [req setResponseHtmlString:s];
        }
        else
        {
            [req setResponseHtmlString:@"no sccp found"];
        }
    }
    return;
}

- (void)  handleDecode:(UMHTTPRequest *)req
{
    NSMutableString *s = [[NSMutableString alloc]init];
    [s appendString:@"<html>\n"];
    [s appendString:@"<header>\n"];
    [s appendString:@"    <link rel=\"stylesheet\" href=\"/css/style.css\" type=\"text/css\">\n"];
    [s appendFormat:@"    <title>Decode Menu</title>\n"];
    [s appendString:@"</header>\n"];
    [s appendString:@"<body>\n"];

    [s appendString:@"<h2>Decode Menu</h2>\n"];
    [s appendString:@"<UL>\n"];
    [s appendString:@"<LI><a href=\"/\">&lt-- main-menu</a></LI>\n"];
    [s appendString:@"<LI><a href=\"/decode/mtp3\">Decode MTP3</a></LI>\n"];
    [s appendString:@"<LI><a href=\"/decode/sccp\">Decode SCCP</a></LI>\n"];
    [s appendString:@"<LI><a href=\"/decode/tcap\">Decode TCAP</a></LI>\n"];
    [s appendString:@"<LI><a href=\"/decode/asn1\">Decode ASN1</a></LI>\n"];
    [s appendString:@"<LI><a href=\"/decode/sms\">Decode SMS</a></LI>\n"];
    [s appendString:@"</UL>\n"];
    [s appendString:@"</body>\n"];
    [s appendString:@"</html>\n"];
    [req setResponseHtmlString:s];
}

- (void)  handleDecodeSms:(UMHTTPRequest *)req
{
    NSString *pdu = req.params[@"hexpdu"];
    if(pdu==NULL)
    {
        NSMutableString *s = [[NSMutableString alloc]init];
        [SS7GenericInstance webHeader:s title:@"SMS PDU Decode"];

        [s appendString:@"<h2>SMS Decode</h2>\n"];

        [s appendString:@"<UL>\n"];
        [s appendString:@"<LI><a href=\"/\">&lt&lt-- main-menu</a></LI>\n"];
        [s appendString:@"<LI><a href=\"/decode/\">&lt-- Decode Menu</a></LI>\n"];
        [s appendString:@"</UL>\n"];

        [s appendFormat:@"<form>\r"];
        [s appendFormat:@"SMS HEX PDU:<input type=text name=hexpdu size=80><br>\r"];
        [s appendFormat:@"<input type=submit>\r"];
        [s appendFormat:@"</form>\r"];
        [s appendFormat:@"</body>\r"];
        [s appendFormat:@"</html>\r"];
        [req setResponseHtmlString:s];
    }
    else
    {
        NSData *data = [pdu unhexedData];
        UMSMS *sms = [[UMSMS alloc]init];
        NSString *str;
        [sms decodePdu:data context:NULL];
        UMSynchronizedSortedDictionary *dict = sms.objectValue;
        str = [dict jsonString];

        NSMutableString *s = [[NSMutableString alloc]init];
        [SS7GenericInstance webHeader:s title:@"SMS Decode"];
        [s appendFormat:@"<form>\r"];
        [s appendFormat:@"SMS HEX PDU:<input type=text name=hexpdu value=\"%@\" size=80><br>\r",pdu];
        [s appendFormat:@"<input type=submit>\r"];
        [s appendFormat:@"</form>\r"];
        [s appendFormat:@"<pre>%@</pre>\r",str];
        [s appendFormat:@"</body>\r"];
        [s appendFormat:@"</html>\r"];
        [req setResponseHtmlString:s];
    }
    return;
}


- (void)  handleSmsDecode:(UMHTTPRequest *)req
{

    NSString *pdu = req.params[@"hexpdu"];

    NSMutableString *s = [[NSMutableString alloc]init];
    [SS7GenericInstance webHeader:s title:@"SMS Decode"];

    [s appendString:@"<h2>SMS Decode</h2>\n"];

    [s appendString:@"<UL>\n"];
    [s appendString:@"<LI><a href=\"/\">&lt&lt-- main-menu</a></LI>\n"];
    [s appendString:@"<LI><a href=\"/decode/\">&lt-- Decode Menu</a></LI>\n"];
    [s appendString:@"</UL>\n"];

    [s appendFormat:@"<form><pre>\r"];
    [s appendFormat:@"SMS HEX PDU:<input type=text name=hexpdu size=80><br>\r"];
    [s appendFormat:@"<input type=submit>\r"];
    [s appendFormat:@"</pre></form><p>\r"];

    if(pdu)
    {
        UMSMS *sms = [[UMSMS alloc]init];
        [sms decodePdu:[pdu unhexedData] context:NULL];
        UMSynchronizedSortedDictionary *d = [sms objectValue];
        [s appendFormat:@"<pre>%@</pre>",[d jsonString]];
    }
    [s appendFormat:@"</body>\r"];
    [s appendFormat:@"</html>\r"];
    [req setResponseHtmlString:s];
    return;
}
- (void)  handleDecodeAsn1:(UMHTTPRequest *)req
{
    NSString *pdu = req.params[@"hexpdu"];
    if(pdu==NULL)
    {
        NSMutableString *s = [[NSMutableString alloc]init];
        [SS7GenericInstance webHeader:s title:@"ASN1 Decode"];

        [s appendString:@"<h2>ASN1 Decode</h2>\n"];

        [s appendString:@"<UL>\n"];
        [s appendString:@"<LI><a href=\"/\">&lt&lt-- main-menu</a></LI>\n"];
        [s appendString:@"<LI><a href=\"/decode/\">&lt-- Decode Menu</a></LI>\n"];
        [s appendString:@"</UL>\n"];

        [s appendFormat:@"<form>\r"];
        [s appendFormat:@"ASN1 HEX PDU:<input type=text name=hexpdu size=80><br>\r"];
        [s appendFormat:@"<input type=submit>\r"];
        [s appendFormat:@"</form>\r"];
        [s appendFormat:@"</body>\r"];
        [s appendFormat:@"</html>\r"];
        [req setResponseHtmlString:s];
    }
    else
    {
        NSData *data = [pdu unhexedData];
        NSUInteger pos = 0;
        UMASN1Object *asn1 = [[UMASN1Object alloc]initWithBerData:data atPosition:&pos context:NULL];

        NSMutableString *s = [[NSMutableString alloc]init];
        [SS7GenericInstance webHeader:s title:@"ASN1 Decode"];
        [s appendFormat:@"<form>\r"];
        [s appendFormat:@"ASN1 HEX PDU:<input type=text name=hexpdu value=\"%@\" size=80><br>\r",pdu];
        [s appendFormat:@"<input type=submit>\r"];
        [s appendFormat:@"</form>\r"];
        [s appendFormat:@"<pre>%@ = %@</pre>\r",asn1.objectName,[asn1.objectValue jsonString]];
        [s appendFormat:@"</body>\r"];
        [s appendFormat:@"</html>\r"];
        [req setResponseHtmlString:s];
    }
    return;
}

#pragma mark -
#pragma mark Staging areas

- (void)createSS7FilterStagingArea:(NSDictionary *)dict
{
    NSString *name = dict[@"name"];
    NSString *filename = [UMSS7ConfigObject filterName:name];
    filename = filename.urldecode;
    NSString *filepath = [NSString stringWithFormat:@"%@%@",_stagingAreaPath,filename];
    UMSS7ConfigSS7FilterStagingArea *st = [[UMSS7ConfigSS7FilterStagingArea alloc]initWithPath:filepath];
    [st setConfig:dict];

    if(st==NULL)
    {
        @throw([NSException exceptionWithName:@"CREATE-STAGING-ERROR"
                                       reason:@"can not allocate staging area"
                                     userInfo:NULL]);
    }
    else
    {
        [st setDirty:YES];
        _ss7FilterStagingAreas_dict[filename] = st;
    }
}

- (void)updateSS7FilterStagingArea:(NSDictionary *)dict
{
    NSString *name = dict[@"name"];
    UMSS7ConfigSS7FilterStagingArea *sa = _ss7FilterStagingAreas_dict[name];
    if(sa==NULL)
    {
        @throw([NSException exceptionWithName:@"UPDATE-STAGING-ERROR"
                                       reason:@"staging area doesn't exist"
                                     userInfo:NULL]);
    }
    else
    {
        [sa setConfig:dict];
    }

}

- (void)selectSS7FilterStagingArea:(NSString *)name forSession:(UMSS7ApiSession *)session
{
    session.currentStorageAreaName = name;
}

- (void)deleteSS7FilterStagingArea:(NSString *)name
{
    // Remove from file-system
    NSString *filename = [UMSS7ConfigObject filterName:name];
    NSString *filepath = [NSString stringWithFormat:@"%@%@",_stagingAreaPath,filename];
    UMSS7ConfigSS7FilterStagingArea *sa = _ss7FilterStagingAreas_dict[name];
    [sa deleteConfig:filepath];

    // Remove from memory
    [_ss7FilterStagingAreas_dict removeObjectForKey:name];
}

- (UMSS7ConfigSS7FilterStagingArea *)getStagingAreaForSession:(UMSS7ApiSession *)session
{
    NSString *name = session.currentStorageAreaName;
    if(name==NULL)
    {
        return NULL;
    }
    UMSS7ConfigSS7FilterStagingArea *stagingArea = _ss7FilterStagingAreas_dict[session.currentStorageAreaName];
    return stagingArea;
}

- (BOOL)makeStagingAreaCurrent:(NSString *)name  /*returns YES on success */
{
    UMSS7ConfigSS7FilterStagingArea *stagingArea = _ss7FilterStagingAreas_dict[name];
    if(stagingArea == NULL)
    {
        return NO;
    }
    _activeStagingArea.isActive = NO;
    _activeStagingArea = stagingArea;
    _activeStagingArea.isActive= YES;

    UMSynchronizedDictionary *rulesets = _activeStagingArea.filter_rule_set_dict;

    NSArray *keys = [rulesets allKeys];
    for(NSString *key in keys)
    {
        UMSS7ConfigSS7FilterRuleSet *ruleset = rulesets[key];
        UMSS7FilterRuleSet *rs = [[UMSS7FilterRuleSet alloc]initWithConfig:ruleset appDelegate:self];
        if(rs.name.length > 0)
        {
            _active_ruleset_dict[rs.name] = rs;
        }
    }

    UMSynchronizedDictionary *actionlists = _activeStagingArea.filter_action_list_dict;

    keys = [actionlists allKeys];
    for(NSString *key in keys)
    {
        UMSS7ConfigSS7FilterActionList *actionList = actionlists[key];
        UMSS7FilterActionList *al = [[UMSS7FilterActionList alloc]initWithConfig:actionList appDelegate:self];
        if(al.name.length > 0)
        {
            _active_action_list_dict[al.name] = al;
        }
    }

    /* we could here link all rulesets->rule to actionlist->actions and to engines
     however we prefer to do this lazy on first attempted use */

    NSString *origin = [NSString stringWithFormat:@"%@/%@",_stagingAreaPath,_activeStagingArea.name.urlencode];
    NSString *symlinked = [NSString stringWithFormat:@"%@/current",_stagingAreaPath];
    symlink(origin.UTF8String, symlinked.UTF8String);
    return YES;
}

- (NSArray<NSString *> *)getSS7FilterStagingAreaNames
{
    return [_ss7FilterStagingAreas_dict allKeys];
}

- (void)renameSS7FilterStagingArea:(NSString *)oldname newName:(NSString *)newname
{
    NSArray<NSString *> *names = [self getSS7FilterStagingAreaNames];
    for(NSString *name in names)
    {
        UMSS7ConfigSS7FilterStagingArea *stagingArea = _ss7FilterStagingAreas_dict[name];
        if(name == oldname)
        {
            stagingArea.name = newname;
            break;
        }
    }
}

- (void)copySS7FilterStagingArea:(NSString *)oldname toNewName:(NSString *)newname
{
    if([newname isEqualToString:oldname])
    {
        return;
    }
    UMSS7ConfigSS7FilterStagingArea *oldStagingArea = _ss7FilterStagingAreas_dict[oldname];

    NSString *filename = newname.urlencode;
    NSString *filepath = [NSString stringWithFormat:@"%@/%@",_stagingAreaPath,filename];
    UMSS7ConfigSS7FilterStagingArea *st = [[UMSS7ConfigSS7FilterStagingArea alloc]initWithPath:filepath];
    if(oldStagingArea)
    {
        [st copyFromStagingArea:oldStagingArea];
    }
    _ss7FilterStagingAreas_dict[newname] = st;
}



- (void)loadSS7StagingAreasFromPath:(NSString *)path
{
    NSFileManager * fm = [NSFileManager defaultManager];
    NSError *e = NULL;

    NSArray<NSString *> *a = (NSArray *)[fm contentsOfDirectoryAtPath:path  error:&e];
    if(e)
    {
        NSLog(@"Error while parsing directory %@\n%@",path,e);
    }
    else
    {
        _ss7FilterStagingAreas_dict = [[UMSynchronizedDictionary alloc]init];
        _activeStagingArea = NULL;

        for(NSString *filename in a)
        {
            NSString *fullPath = [NSString stringWithFormat:@"%@/%@",path, filename];
            char resolved[PATH_MAX];
            char *resolvedPath = realpath(fullPath.UTF8String, resolved);
            if(resolvedPath)
            {
                fullPath = @(resolvedPath);
            }

            UMSS7ConfigSS7FilterStagingArea *area = [[UMSS7ConfigSS7FilterStagingArea alloc]initWithPath:fullPath];
            [area loadFromFile];
            NSString *displayName =area.name.urldecode;
            _ss7FilterStagingAreas_dict[displayName] = area;

            if([filename isEqualToString:@"current"])
            {
                [self makeStagingAreaCurrent:area.name];
            }
        }
    }
}

#pragma mark -
#pragma mark Engines

- (void)addWithConfigSS7FilterEngine:(NSDictionary *)config /* can throw exceptions */
{
    NSMutableDictionary *open_dict = [[NSMutableDictionary alloc]init];
    open_dict[@"app-delegate"] = self;
    open_dict[@"license-directory"] = UMLicense_loadLicensesFromPath(self.defaultLicensePath, NO);
#ifdef HAS_ULIBLICENSE
    open_dict[@"license-directory"] = _globalLicenseDirectory;
#endif


    NSString *filename = config[@"file"];
    NSString *filepath = [NSString stringWithFormat:@"%@/%@",_filterEnginesPath,filename];
    UMPluginHandler *ph = [[UMPluginHandler alloc]initWithFile:filepath];
    if(ph==NULL)
    {
        @throw([NSException exceptionWithName:@"PLUGIN-ERROR"
                                       reason:@"can not allocate plugin handler"
                                     userInfo:NULL]);
    }

    int r = [ph openWithDictionary:open_dict];
    if(r<0)
    {
        [ph close];
        @throw([NSException exceptionWithName:@"LOADING-ERROR"
                                       reason:ph.error
                                     userInfo:NULL]);
    }

    NSDictionary *info = ph.info;
    NSString *type = info[@"type"];
    if([type isEqualToString:@"ss7-filter"])
    {
        _ss7FilterEngines[ph.name] = ph;
    }
    else
    {
        [ph close];
        NSString *s = [NSString stringWithFormat:@"was expecting plugin-type 'ss7-filter but got plugin-type '%@'",type];
        @throw([NSException exceptionWithName:@"WRONG-TYPE"
                                       reason:s
                                     userInfo:NULL]);

    }
}

- (void)loadSS7FilterEnginesFromDirectory:(NSString *)path
{
    NSMutableDictionary *open_dict = [[NSMutableDictionary alloc]init];
    open_dict[@"app-delegate"] = self;
    open_dict[@"license-directory"] = UMLicense_loadLicensesFromPath(self.defaultLicensePath, NO);
#ifdef HAS_ULIBLICENSE
    open_dict[@"license-directory"] = _globalLicenseDirectory;
#endif

    [self.logFeed infoText:[NSString stringWithFormat:@"searching for filter engines in %@",path]];

    NSFileManager * fm = [NSFileManager defaultManager];
    NSError *e = NULL;
    NSArray<NSString *> *a = [fm contentsOfDirectoryAtPath:path  error:&e];
    if(e)
    {
        NSLog(@"Error while parsing directory %@\n%@",path,e);
    }
    for(NSString *filename in a)
    {
        NSString *filepath = [NSString stringWithFormat:@"%@%@",path,filename];
        [self.logFeed debugText:[NSString stringWithFormat:@"loading filter %@",filepath]];
        if([filepath hasSuffix:@"~"]) /* we skip old backup files */
        {
            continue;
        }
        UMPluginHandler *ph = [[UMPluginHandler alloc]initWithFile:filepath];

        if(ph)
        {
            int r = [ph openWithDictionary:open_dict];
            if(r<0)
            {
                [self.logFeed majorErrorText:[NSString stringWithFormat:@"loading filter '%@' failed with error %@",filepath,ph.error]];
                [ph close];
            }
            else
            {
                NSDictionary *info = ph.info;
                NSLog(@"plugin info: %@",ph.info);
                NSString *type = info[@"type"];
                if([type isEqualToString:@"ss7-filter"])
                {
                    _ss7FilterEngines[ph.name] = ph;
                }
                else
                {
                    [self.logFeed minorErrorText:[NSString stringWithFormat:@"filter %@ is of type %@. was excpecting ss7-filter. Ignoring",filepath,type]];
                }
            }
        }
        else
        {
            [ph close];
        }
    }
}

- (NSArray *)getSS7FilterEngineNames
{
    return [_ss7FilterEngines allKeys];
}

- (void)loadTracefilesFromPath:(NSString *)path
{
    NSFileManager * fm = [NSFileManager defaultManager];
    NSError *e = NULL;
    NSArray<NSString *> *a = [fm contentsOfDirectoryAtPath:path  error:&e];
    if(e)
    {
        NSLog(@"Error while parsing directory %@\n%@",path,e);
    }
    for(NSString *filename in a)
    {
        if( [[filename pathExtension]isEqualToString:@"conf"])
        {
            NSString *fullFilename = [NSString stringWithFormat:@"%@/%@",path,filename];
            UMConfig* cfg = [[UMConfig alloc]initWithFileName:fullFilename];
            [cfg allowSingleGroup:[UMSS7ConfigSS7FilterTraceFile type]];
            [cfg read];
            NSDictionary *config = [cfg getSingleGroup:[UMSS7ConfigSS7FilterTraceFile type]];
            NSMutableDictionary *config2 = [config mutableCopy];
            config2[@"name"] = [filename stringByDeletingPathExtension];
            UMSS7ConfigSS7FilterTraceFile *c = [[UMSS7ConfigSS7FilterTraceFile alloc]initWithConfig:config2];
            [self tracefile_add:c];
        }
    }
}

- (UMPluginHandler *)getSS7FilterEngineHandler:(NSString *)name
{
    return _ss7FilterEngines[name];
}



#pragma mark -
#pragma mark namedlists

- (UMSynchronizedArray *)namedlist_lists
{
    UMSynchronizedArray *list = [[UMSynchronizedArray alloc]initWithArray:[_namedLists allKeys]];
    return list;
}


- (void)namedlist_add:(NSString *)listName
                value:(NSString *)value
{
    if((value) && (listName))
    {
        [_namedListLock lock];
        UMNamedList *list = _namedLists[listName];
        if(list == NULL)
        {
            list = [[UMNamedList alloc]initWithDirectory:_namedListsDirectory name:listName];
            _namedLists[listName] = list;
        }
        [list addEntry:value];
        [list setDirty:YES];
        [_namedListLock unlock];
    }
}

- (void)namedlist_remove:(NSString *)listName
                   value:(NSString *)value
{
    if((value) && (listName))
    {
        [_namedListLock lock];
        UMNamedList *list = _namedLists[listName];
        if(list)
        {
            [list removeEntry:value];
            [list setDirty:YES];
        }
        [_namedListLock unlock];
    }
}

- (BOOL)namedlist_contains:(NSString *)listName
                     value:(NSString *)value
{
    BOOL returnValue = NO;
    if((value) && (listName))
    {
        [_namedListLock lock];
        UMNamedList *list = _namedLists[listName];
        if(list)
        {
            returnValue =  [list containsEntry:value];
        }
        [_namedListLock unlock];
    }
    return returnValue;
}


/* note: this does NOT remove existing entries. only override lists
 this is done so lists can be loaded from multiple path by calling it multiple times */

- (void)loadNamedListsFromPath:(NSString *)directory
{
    [_namedListLock lock];
    NSFileManager *mgr = [NSFileManager defaultManager];
    for (NSString *filePath in [mgr enumeratorAtPath:directory])
    {
        NSString *name = filePath.urldecode; /* the filename is an url encoded version of the name */
        UMNamedList *nl = [[UMNamedList alloc]initWithDirectory:directory name:name];
        if(nl)
        {
            _namedLists[name] = nl;
        }
    }
    [_namedListLock unlock];

}


- (NSArray *)namedlist_get:(NSString *)listName
{
    if(listName == NULL)
    {
        return @[];
    }
    [_namedListLock lock];
    UMNamedList *nl = _namedLists[listName];
    [_namedListLock unlock];
    return [nl allEntries];
}

- (void)namedlist_flushAll
{
    NSArray *allListNames = [_namedLists allKeys];
    for(NSString *listName in allListNames)
    {
        UMNamedList *nl = _namedLists[listName];
        [nl flush];
    }
}

#pragma mark -
#pragma mark logfile

- (UMSynchronizedArray *)tracefile_list
{
    NSArray *arr = [_ss7TraceFiles allKeys];
    UMSynchronizedArray *sarr = [[UMSynchronizedArray alloc]initWithArray:arr];
    return sarr;
}

- (void)tracefile_remove:(NSString *)name
{
    UMSS7TraceFile *tf = _ss7TraceFiles[name];
    if(tf)
    {
        [tf close];
        [tf deleteConfigOnDisk];
    }
    [_ss7TraceFiles removeObjectForKey:name];
}

- (void)tracefile_enable:(NSString *)name enable:(BOOL)enable
{
    UMSS7TraceFile *tf = _ss7TraceFiles[name];
    if(tf)
    {
        if(enable)
        {
            [tf enable];
        }
        else
        {
            [tf disable];
        }
        [tf writeConfigToDisk];
    }
}

- (UMSS7ConfigSS7FilterTraceFile *)tracefile_get:(NSString *)name
{
    UMSS7TraceFile *tf = _ss7TraceFiles[name];
    return tf.config;
}

- (void)tracefile_action:(NSString *)name action:(NSString *)action
{
    UMSS7TraceFile *tf = _ss7TraceFiles[name];
    if(tf)
    {
        [tf action:action];
    }
}

- (void)tracefile_add:(UMSS7ConfigSS7FilterTraceFile *)conf
{
    UMSS7TraceFile *tf = [[UMSS7TraceFile alloc]initWithSS7Config:conf defaultPath:_ss7TraceFilesDirectory];
    if(tf)
    {
        _ss7TraceFiles[conf.name] = tf;
        [tf writeConfigToDisk];
        [tf open];
    }
}


#pragma mark -
#pragma mark Statistics

- (NSArray *)getStatisticsNames
{
    return [_statistics_dict allKeys];
}


- (void)statistics_add:(NSString *)name params:(NSDictionary *)dict
{
    UMStatistic *stat = _statistics_dict[name];
    if(stat==NULL)
    {
        stat  =  [[UMStatistic alloc]initWithPath:_statisticsPath name:name];
    }
    _statistics_dict[name] = stat;
}

- (void)statistics_modify:(NSString *)name params:(NSDictionary *)dict
{
    UMStatistic *stat = _statistics_dict[name];
    [stat setValues:dict];
}

- (void)statistics_remove:(NSString *)name
{
}

- (void)loadStatisticsFromPath:(NSString *)directory
{
}

- (void)statistics_flushAll
{
    NSArray *keys = [_statistics_dict allKeys];
    for(NSString *key in keys)
    {
        UMStatistic *stat = _statistics_dict[key];
        [stat flush];
    }
}

- (UMStatistic *)statistics_get:(NSString *)name
{
    return _statistics_dict[name];
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
    NSArray *keys = [_ss7FilterStagingAreas_dict allKeys];
    for(NSString *key in keys)
    {
        UMSS7ConfigSS7FilterStagingArea *staging = _ss7FilterStagingAreas_dict[key];
        [staging flushIfDirty];
    }

    keys = [_statistics_dict allKeys];
    for(NSString *key in keys)
    {
        UMStatistic *stat = _statistics_dict[key];
        [stat flushIfDirty];
    }

    keys = [_namedLists allKeys];
    for(NSString *k in keys)
    {
        UMNamedList *nl = _namedLists[k];
        [nl flush];
    }
}


- (void)filterActivate
{
    _filteringActive=YES;
}

- (void)filterDeactivate
{
    _filteringActive=NO;
}

- (BOOL)isFilterActive
{
    return _filteringActive;
}


- (NSString *)filterName
{
    return @"estp-filter";
}

- (NSString *)filterDescription
{
    return @"estp-filter";
}


- (UMSCCP_FilterResult)filterPacket:(UMSCCP_Packet *)packet
                       usingRuleset:(NSString *)ruleset
{
    if(_activeStagingArea==NULL)
    {
        if(packet.logLevel <= UMLOG_DEBUG)
        {
            [packet.logFeed debugText:@"can not find activeStagingArea"];
        }
        return UMSCCP_FILTER_RESULT_UNMODIFIED;

    }
    UMSS7FilterRuleSet *rs = _active_ruleset_dict[ruleset];

    if(rs == NULL)
    {
        if(packet.logLevel <= UMLOG_DEBUG)
        {
            NSString *s = [NSString stringWithFormat:@"can not find ss7-filter-ruleset '%@'",ruleset];
            [packet.logFeed debugText:s];
        }
        return UMSCCP_FILTER_RESULT_UNMODIFIED;
    }
    if(rs.filterStatus == UMSS7FilterStatus_off)
    {
        if(packet.logLevel <= UMLOG_DEBUG)
        {
            NSString *s = [NSString stringWithFormat:@"filter status is off on ruleset '%@'",ruleset];
            [_logFeed debugText:s];
        }
        return UMSCCP_FILTER_RESULT_UNMODIFIED;
    }

    if(packet.logLevel<=UMLOG_DEBUG)
    {
        [packet.logFeed debugText:[NSString stringWithFormat:@"calling filterPacket: on ruleset %@",rs.name]];
    }
    UMSCCP_FilterResult r =  [rs filterPacket:packet];
    if(packet.logLevel<=UMLOG_DEBUG)
    {
        [self.logFeed debugText:[NSString stringWithFormat:@" filterPacket returned result 0x%2X",r]];
    }
    if(rs.filterStatus == UMSS7FilterStatus_on)
    {
        return r;
    }
    if((r == UMSCCP_FILTER_RESULT_DROP) || (r==UMSCCP_FILTER_RESULT_STATUS))
    {
        return UMSCCP_FILTER_RESULT_MONITOR;
    }
    if(_logLevel<= UMLOG_DEBUG)
    {
        if(r ==UMSCCP_FILTER_RESULT_UNMODIFIED)
        {
            [self.logFeed debugText:@"UMSCCP_FILTER_RESULT_UNMODIFIED"];
        }
        if(r & UMSCCP_FILTER_RESULT_MODIFIED)
        {
            [self.logFeed debugText:@"UMSCCP_FILTER_RESULT_MODIFIED"];
        }
        if(r & UMSCCP_FILTER_RESULT_MONITOR)
        {
            [self.logFeed debugText:@"UMSCCP_FILTER_RESULT_MONITOR"];
        }
        if(r & UMSCCP_FILTER_RESULT_DROP)
        {
            [self.logFeed debugText:@"UMSCCP_FILTER_RESULT_DROP"];
        }
        if(r & UMSCCP_FILTER_RESULT_STATUS)
        {
            [self.logFeed debugText:@"UMSCCP_FILTER_RESULT_STATUS"];
        }
        if(r & UMSCCP_FILTER_RESULT_CAN_NOT_DECODE)
        {
            [self.logFeed debugText:@"UMSCCP_FILTER_RESULT_CAN_NOT_DECODE"];
        }
        if(r & UMSCCP_FILTER_RESULT_ADD_TO_TRACE1)
        {
            [self.logFeed debugText:@"UMSCCP_FILTER_RESULT_ADD_TO_TRACE1"];
        }
        if(r & UMSCCP_FILTER_RESULT_ADD_TO_TRACE2)
        {
            [self.logFeed debugText:@"UMSCCP_FILTER_RESULT_ADD_TO_TRACE2"];
        }
        if(r & UMSCCP_FILTER_RESULT_ADD_TO_TRACE3)
        {
            [self.logFeed debugText:@"UMSCCP_FILTER_RESULT_ADD_TO_TRACE3"];
        }
        if(r & UMSCCP_FILTER_RESULT_ADD_TO_TRACEFILE_CAN_NOT_DECODE)
        {
            [self.logFeed debugText:@"UMSCCP_FILTER_RESULT_ADD_TO_TRACEFILE_CAN_NOT_DECODE"];
        }
    }
    return r;
}



- (UMSCCP_FilterResult)filterInbound:(UMSCCP_Packet *)packet
{
    if(_logLevel<= UMLOG_DEBUG)
    {
        [packet.logFeed infoText:@"filterInbound called"];
    }
    if(_filteringActive==NO)
    {
        [packet.logFeed infoText:@"filtering is not active. Skipping"];
        return UMSCCP_FILTER_RESULT_UNMODIFIED;
    }
    NSArray<NSString *> *ruleSets = _incomingLinksetFilters[packet.incomingLinkset];
    if(ruleSets==NULL)
    {
        if(_logLevel<= UMLOG_DEBUG)
        {
            [packet.logFeed debugText:[NSString stringWithFormat:@" no ruleset found for linkset '%@'. Trying 'all' now.",packet.incomingLinkset]];
        }
        ruleSets = _incomingLinksetFilters[@"all"];
        if(ruleSets==NULL)
        {
            if(_logLevel<= UMLOG_DEBUG)
            {
                [packet.logFeed debugText:@" no ruleset found for linkset 'all'. returing UMSCCP_FILTER_RESULT_UNMODIFIED"];
            }
            return UMSCCP_FILTER_RESULT_UNMODIFIED;
        }
    }

    UMSCCP_FilterResult result = UMSCCP_FILTER_RESULT_UNMODIFIED;
    for(NSString *ruleSet in ruleSets)
    {
        if(_logLevel<= UMLOG_DEBUG)
        {
            [packet.logFeed debugText:[NSString stringWithFormat:@" checking ruleset %@",ruleSet]];
        }
        result = [self filterPacket:packet usingRuleset:ruleSet];

        if(result & UMSCCP_FILTER_RESULT_DROP)
        {
            break;
        }
        if(result & UMSCCP_FILTER_RESULT_STATUS)
        {
            break;
        }
    }
    if(_logLevel<= UMLOG_DEBUG)
    {
        [self.logFeed infoText:@"filterInbound returning"];
    }
    return result;
}

- (UMSCCP_FilterResult)filterOutbound:(UMSCCP_Packet *)packet
{
    if(_logLevel<= UMLOG_DEBUG)
    {
        [self.logFeed infoText:@"filterOutbound called"];
    }
    if(_filteringActive==NO)
    {
        [self.logFeed infoText:@"filtering is not active. Skipping"];
        return UMSCCP_FILTER_RESULT_UNMODIFIED;
    }
    NSArray<NSString *> *ruleSets = _outgoingLinksetFilters[packet.incomingLinkset];
    if(ruleSets==NULL)
    {
        if(_logLevel<= UMLOG_DEBUG)
        {
            [self.logFeed debugText:[NSString stringWithFormat:@" no ruleset found for linkset '%@'. Trying 'all' now.",packet.incomingLinkset]];
        }
        ruleSets = _outgoingLinksetFilters[@"all"];
        if(ruleSets==NULL)
        {
            if(_logLevel<= UMLOG_DEBUG)
            {
                [self.logFeed debugText:@" no ruleset found for linkset 'all'. returing UMSCCP_FILTER_RESULT_UNMODIFIED"];
            }
            return UMSCCP_FILTER_RESULT_UNMODIFIED;
        }
    }

    UMSCCP_FilterResult result = UMSCCP_FILTER_RESULT_UNMODIFIED;
    for(NSString *ruleSet in ruleSets)
    {
        result = [self filterPacket:packet usingRuleset:ruleSet];
        if(result & UMSCCP_FILTER_RESULT_DROP)
        {
            break;
        }
        if(result & UMSCCP_FILTER_RESULT_STATUS)
        {
            break;
        }
    }
    if(_logLevel<= UMLOG_DEBUG)
    {
        [self.logFeed infoText:@"filterOutbound returning"];
    }
    return result;
}

- (UMSCCP_FilterResult)filterToLocalSubsystem:(UMSCCP_Packet *)packet
{
    if(_logLevel<= UMLOG_DEBUG)
    {
        [self.logFeed infoText:@"filterToLocalSubsystem called"];
    }
    if(_filteringActive==NO)
    {
        [self.logFeed infoText:@"filtering is not active. Skipping"];
        return UMSCCP_FILTER_RESULT_UNMODIFIED;
    }

    NSArray<NSString *> *ruleSets = _incomingLocalSubsystemFilters[packet.incomingLinkset];
    if(ruleSets==NULL)
    {
        if(_logLevel<= UMLOG_DEBUG)
        {
            [self.logFeed debugText:[NSString stringWithFormat:@" no ruleset found for linkset '%@'. Trying 'all' now.",packet.incomingLinkset]];
        }
        ruleSets = _incomingLocalSubsystemFilters[@"all"];
        if(ruleSets==NULL)
        {
            if(_logLevel<= UMLOG_DEBUG)
            {
                [self.logFeed debugText:@" no ruleset found for linkset 'all'. returing UMSCCP_FILTER_RESULT_UNMODIFIED"];
            }
            return UMSCCP_FILTER_RESULT_UNMODIFIED;
        }
    }
    UMSCCP_FilterResult result = UMSCCP_FILTER_RESULT_UNMODIFIED;
    for(NSString *ruleSet in ruleSets)
    {
        result = [self filterPacket:packet usingRuleset:ruleSet];
        if(result & UMSCCP_FILTER_RESULT_DROP)
        {
            break;
        }
        if(result & UMSCCP_FILTER_RESULT_STATUS)
        {
            break;
        }
    }
    if(_logLevel<= UMLOG_DEBUG)
    {
        [self.logFeed infoText:@"filterToLocalSubsystem returning"];
    }

    return result;
}

- (UMSCCP_FilterResult)filterFromLocalSubsystem:(UMSCCP_Packet *)packet
{
    if(_logLevel<= UMLOG_DEBUG)
    {
        [self.logFeed infoText:@"filterFromLocalSubsystem called"];
    }
    if(_filteringActive==NO)
    {
        [self.logFeed infoText:@"filtering is not active. Skipping"];
        return UMSCCP_FILTER_RESULT_UNMODIFIED;
    }

    NSArray<NSString *> *ruleSets = _outgoingLocalSubsystemFilters[packet.incomingLinkset];
    if(ruleSets==NULL)
    {
        if(_logLevel<= UMLOG_DEBUG)
        {
            [self.logFeed debugText:[NSString stringWithFormat:@" no ruleset found for linkset '%@'. Trying 'all' now.",packet.incomingLinkset]];
        }
        ruleSets = _outgoingLocalSubsystemFilters[@"all"];
        if(ruleSets==NULL)
        {
            if(_logLevel<= UMLOG_DEBUG)
            {
                [self.logFeed debugText:@" no ruleset found for linkset 'all'. returing UMSCCP_FILTER_RESULT_UNMODIFIED"];
            }
            return UMSCCP_FILTER_RESULT_UNMODIFIED;
        }
    }
    UMSCCP_FilterResult result = UMSCCP_FILTER_RESULT_UNMODIFIED;
    for(NSString *ruleSet in ruleSets)
    {
        result = [self filterPacket:packet usingRuleset:ruleSet];
        if(result & UMSCCP_FILTER_RESULT_DROP)
        {
            break;
        }
        if(result & UMSCCP_FILTER_RESULT_STATUS)
        {
            break;
        }
    }
    if(_logLevel<= UMLOG_DEBUG)
    {
        [self.logFeed infoText:@"filterFromLocalSubsystem returning"];
    }
    return result;
}

/************************************************************/
#pragma mark -
#pragma mark Database functions
/************************************************************/



- (UMDbPool *)getDbPool:(NSString *)poolName
{
    return _dbpool_dict[poolName];
}

- (UMSynchronizedDictionary *)dbPools
{
    return _dbpool_dict;
}

- (void)startDatabaseConnections
{
    Class dbpoolClass = objc_getClass("UMDbPool");
    if (dbpoolClass)
    {
        [self.logFeed infoText:@"Starting Database Connections"];
        [self setupDatabaseTaskQueue];
        if(_dbStarted==NO)
        {
            _dbStarted=YES;
            UMSynchronizedDictionary *database_pool_dict = _runningConfig.database_pool_dict;
            NSArray *keys = [database_pool_dict allKeys];
            for(NSString *key in keys)
            {
                UMSS7ConfigDatabasePool *dbPoolConfig =  database_pool_dict[key];
                if(dbPoolConfig.enabled.boolValue==YES)
                {
                    NSString *name = dbPoolConfig.name;
                    if(name)
                    {
                        NSDictionary *dict = [[dbPoolConfig config]dictionaryCopy];
                        @try
                        {
                            UMDbPool *pool = [[UMDbPool alloc]initWithConfig:dict];
                            if(pool)
                            {
                                _dbpool_dict[name]=pool;
                            }
                        }
                        @catch(NSException *e)
                        {
                            [self.logFeed majorErrorText:[NSString stringWithFormat:@"Database functions not available. %@",e]];
                        }
                    }
                }
            }
            _dbStarted=YES;
        }
    }
    else
    {
        [self.logFeed majorErrorText:@"Database functions not available. ulibdb methods not available"];
    }
}

- (void) setupDatabaseTaskQueue
{
    if(_databaseQueue == NULL)
    {
        int concurrentThreads = ulib_cpu_count() * 2;
        if(concurrentThreads<4)
        {
            concurrentThreads = 4;
        }
        _databaseQueue = [[UMTaskQueueMulti alloc]initWithNumberOfThreads:concurrentThreads
                                                                        name:@"db-task-queue"
                                                               enableLogging:NO
                                                              numberOfQueues:UMLAYER_QUEUE_COUNT];
    }
}


/************************************************************/
#pragma mark -
#pragma mark CDR Writer functions
/************************************************************/



- (SS7CDRWriter *)getCDRWriter:(NSString *)name
{
    return _cdrWriters_dict[name];
}


/************************************************************/
#pragma mark -
#pragma mark Configuration Management
/************************************************************/


- (NSString *)exportRunningConfiguration
{
    return [_runningConfig configString];
}

- (NSString *)exportStartupConfiguration
{
    return [_startupConfig configString];
}

- (NSString *)writeCurrentConfigurationToStartup
{
    NSString *configFileName = _runningConfig.rwconfigFile;
    NSString *configFileNameNew = [NSString stringWithFormat:@"%@.new",configFileName];
    NSString *oldConfigFileName1 = [NSString stringWithFormat:@"%@.old",configFileName];
    NSString *oldConfigFileName2 = [NSString stringWithFormat:@"%@.old2",configFileName];
    NSString *oldConfigFileName3 = [NSString stringWithFormat:@"%@.old3",configFileName];
    NSString *oldConfigFileName4 = [NSString stringWithFormat:@"%@.old4",configFileName];
    NSString *oldConfigFileName5 = [NSString stringWithFormat:@"%@.old5",configFileName];
    NSString *oldConfigFileName6 = [NSString stringWithFormat:@"%@.old6",configFileName];
    NSString *oldConfigFileName7 = [NSString stringWithFormat:@"%@.old7",configFileName];
    NSString *oldConfigFileName8 = [NSString stringWithFormat:@"%@.old8",configFileName];
    NSString *oldConfigFileName9 = [NSString stringWithFormat:@"%@.old9",configFileName];


    NSString *s = [_runningConfig configString];
    NSError *e=NULL;
    [s writeToFile:configFileNameNew atomically:YES encoding:NSUTF8StringEncoding error:&e];
    if(e)
    {
        NSLog(@"Error %@",e);
        return [e description];
    }
    unlink(oldConfigFileName9.UTF8String);
    rename(oldConfigFileName8.UTF8String,oldConfigFileName9.UTF8String);
    rename(oldConfigFileName7.UTF8String,oldConfigFileName8.UTF8String);
    rename(oldConfigFileName6.UTF8String,oldConfigFileName7.UTF8String);
    rename(oldConfigFileName5.UTF8String,oldConfigFileName6.UTF8String);
    rename(oldConfigFileName4.UTF8String,oldConfigFileName5.UTF8String);
    rename(oldConfigFileName3.UTF8String,oldConfigFileName4.UTF8String);
    rename(oldConfigFileName2.UTF8String,oldConfigFileName3.UTF8String);
    rename(oldConfigFileName1.UTF8String,oldConfigFileName2.UTF8String);
    rename(configFileName.UTF8String,oldConfigFileName1.UTF8String);
    rename(configFileNameNew.UTF8String,configFileName.UTF8String);
    _startupConfig = _runningConfig;
    return NULL;
}

@end

static void signalHandler(int signum)
{
	if (signum == SIGINT)
	{
		_signal_sigint++;
	}
	else if (signum == SIGHUP)
	{
		_signal_sighup++;
	}
	else if (signum == SIGUSR1)
	{
		_signal_sigusr1++;
	}
	else if (signum == SIGUSR2)
	{
		_signal_sigusr2++;
	}
}


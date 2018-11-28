//
//  SS7AppDelegate.m
//  ulibss7config
//
//  Created by Andreas Fink on 13.11.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "SS7AppDelegate.h"

#import <ulibtransport/ulibtransport.h>
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

#import "SS7GenericInstance.h"
#import "SS7GenericSession.h"
#import "SS7AppTransportHandler.h"

@class SS7AppDelegate;

static SS7AppDelegate *g_app_delegate;
static int _signal_sigint = 0;
static int _signal_sighup = 0;
static int _signal_sigusr1 = 0;
static int _signal_sigusr2 = 0;
static void signalHandler(int signum);

#define CONFIG_ERROR(s)     [NSException exceptionWithName:[NSString stringWithFormat:@"CONFIG_ERROR FILE %s line:%ld",__FILE__,(long)__LINE__] reason:s userInfo:@{@"backtrace": UMBacktrace(NULL,0) }]

@implementation SS7AppDelegate

- (SS7AppDelegate *)init
{
	return [self initWithOptions:@{}];
}

- (SS7AppDelegate *)initWithOptions:(NSDictionary *)options
{
	self = [super init];
	if(self)
	{
		_enabledOptions                 = options;
		_logHandler                     = [[UMLogHandler alloc]initWithConsole];
		_logFeed                        = [[UMLogFeed alloc]initWithHandler:_logHandler];
		_logLevel                       = UMLOG_MAJOR;
		_sctp_dict                      = [[UMSynchronizedDictionary alloc]init];
		_m2pa_dict                      = [[UMSynchronizedDictionary alloc]init];
		_mtp3_dict                      = [[UMSynchronizedDictionary alloc]init];
		_mtp3_link_dict                 = [[UMSynchronizedDictionary alloc]init];
		_mtp3_linkset_dict              = [[UMSynchronizedDictionary alloc]init];
		_m3ua_as_dict                   = [[UMSynchronizedDictionary alloc]init];
		_m3ua_asp_dict                  = [[UMSynchronizedDictionary alloc]init];
		_sccp_dict                      = [[UMSynchronizedDictionary alloc]init];
		_sccp_destinations_dict         = [[UMSynchronizedDictionary alloc]init];
		_webserver_dict                 = [[UMSynchronizedDictionary alloc]init];
		_telnet_dict                    = [[UMSynchronizedDictionary alloc]init];
		_syslog_destination_dict        = [[UMSynchronizedDictionary alloc]init];
		_tcap_dict                      = [[UMSynchronizedDictionary alloc]init];
		_gsmmap_dict                    = [[UMSynchronizedDictionary alloc]init];
		_camel_dict                     = [[UMSynchronizedDictionary alloc]init];
		_sccp_number_translations_dict  = [[UMSynchronizedDictionary alloc]init];
		_registry                       = [[UMSocketSCTPRegistry alloc]init];
		_imsi_pools_dict                = [[UMSynchronizedDictionary alloc]init];
		if(_enabledOptions[@"msc"])
		{
			_msc_dict = [[UMSynchronizedDictionary alloc]init];
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

		if(_enabledOptions[@"umtransport"])
		{
			_umtransportService = [[UMTransportService alloc]initWithTaskQueueMulti:_generalTaskQueue];
			/* FIXME: _umtransportService.delegate = self;  */
		}
		_tidPool = [[UMTCAP_TransactionIdPool alloc]initWithPrefabricatedIds:100000];
		_umtransportLock = [[UMMutex alloc]init];
		_umtransportService = [[UMTransportService alloc]init];
		_pendingUMT = [[UMSynchronizedDictionary alloc]init];

	}
	return self;
}

- (NSDictionary *)appDefinition
{
	return @{
			 @"version" : @"0.0.0",
			 @"executable" : @"ss7-app",
			 @"copyright" : @"© 2018 Andreas Fink",
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
				 }
			 ];
}

- (NSString *)defaultConfigFile
{
	return @"/etc/messsagemover/smsc.conf";
}

- (NSString *)productName
{
	return @"ss7-product";
}

- (void)processCommandLine:(int)argc argv:(const char **)argv
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

- (void)createInstances
{
	/*****************************************************************/
	/* Section GENERAL */
	/*****************************************************************/

	UMSS7ConfigGeneral *generalConfig = _runningConfig.generalConfig;
	if(generalConfig.logDirectory.length > 0)
	{
		_logDirectory = generalConfig.logDirectory;
	}
	else
	{
		_logDirectory = @"/var/log/messagemover/";
	}
	if(generalConfig.logRotations)
	{
		_logRotations = [generalConfig.logRotations intValue];
	}
	else
	{
		_logRotations = 5;
	}

	if(generalConfig.logLevel)
	{
		_logLevel = [generalConfig.logLevel intValue];
	}
	else
	{
		_logLevel = UMLOG_MAJOR;
	}

	int concurrentThreads = ulib_cpu_count() * 2;
	if(_generalTaskQueue == NULL)
	{
		if(_runningConfig.generalConfig.concurrentTasks!=NULL)
		{
			concurrentThreads = [_runningConfig.generalConfig.concurrentTasks intValue];
		}
		if(_concurrentTasks<8)
		{
			_concurrentTasks = 8;
		}
		_generalTaskQueue = [[UMTaskQueueMulti alloc]initWithNumberOfThreads:concurrentThreads
																		name:@"general-task-queue"
															   enableLogging:NO
															  numberOfQueues:UMLAYER_QUEUE_COUNT];
	}
	_webClient = [[UMHTTPClient alloc]init];
	if(generalConfig.hostname)
	{
		_hostname = generalConfig.hostname;
	}
	else
	{
		_hostname = [UMHost localHostName];
	}

	if(generalConfig.queueHardLimit)
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
										@"name":@"admin",
										@"password":@"admin"
										}
									  ];
		[_runningConfig addAdminUser:user];
	}

	/* Webserver */
	names = [_runningConfig getWebserverNames];
	if(names.count == 0)
	{
		/* no config at all? lets set up a safe default on port 8086 */
		UMSS7ConfigWebserver *ws = [[UMSS7ConfigWebserver alloc]initWithConfig:
									@{ @"group" : @"webserver",
									   @"name"  : @"default-webserver",
									   @"port"  : @(8086),
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
				NSString *keyFile = [[config configEntry:@"https-key-file"] stringValue];
				NSString *certFile = [[config configEntry:@"https-cert-file"] stringValue];
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
				[webServer start];
			}
			_webserver_dict[name] = webServer;
		}
	}



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
	for(NSString *name in names)
	{
		UMSS7ConfigObject *co = [_runningConfig getSCTP:name];
		NSDictionary *config = co.config.dictionaryCopy;
		if( [config configEnabledWithYesDefault])
		{
			[self addWithConfigSCTP:config];
		}
	}


	/*****************************************************************/
	/* M2PA */
	/*****************************************************************/
	names = [_runningConfig getM2PANames];
	for(NSString *name in names)
	{
		UMSS7ConfigObject *co = [_runningConfig getM2PA:name];
		NSDictionary *config = co.config.dictionaryCopy;
		if( [config configEnabledWithYesDefault])
		{
			[self addWithConfigM2PA:config];
		}
	}

	/*****************************************************************/
	/* MTP3 */
	/*****************************************************************/
	names = [_runningConfig getMTP3Names];
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



	/*****************************************************************/
	/* M3UAAS */
	/*****************************************************************/
	names = [_runningConfig getM3UAASNames];
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



	/*****************************************************************/
	/* MTP3Routes */
	/*****************************************************************/

	names = [_runningConfig getMTP3RouteNames];
	for(NSString *name in names)
	{
		UMSS7ConfigObject *co = [_runningConfig getMTP3Route:name];
		NSDictionary *cfg = co.config.dictionaryCopy;
		if( [cfg configEnabledWithYesDefault])
		{
			NSString *instance = [[cfg configEntry:@"mtp3"] stringValue];
			NSString *route = [[cfg configEntry:@"dpc"] stringValue];
			NSString *linkset = [[cfg configEntry:@"ls"] stringValue];
			NSString *as = [[cfg configEntry:@"as"] stringValue];
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
					if([a count] == 1)
					{
						UMMTP3PointCode *pc = [[UMMTP3PointCode alloc]initWithString:a[0] variant:mtp3_instance.variant];
						[mtp3_linkset.routingTable updateRouteAvailable:pc mask:0 linksetName:linkset];
					}
					else if([a count]==2)
					{
						UMMTP3PointCode *pc = [[UMMTP3PointCode alloc]initWithString:a[0] variant:mtp3_instance.variant];
						[mtp3_linkset.routingTable updateRouteAvailable:pc mask:(pc.maxmask - [a[1] intValue]) linksetName:linkset];
					}
				}
			}
		}
	}

	/*****************************************************************/
	/* SCCP */
	/*****************************************************************/
	names = [_runningConfig getSCCPNames];
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

	/*****************************************************************/
	/* TCAP */
	/*****************************************************************/
	names = [_runningConfig getTCAPNames];
	for(NSString *name in names)
	{
		UMSS7ConfigObject *co = [_runningConfig getTCAP:name];
		NSDictionary *config = co.config.dictionaryCopy;
		if( [config configEnabledWithYesDefault])
		{
			[self addWithConfigTCAP:config];
		}
	}

	/*****************************************************************/
	/* GSMMAP */
	/*****************************************************************/
	names = [_runningConfig getGSMMAPNames];
	for(NSString *name in names)
	{
		UMSS7ConfigObject *co = [_runningConfig getGSMMAP:name];
		NSDictionary *config = co.config.dictionaryCopy;
		if( [config configEnabledWithYesDefault])
		{
			[self addWithConfigGSMMAP:config];
		}
	}

	/*********************************/
	/* Setup SccpNumberTranslations  */
	/*********************************/

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

		if(selector.defaultEntryName.length > 0)
		{
			selector.defaultEntry = [self getSCCPDestination:selector.defaultEntryName];
		}

		UMLayerSCCP *sccp = [self getSCCP:config[@"sccp"]];
		[sccp.gttSelectorRegistry addEntry:selector];

		NSMutableArray<UMSS7ConfigObject *> *entries = [co subEntries];
		for(UMSS7ConfigSCCPTranslationTableEntry *e in entries)
		{
			SccpGttRoutingTableEntry *entry = [[SccpGttRoutingTableEntry alloc]initWithConfig:e.config.dictionaryCopy];
			if(entry.postTranslationName)
			{
				entry.postTranslation = _sccp_number_translations_dict[entry.postTranslationName];
			}
			if(entry.routeToName)
			{
				entry.routeTo = [self getSCCPDestination: entry.routeToName];
			}
			[selector.routingTable addEntry:entry];
		}
	}

}

- (void)startInstances
{
	NSArray *names = [_mtp3_dict allKeys];
	for(NSString *name in names)
	{
		UMLayerMTP3 *mtp3 = [self getMTP3:name];
		[mtp3 start];
	}
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	if(!_startInStandby)
	{
		[self startInstances];
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
		if([path hasPrefix:@"/msc"])
		{
			[_mainMscInstance httpGetPost:req];
		}
		else if([path hasPrefix:@"/hlr"])
		{
			[_mainHlrInstance httpGetPost:req];
		}
		else if([path isEqualToString:@"/css/style.css"])
		{
			[req setResponseCssString:[SS7AppDelegate css]];
		}
		else if([path isEqualToString:@"/status"])
		{
			[self handleStatus:req];
		}
		else if([path isEqualToString:@"/"])
		{
			NSString *s = [self webIndex];
			[req setResponseHtmlString:s];
		}
		else if([path isEqualToString:@"/debug"])
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
		else
		{
			NSString *s = @"Result: Error\nReason: Unknown request\n";
			[req setResponseTypeText];
			req.responseData = [s dataUsingEncoding:NSUTF8StringEncoding];
			req.responseCode =  404;
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
	[s appendString:@"<header>\n"];
	[s appendString:@"    <link rel=\"stylesheet\" href=\"/css/style.css\" type=\"text/css\">\n"];
	[s appendFormat:@"    <title>Debug: UMObject Statistic</title>\n"];
	[s appendString:@"</header>\n"];
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
		for(UMObjectStat *entry in arr)
		{
			[s appendString:@"    <tr>\r\n"];
			[s appendFormat:@"        <td class=\"object_value\">%@</td>\r\n", entry.name];
			[s appendFormat:@"        <td class=\"object_value\">%lld</td>\r\n",(long long)entry.alloc_count];
			[s appendFormat:@"        <td class=\"object_value\">%lld</td>\r\n",(long long)entry.dealloc_count];
			[s appendFormat:@"        <td class=\"object_value\">%lld</td>\r\n",(long long)entry.inUse_count];
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
	[s appendString:@"<header>\n"];
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
	[s appendString:@"<header>\n"];
	[s appendString:@"    <link rel=\"stylesheet\" href=\"/css/style.css\" type=\"text/css\">\n"];
	[s appendFormat:@"    <title>Debug Menu</title>\n"];
	[s appendString:@"</header>\n"];
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

- (void)  handleStatus:(UMHTTPRequest *)req
{
	NSMutableString *status = [[NSMutableString alloc]init];

	NSArray *keys = [_sctp_dict allKeys];
	for(NSString *key in keys)
	{
		UMLayerSctp *sctp = _sctp_dict[key];
		[status appendFormat:@"SCTP:%@:%@\n",sctp.layerName,sctp.statusString];
	}

	keys = [_m2pa_dict allKeys];
	for(NSString *key in keys)
	{
		UMLayerM2PA *m2pa = _m2pa_dict[key];
		[status appendFormat:@"M2PA-LINK:%@:%@\n",m2pa.layerName,[m2pa m2paStatusString:m2pa.m2pa_status]];
	}

	keys = [_mtp3_linkset_dict allKeys];
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
		}
		else
		{
			[status appendFormat:@"MTP3-LINKSET:%@:OOS:%d/%d/%d\n",
			 linkset.name,
			 linkset.readyLinks,
			 linkset.activeLinks,
			 linkset.totalLinks];

		}
	}

	keys = [_m3ua_asp_dict allKeys];
	for(NSString *key in keys)
	{
		UMM3UAApplicationServerProcess *m3ua_asp = _m3ua_asp_dict[key];
		[status appendFormat:@"M3UA-ASP:%@:%@\n",m3ua_asp.layerName,m3ua_asp.statusString];
	}

	keys = [_m3ua_as_dict allKeys];
	for(NSString *key in keys)
	{
		UMM3UAApplicationServer *as = _m3ua_as_dict[key];
		[status appendFormat:@"M3UA-AS:%@:%@",as.layerName,as.statusString];
		[as updateLinkSetStatus];
		[status appendFormat:@":%d/%d/%d\n",as.readyLinks,as.activeLinks,as.totalLinks];
	}

	keys = [_mtp3_dict allKeys];
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
	for(NSString *key in keys)
	{
		UMLayerSCCP *sccp = _sccp_dict[key];
		[status appendFormat:@"SCCP-INSTANCE:%@:%@\n",sccp.layerName,sccp.status];
	}

	keys = [_tcap_dict allKeys];
	for(NSString *key in keys)
	{
		UMLayerTCAP *tcap = _tcap_dict[key];
		[status appendFormat:@"TCAP-INSTANCE:%@:%@\n",tcap.layerName,tcap.status];
	}

	keys = [_gsmmap_dict allKeys];
	for(NSString *key in keys)
	{
		UMLayerGSMMAP *map = _gsmmap_dict[key];
		[status appendFormat:@"GSMMAP-INSTANCE:%@:%@\n",map.layerName,map.status];
	}

	keys = [_camel_dict allKeys];
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

+ (void)webHeader:(NSMutableString *)s title:(NSString *)t
{
	[s appendString:@"<html>\n"];
	[s appendString:@"<header>\n"];
	[s appendString:@"    <link rel=\"stylesheet\" href=\"/css/style.css\" type=\"text/css\">\n"];
	[s appendFormat:@"    <title>%@</title>\n",t];
	[s appendString:@"</header>\n"];
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

		int concurrentTasks = [[self concurrentTasksForConfig:co] intValue];
		UMTaskQueueMulti *_sctpTaskQueue = [[UMTaskQueueMulti alloc]initWithNumberOfThreads:concurrentTasks
																					   name:@"sctp"
																			  enableLogging:NO
																			 numberOfQueues:UMLAYER_QUEUE_COUNT];

		UMLayerSctp *sctp = [[UMLayerSctp alloc]initWithTaskQueueMulti:_sctpTaskQueue];
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


		int concurrentTasks = [[self concurrentTasksForConfig:co]  intValue];
		UMTaskQueueMulti *_m2paTaskQueue = [[UMTaskQueueMulti alloc]initWithNumberOfThreads:concurrentTasks
																					   name:@"m2pa"
																			  enableLogging:NO
																			 numberOfQueues:UMLAYER_QUEUE_COUNT];

		UMLayerM2PA *m2pa = [[UMLayerM2PA alloc]initWithTaskQueueMulti:_m2paTaskQueue];
		m2pa.logFeed = [[UMLogFeed alloc]initWithHandler:_logHandler section:@"m2pa"];
		m2pa.logFeed.name = name;
		[m2pa setConfig:config applicationContext:self];
		_m2pa_dict[name] = m2pa;    }
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

		int concurrentTasks = [[self concurrentTasksForConfig:co] intValue];
		UMTaskQueueMulti *_mtp3TaskQueue = [[UMTaskQueueMulti alloc]initWithNumberOfThreads:concurrentTasks
																					   name:@"mtp3"
																			  enableLogging:NO
																			 numberOfQueues:UMLAYER_QUEUE_COUNT];

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
	}
}


- (void)deleteMTP3LinkSet:(NSString *)name
{
	/* FIXME: to be implemented */
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
	}
}

- (void)deleteM3UAAS:(NSString *)name
{
	//UMM3UAApplicationServer *instance =  _m3ua_as_dict[name];
	[_m3ua_as_dict removeObjectForKey:name];
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
		UMSS7ConfigM3UAAS *co = [[UMSS7ConfigM3UAAS alloc]initWithConfig:config];
		[_runningConfig addM3UAAS:co];

		UMM3UAApplicationServerProcess *m3ua_asp = [[UMM3UAApplicationServerProcess alloc]init];
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

- (void)addWithConfigSCCP:(NSDictionary *)config
{
	NSString *name = config[@"name"];
	if(name)
	{
		UMSS7ConfigSCCP *co = [[UMSS7ConfigSCCP alloc]initWithConfig:config];
		[_runningConfig addSCCP:co];

		int concurrentTasks = [[self concurrentTasksForConfig:co] intValue];
		UMTaskQueueMulti *_sccpTaskQueue = [[UMTaskQueueMulti alloc]initWithNumberOfThreads:concurrentTasks
																					   name:@"sccp"
																			  enableLogging:NO
																			 numberOfQueues:UMLAYER_QUEUE_COUNT];

		UMLayerSCCP *sccp = [[UMLayerSCCP alloc]initWithTaskQueueMulti:_sccpTaskQueue];
		sccp.logFeed = [[UMLogFeed alloc]initWithHandler:_logHandler section:@"sccp"];
		sccp.logFeed.name = name;
		[sccp setConfig:config applicationContext:self];
		_sccp_dict[name] = sccp;
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

- (SccpDestinationGroup *)getSCCPDestination:(NSString *)name
{
	return _sccp_destinations_dict[name];
}

- (void)addWithConfigSCCPDestination:(NSDictionary *)config
{
	NSString *name = config[@"name"];
	if(name)
	{
		UMSS7ConfigSCCPDestination *co = [[UMSS7ConfigSCCPDestination alloc]initWithConfig:config];
		[_runningConfig addSCCPDestination:co];

		SccpDestinationGroup *dstgrp = [[SccpDestinationGroup alloc]init];
		[dstgrp setConfig:config applicationContext:self];
		_sccp_destinations_dict[name] = dstgrp;
	}
}

- (void)addWithConfigSCCPDestination:(NSDictionary *)config subConfigs:(NSArray<NSDictionary *>*)subConfigs variant:(UMMTP3Variant)variant
{
	NSString *name = config[@"name"];
	if(name)
	{
		UMSS7ConfigSCCPDestination *co = [[UMSS7ConfigSCCPDestination alloc]initWithConfig:config];
		[_runningConfig addSCCPDestination:co];

		SccpDestinationGroup *dstgrp = [[SccpDestinationGroup alloc]init];
		[dstgrp setConfig:config applicationContext:self];
		for(NSDictionary *subConfig in subConfigs)
		{
			UMSS7ConfigSCCPDestinationEntry *coe = [[UMSS7ConfigSCCPDestinationEntry alloc]initWithConfig:subConfig];
			SccpDestination *destination = [[SccpDestination alloc]initWithConfig:subConfig variant:variant];
			[dstgrp addEntry:destination];
			[co addSubEntry:coe];
		}
		_sccp_destinations_dict[name] = dstgrp;
	}
}

- (void)deleteSCCPDestination:(NSString *)name
{
	[_sccp_destinations_dict removeObjectForKey:name];
}

- (void)renameSCCPDestination:(NSString *)oldName to:(NSString *)newName
{
	SccpDestinationGroup *dst =  _sccp_destinations_dict[oldName];
	[_sccp_destinations_dict removeObjectForKey:oldName];
	dst.name = newName;
	_sccp_destinations_dict[newName] = dst;
}

/************************************************************/
#pragma mark -
#pragma mark SCCP Destination Entry Functions
/************************************************************/

- (SccpDestination *)getSCCPDestinationEntry:(NSString *)name index:(int)idx
{
	SccpDestinationGroup *dst =  _sccp_destinations_dict[name];
	if(dst)
	{
		return [dst entryAtIndex:idx];
	}
	return NULL;
}

- (void)deleteSCCPDestinationEntry:(NSString *)name
{
	[_sccp_destinations_dict removeObjectForKey:name];
}

- (void)renameSCCPDestinationEntry:(NSString *)oldName to:(NSString *)newName
{
	SccpDestinationGroup *dst =  _sccp_destinations_dict[oldName];
	[_sccp_destinations_dict removeObjectForKey:oldName];
	dst.name = newName;
	_sccp_destinations_dict[newName] = dst;
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
	if(n)
	{
		return n;
	}
	if(_runningConfig.generalConfig.concurrentTasks!=NULL)
	{
		return _runningConfig.generalConfig.concurrentTasks;
	}
	return @(ulib_cpu_count() * 2);
}


/************************************************************/
#pragma mark -
#pragma mark TCAP Service Functions
/************************************************************/


#pragma mark -
#pragma mark TCAP

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

		int concurrentTasks = [[self concurrentTasksForConfig:co] intValue];
		UMTaskQueueMulti *_tcapTaskQueue = [[UMTaskQueueMulti alloc]initWithNumberOfThreads:concurrentTasks
																					   name:@"tcap"
																			  enableLogging:NO
																			 numberOfQueues:UMLAYER_QUEUE_COUNT];

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

		int concurrentTasks = [[self concurrentTasksForConfig:co] intValue];
		UMTaskQueueMulti *_gsmmapTaskQueue = [[UMTaskQueueMulti alloc]initWithNumberOfThreads:concurrentTasks
																						 name:@"gsmmap"
																				enableLogging:NO
																			   numberOfQueues:UMLAYER_QUEUE_COUNT];

		UMLayerGSMMAP *gsmmap = [[UMLayerGSMMAP alloc]initWithTaskQueueMulti:_gsmmapTaskQueue];
		gsmmap.logFeed = [[UMLogFeed alloc]initWithHandler:_logHandler section:@"tcap"];
		gsmmap.logFeed.name = name;
		[gsmmap setConfig:config applicationContext:self];
		_gsmmap_dict[name] = gsmmap;

		UMLayerTCAP *tcap  = [self getTCAP:co.attachTo];
		if(tcap==NULL)
		{
			[_logFeed majorErrorText:[NSString stringWithFormat:@"GSM-MAP %@ can not attach to TCAP %@",name,co.attachTo]];
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
#pragma mark API Handling
/************************************************************/

- (void)addApiSession:(UMSS7ApiSession *)session
{
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


- (UMSynchronizedSortedDictionary *)readSCCPTranslationTable:(NSString *)name tt:(NSNumber *)tt gti:(NSNumber *)gti np:(NSNumber *)np nai:(NSNumber *)nai
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
}

- (void)addAccessCpntrolAllowOriginHeaders:(UMHTTPRequest *)req
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
	[self addAccessCpntrolAllowOriginHeaders:req];
	req.responseCode =  200;
}



- (void)attachAppTransport:(SS7AppTransportHandler *)transport
					  sccp:(UMLayerSCCP *)sccp
					number:(NSString *)number
		   transactionPool:(UMTCAP_TransactionIdPool *)pool
{
	int concurrentThreads = ulib_cpu_count() * 2;

	NSMutableDictionary *tcapConfig = [[NSMutableDictionary alloc]init];
	NSString *tcapName = [NSString stringWithFormat:@"_ulibtransport-tcap-%@",sccp.layerName];
	tcapConfig[@"name"] = tcapName;
	tcapConfig[@"attach-to"] = sccp.layerName;
	tcapConfig[@"variant"] = @"itu";
	tcapConfig[@"subsystem"] = @(SCCP_SSN_ULIBTRANSPORT);
	tcapConfig[@"timeout"] = @(30);
	tcapConfig[@"number"] = number;
	UMTaskQueueMulti *_tcapTaskQueue = [[UMTaskQueueMulti alloc]initWithNumberOfThreads:concurrentThreads
																				   name:@"tcap"
																		  enableLogging:NO
																		 numberOfQueues:UMLAYER_QUEUE_COUNT];
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


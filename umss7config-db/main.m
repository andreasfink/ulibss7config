//
//  main.m
//  umss7config-db
//
//  Created by Andreas Fink on 16.01.2025.
//  Copyright © 2025 Andreas Fink. All rights reserved.
//

#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#import <ulibss7config/ulibss7config.h>

void check(NSMutableDictionary *o,
           const char *name,
           int tag,
           const char *type,
           NSString *objectName);

int main(int argc, const char * argv[])
{
    @autoreleasepool
    {
        NSDictionary *appDefinition = @ {
            @"version" : @"1.0",
            @"executable" : @"umss7config-db",
            @"run-as" : @(argv[0]),
            @"copyright" : @"© 2025 Andreas Fink",
        };
        
        NSArray *commandLineDefinition = @[
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
                @"name"  : @"create",
                @"short" : @"-c",
                @"long"  : @"--create-tables",
                @"help"  : @"outputs the SQL commands to create empty tables",
            },
            ];
        UMCommandLine *_commandLine = [[UMCommandLine alloc]initWithCommandLineDefintion:commandLineDefinition
                                                                           appDefinition:appDefinition
                                                                                    argc:argc
                                                                                    argv:argv];
        [_commandLine handleStandardArguments];
        NSDictionary *params = _commandLine.params;
        if(params[@"create"])
        {

            NSMutableDictionary *o;
            NSString *s=@"";
            
            s=@"AdminUser";
            #include "start.m"
            #include "UMSS7ConfigAdminUser.def.h"
            #include "end.m"

            s=@"ApiUser";
            #include "start.m"
            #include "UMSS7ConfigApiUser.def.h"
            #include "end.m"

            s=@"AuthServer";
            #include "start.m"
            #include "UMSS7ConfigAuthServer.def.h"
            #include "end.m"

            s=@"CAMEL";
            #include "start.m"
            #include "UMSS7ConfigCAMEL.def.h"
            #include "end.m"

            s=@"CdrServer";
            #include "start.m"
            #include "UMSS7ConfigCdrServer.def.h"
            #include "end.m"

            s=@"CdrWriter";
            #include "start.m"
            #include "UMSS7ConfigCdrWriter.def.h"
            #include "end.m"

            s=@"DatabasePool";
            #include "start.m"
            #include "UMSS7ConfigDatabasePool.def.h"
            #include "end.m"

            s=@"DiameterConnection";
            #include "start.m"
            #include "UMSS7ConfigDiameterConnection.def.h"
            #include "end.m"

            s=@"DiameterRoute";
            #include "start.m"
            #include "UMSS7ConfigDiameterRoute.def.h"
            #include "end.m"

            s=@"DiameterRouter";
            #include "start.m"
            #include "UMSS7ConfigDiameterRouter.def.h"
            #include "end.m"

            s=@"EIR";
            #include "start.m"
            #include "UMSS7ConfigEIR.def.h"
            #include "end.m"

            s=@"ESTP";
            #include "start.m"
            #include "UMSS7ConfigESTP.def.h"
            #include "end.m"

            s=@"GGSN";
            #include "start.m"
            #include "UMSS7ConfigGGSN.def.h"
            #include "end.m"

            s=@"GMLC";
            #include "start.m"
            #include "UMSS7ConfigGMLC.def.h"
            #include "end.m"

            s=@"GSMMAP";
            #include "start.m"
            #include "UMSS7ConfigGSMMAP.def.h"
            #include "end.m"

            s=@"GSMMAPFilter";
            #include "start.m"
            #include "UMSS7ConfigGSMMAPFilter.def.h"
            #include "end.m"

            s=@"GSMMAPFilterEntry";
            #include "start.m"
            #include "UMSS7ConfigGSMMAPFilterEntry.def.h"
            #include "end.m"

            s=@"GSMSCF";
            #include "start.m"
            #include "UMSS7ConfigGSMSCF.def.h"
            #include "end.m"

            s=@"General";
            #include "start.m"
            #include "UMSS7ConfigGeneral.def.h"
            #include "end.m"

            s=@"HLR";
            #include "start.m"
            #include "UMSS7ConfigHLR.def.h"
            #include "end.m"

            s=@"IMSIPool";
            #include "start.m"
            #include "UMSS7ConfigIMSIPool.def.h"
            #include "end.m"

            s=@"M2PA";
            #include "start.m"
            #include "UMSS7ConfigM2PA.def.h"
            #include "end.m"

            s=@"M3UAAS";
            #include "start.m"
            #include "UMSS7ConfigM3UAAS.def.h"
            #include "end.m"

            s=@"M3UAASP";
            #include "start.m"
            #include "UMSS7ConfigM3UAASP.def.h"
            #include "end.m"

            s=@"MAPI";
            #include "start.m"
            #include "UMSS7ConfigMAPI.def.h"
            #include "end.m"

            s=@"MSC";
            #include "start.m"
            #include "UMSS7ConfigMSC.def.h"
            #include "end.m"

            s=@"MTP3";
            #include "start.m"
            #include "UMSS7ConfigMTP3.def.h"
            #include "end.m"

            s=@"MTP3Filter";
            #include "start.m"
            #include "UMSS7ConfigMTP3Filter.def.h"
            #include "end.m"

            s=@"MTP3FilterEntry";
            #include "start.m"
            #include "UMSS7ConfigMTP3FilterEntry.def.h"
            #include "end.m"

            s=@"MTP3Link";
            #include "start.m"
            #include "UMSS7ConfigMTP3Link.def.h"
            #include "end.m"

            s=@"MTP3LinkSet";
            #include "start.m"
            #include "UMSS7ConfigMTP3LinkSet.def.h"
            #include "end.m"

            s=@"MTP3PointCodeTranslationTable";
            #include "start.m"
            #include "UMSS7ConfigMTP3PointCodeTranslationTable.def.h"
            #include "end.m"

            s=@"MTP3Route";
            #include "start.m"
            #include "UMSS7ConfigMTP3Route.def.h"
            #include "end.m"

            s=@"MirrorPort";
            #include "start.m"
            #include "UMSS7ConfigMirrorPort.def.h"
            #include "end.m"

            s=@"MnpDatabase";
            #include "start.m"
            #include "UMSS7ConfigMnpDatabase.def.h"
            #include "end.m"

            s=@"Object";
            #include "start.m"
            #include "UMSS7ConfigObject.def.h"
            #include "end.m"

            s=@"SCCP";
            #include "start.m"
            #include "UMSS7ConfigSCCP.def.h"
            #include "end.m"

            s=@"SCCPDestination";
            #include "start.m"
            #include "UMSS7ConfigSCCPDestination.def.h"
            #include "end.m"

            s=@"SCCPDestinationEntry";
            #include "start.m"
            #include "UMSS7ConfigSCCPDestinationEntry.def.h"
            #include "end.m"

            s=@"SCCPFilter";
            #include "start.m"
            #include "UMSS7ConfigSCCPFilter.def.h"
            #include "end.m"

            s=@"SCCPNumberTranslation";
            #include "start.m"
            #include "UMSS7ConfigSCCPNumberTranslation.def.h"
            #include "end.m"

            s=@"SCCPNumberTranslationEntry";
            #include "start.m"
            #include "UMSS7ConfigSCCPNumberTranslationEntry.def.h"
            #include "end.m"

            s=@"SCCPTranslationTable";
            #include "start.m"
            #include "UMSS7ConfigSCCPTranslationTable.def.h"
            #include "end.m"

            s=@"SCCPTranslationTableEntry";
            #include "start.m"
            #include "UMSS7ConfigSCCPTranslationTableEntry.def.h"
            #include "end.m"

            s=@"SCCPTranslationTableMap";
            #include "start.m"
            #include "UMSS7ConfigSCCPTranslationTableMap.def.h"
            #include "end.m"

            s=@"SCTP";
            #include "start.m"
            #include "UMSS7ConfigSCTP.def.h"
            #include "end.m"

            s=@"SGSN";
            #include "start.m"
            #include "UMSS7ConfigSGSN.def.h"
            #include "end.m"

            s=@"SMPPConnection";
            #include "start.m"
            #include "UMSS7ConfigSMPPConnection.def.h"
            #include "end.m"

            s=@"SMPPPlugin";
            #include "start.m"
            #include "UMSS7ConfigSMPPPlugin.def.h"
            #include "end.m"

            s=@"SMPPServer";
            #include "start.m"
            #include "UMSS7ConfigSMPPServer.def.h"
            #include "end.m"

            s=@"SMS";
            #include "start.m"
            #include "UMSS7ConfigSMS.def.h"
            #include "end.m"

            s=@"SMSC";
            #include "start.m"
            #include "UMSS7ConfigSMSC.def.h"
            #include "end.m"

            s=@"SMSDeliveryProvider";
            #include "start.m"
            #include "UMSS7ConfigSMSDeliveryProvider.def.h"
            #include "end.m"

            s=@"SMSFilter";
            #include "start.m"
            #include "UMSS7ConfigSMSFilter.def.h"
            #include "end.m"

            s=@"SMSFilterEntry";
            #include "start.m"
            #include "UMSS7ConfigSMSFilterEntry.def.h"
            #include "end.m"

            s=@"SMSLog";
            #include "start.m"
            #include "UMSS7ConfigSMSLog.def.h"
            #include "end.m"

            s=@"SMSProxy";
            #include "start.m"
            #include "UMSS7ConfigSMSProxy.def.h"
            #include "end.m"

            s=@"SS7FilterAction";
            #include "start.m"
            #include "UMSS7ConfigSS7FilterAction.def.h"
            #include "end.m"

            s=@"SS7FilterActionList";
            #include "start.m"
            #include "UMSS7ConfigSS7FilterActionList.def.h"
            #include "end.m"

            s=@"SS7FilterEngine";
            #include "start.m"
            #include "UMSS7ConfigSS7FilterEngine.def.h"
            #include "end.m"

            s=@"SS7FilterRule";
            #include "start.m"
            #include "UMSS7ConfigSS7FilterRule.def.h"
            #include "end.m"

            s=@"SS7FilterRuleSet";
            #include "start.m"
            #include "UMSS7ConfigSS7FilterRuleSet.def.h"
            #include "end.m"

            s=@"SS7FilterStagingArea";
            #include "start.m"
            #include "UMSS7ConfigSS7FilterStagingArea.def.h"
            #include "end.m"

            s=@"SS7FilterTraceFile";
            #include "start.m"
            #include "UMSS7ConfigSS7FilterTraceFile.def.h"
            #include "end.m"

            s=@"ServiceBillingEntity";
            #include "start.m"
            #include "UMSS7ConfigServiceBillingEntity.def.h"
            #include "end.m"

            s=@"ServiceProfile";
            #include "start.m"
            #include "UMSS7ConfigServiceProfile.def.h"
            #include "end.m"

            s=@"ServiceUser";
            #include "start.m"
            #include "UMSS7ConfigServiceUser.def.h"
            #include "end.m"

            s=@"StorageServer";
            #include "start.m"
            #include "UMSS7ConfigStorageServer.def.h"
            #include "end.m"

            s=@"SyslogDestination";
            #include "start.m"
            #include "UMSS7ConfigSyslogDestination.def.h"
            #include "end.m"

            s=@"TCAP";
            #include "start.m"
            #include "UMSS7ConfigTCAP.def.h"
            #include "end.m"

            s=@"TCAPFilter";
            #include "start.m"
            #include "UMSS7ConfigTCAPFilter.def.h"
            #include "end.m"

            s=@"TCAPFilterEntry";
            #include "start.m"
            #include "UMSS7ConfigTCAPFilterEntry.def.h"
            #include "end.m"

            s=@"Telnet";
            #include "start.m"
            #include "UMSS7ConfigTelnet.def.h"
            #include "end.m"

            s=@"VLR";
            #include "start.m"
            #include "UMSS7ConfigVLR.def.h"
            #include "end.m"

            s=@"Webserver";
            #include "start.m"
            #include "UMSS7ConfigWebserver.def.h"
            #include "end.m"

        }
        exit(0);
    }
}

void check(NSMutableDictionary *o,
           const char *name,
           int tag,
           const char *type,
           NSString *objectName)
{
    NSDictionary *d = o[@(tag)];
    NSLog(@"Checking %@: %c(%d)",objectName,name,tag);
    if(d!=NULL)
    {
        NSLog(@"**double allocation of name=%@ tag=%d vs name=%c tag=%d", d[@"name"],d[@"tag"],name,tag);
    }
}

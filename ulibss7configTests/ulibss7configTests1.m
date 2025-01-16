//
//  ulibss7configTests1.m
//  ulibss7configTests1
//
//  Created by Andreas Fink on 16.01.2025.
//  Copyright © 2025 Andreas Fink. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface ulibss7configTests1 : XCTestCase

@end

@implementation ulibss7configTests1

- (void)setUp {
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

void check(NSMutableDictionary *o,
           const char *name,
           id value,
           const char *dbname,
           int tag,
           NSString *options,
           NSString *type,
           NSString *objectName)
{
    NSDictionary *d = o[@(tag)];
    NSLog(@"Checking %@: %c(%d)",objectName,name,tag);
    XCTAssert(d==NULL,@"double allocation of name=%@ tag=%d vs name=%c tag=%d", d[@"name"],d[@"tag"],name,tag);
}

- (void)testDuplicateEntries
{
    NSMutableDictionary *o;
    NSString *s;
    
    s=@"AdminUser";
    #include "test_start.inc.m"
    #include "UMSS7ConfigAdminUser.def.h"
    #include "test_end.inc.m"

    s=@"ApiUser";
    #include "test_start.inc.m"
    #include "UMSS7ConfigApiUser.def.h"
    #include "test_end.inc.m"

    s=@"AuthServer";
    #include "test_start.inc.m"
    #include "UMSS7ConfigAuthServer.def.h"
    #include "test_end.inc.m"

    s=@"CAMEL";
    #include "test_start.inc.m"
    #include "UMSS7ConfigCAMEL.def.h"
    #include "test_end.inc.m"

    s=@"CdrServer";
    #include "test_start.inc.m"
    #include "UMSS7ConfigCdrServer.def.h"
    #include "test_end.inc.m"

    s=@"CdrWriter";
    #include "test_start.inc.m"
    #include "UMSS7ConfigCdrWriter.def.h"
    #include "test_end.inc.m"

    s=@"DatabasePool";
    #include "test_start.inc.m"
    #include "UMSS7ConfigDatabasePool.def.h"
    #include "test_end.inc.m"

    s=@"DiameterConnection";
    #include "test_start.inc.m"
    #include "UMSS7ConfigDiameterConnection.def.h"
    #include "test_end.inc.m"

    s=@"DiameterRoute";
    #include "test_start.inc.m"
    #include "UMSS7ConfigDiameterRoute.def.h"
    #include "test_end.inc.m"

    s=@"DiameterRouter";
    #include "test_start.inc.m"
    #include "UMSS7ConfigDiameterRouter.def.h"
    #include "test_end.inc.m"

    s=@"EIR";
    #include "test_start.inc.m"
    #include "UMSS7ConfigEIR.def.h"
    #include "test_end.inc.m"

    s=@"ESTP";
    #include "test_start.inc.m"
    #include "UMSS7ConfigESTP.def.h"
    #include "test_end.inc.m"

    s=@"GGSN";
    #include "test_start.inc.m"
    #include "UMSS7ConfigGGSN.def.h"
    #include "test_end.inc.m"

    s=@"GMLC";
    #include "test_start.inc.m"
    #include "UMSS7ConfigGMLC.def.h"
    #include "test_end.inc.m"

    s=@"GSMMAP";
    #include "test_start.inc.m"
    #include "UMSS7ConfigGSMMAP.def.h"
    #include "test_end.inc.m"

    s=@"GSMMAPFilter";
    #include "test_start.inc.m"
    #include "UMSS7ConfigGSMMAPFilter.def.h"
    #include "test_end.inc.m"

    s=@"GSMMAPFilterEntry";
    #include "test_start.inc.m"
    #include "UMSS7ConfigGSMMAPFilterEntry.def.h"
    #include "test_end.inc.m"

    s=@"GSMSCF";
    #include "test_start.inc.m"
    #include "UMSS7ConfigGSMSCF.def.h"
    #include "test_end.inc.m"

    s=@"General";
    #include "test_start.inc.m"
    #include "UMSS7ConfigGeneral.def.h"
    #include "test_end.inc.m"

    s=@"HLR";
    #include "test_start.inc.m"
    #include "UMSS7ConfigHLR.def.h"
    #include "test_end.inc.m"

    s=@"IMSIPool";
    #include "test_start.inc.m"
    #include "UMSS7ConfigIMSIPool.def.h"
    #include "test_end.inc.m"

    s=@"M2PA";
    #include "test_start.inc.m"
    #include "UMSS7ConfigM2PA.def.h"
    #include "test_end.inc.m"

    s=@"M3UAAS";
    #include "test_start.inc.m"
    #include "UMSS7ConfigM3UAAS.def.h"
    #include "test_end.inc.m"

    s=@"M3UAASP";
    #include "test_start.inc.m"
    #include "UMSS7ConfigM3UAASP.def.h"
    #include "test_end.inc.m"

    s=@"MAPI";
    #include "test_start.inc.m"
    #include "UMSS7ConfigMAPI.def.h"
    #include "test_end.inc.m"

    s=@"MSC";
    #include "test_start.inc.m"
    #include "UMSS7ConfigMSC.def.h"
    #include "test_end.inc.m"

    s=@"MTP3";
    #include "test_start.inc.m"
    #include "UMSS7ConfigMTP3.def.h"
    #include "test_end.inc.m"

    s=@"MTP3Filter";
    #include "test_start.inc.m"
    #include "UMSS7ConfigMTP3Filter.def.h"
    #include "test_end.inc.m"

    s=@"MTP3FilterEntry";
    #include "test_start.inc.m"
    #include "UMSS7ConfigMTP3FilterEntry.def.h"
    #include "test_end.inc.m"

    s=@"MTP3Link";
    #include "test_start.inc.m"
    #include "UMSS7ConfigMTP3Link.def.h"
    #include "test_end.inc.m"

    s=@"MTP3LinkSet";
    #include "test_start.inc.m"
    #include "UMSS7ConfigMTP3LinkSet.def.h"
    #include "test_end.inc.m"

    s=@"MTP3PointCodeTranslationTable";
    #include "test_start.inc.m"
    #include "UMSS7ConfigMTP3PointCodeTranslationTable.def.h"
    #include "test_end.inc.m"

    s=@"MTP3Route";
    #include "test_start.inc.m"
    #include "UMSS7ConfigMTP3Route.def.h"
    #include "test_end.inc.m"

    s=@"MirrorPort";
    #include "test_start.inc.m"
    #include "UMSS7ConfigMirrorPort.def.h"
    #include "test_end.inc.m"

    s=@"MnpDatabase";
    #include "test_start.inc.m"
    #include "UMSS7ConfigMnpDatabase.def.h"
    #include "test_end.inc.m"

    s=@"Object";
    #include "test_start.inc.m"
    #include "UMSS7ConfigObject.def.h"
    #include "test_end.inc.m"

    s=@"SCCP";
    #include "test_start.inc.m"
    #include "UMSS7ConfigSCCP.def.h"
    #include "test_end.inc.m"

    s=@"SCCPDestination";
    #include "test_start.inc.m"
    #include "UMSS7ConfigSCCPDestination.def.h"
    #include "test_end.inc.m"

    s=@"SCCPDestinationEntry";
    #include "test_start.inc.m"
    #include "UMSS7ConfigSCCPDestinationEntry.def.h"
    #include "test_end.inc.m"

    s=@"SCCPFilter";
    #include "test_start.inc.m"
    #include "UMSS7ConfigSCCPFilter.def.h"
    #include "test_end.inc.m"

    s=@"SCCPNumberTranslation";
    #include "test_start.inc.m"
    #include "UMSS7ConfigSCCPNumberTranslation.def.h"
    #include "test_end.inc.m"

    s=@"SCCPNumberTranslationEntry";
    #include "test_start.inc.m"
    #include "UMSS7ConfigSCCPNumberTranslationEntry.def.h"
    #include "test_end.inc.m"

    s=@"SCCPTranslationTable";
    #include "test_start.inc.m"
    #include "UMSS7ConfigSCCPTranslationTable.def.h"
    #include "test_end.inc.m"

    s=@"SCCPTranslationTableEntry";
    #include "test_start.inc.m"
    #include "UMSS7ConfigSCCPTranslationTableEntry.def.h"
    #include "test_end.inc.m"

    s=@"SCCPTranslationTableMap";
    #include "test_start.inc.m"
    #include "UMSS7ConfigSCCPTranslationTableMap.def.h"
    #include "test_end.inc.m"

    s=@"SCTP";
    #include "test_start.inc.m"
    #include "UMSS7ConfigSCTP.def.h"
    #include "test_end.inc.m"

    s=@"SGSN";
    #include "test_start.inc.m"
    #include "UMSS7ConfigSGSN.def.h"
    #include "test_end.inc.m"

    s=@"SMPPConnection";
    #include "test_start.inc.m"
    #include "UMSS7ConfigSMPPConnection.def.h"
    #include "test_end.inc.m"

    s=@"SMPPPlugin";
    #include "test_start.inc.m"
    #include "UMSS7ConfigSMPPPlugin.def.h"
    #include "test_end.inc.m"

    s=@"SMPPServer";
    #include "test_start.inc.m"
    #include "UMSS7ConfigSMPPServer.def.h"
    #include "test_end.inc.m"

    s=@"SMS";
    #include "test_start.inc.m"
    #include "UMSS7ConfigSMS.def.h"
    #include "test_end.inc.m"

    s=@"SMSC";
    #include "test_start.inc.m"
    #include "UMSS7ConfigSMSC.def.h"
    #include "test_end.inc.m"

    s=@"SMSDeliveryProvider";
    #include "test_start.inc.m"
    #include "UMSS7ConfigSMSDeliveryProvider.def.h"
    #include "test_end.inc.m"

    s=@"SMSFilter";
    #include "test_start.inc.m"
    #include "UMSS7ConfigSMSFilter.def.h"
    #include "test_end.inc.m"

    s=@"SMSFilterEntry";
    #include "test_start.inc.m"
    #include "UMSS7ConfigSMSFilterEntry.def.h"
    #include "test_end.inc.m"

    s=@"SMSLog";
    #include "test_start.inc.m"
    #include "UMSS7ConfigSMSLog.def.h"
    #include "test_end.inc.m"

    s=@"SMSProxy";
    #include "test_start.inc.m"
    #include "UMSS7ConfigSMSProxy.def.h"
    #include "test_end.inc.m"

    s=@"SS7FilterAction";
    #include "test_start.inc.m"
    #include "UMSS7ConfigSS7FilterAction.def.h"
    #include "test_end.inc.m"

    s=@"SS7FilterActionList";
    #include "test_start.inc.m"
    #include "UMSS7ConfigSS7FilterActionList.def.h"
    #include "test_end.inc.m"

    s=@"SS7FilterEngine";
    #include "test_start.inc.m"
    #include "UMSS7ConfigSS7FilterEngine.def.h"
    #include "test_end.inc.m"

    s=@"SS7FilterRule";
    #include "test_start.inc.m"
    #include "UMSS7ConfigSS7FilterRule.def.h"
    #include "test_end.inc.m"

    s=@"SS7FilterRuleSet";
    #include "test_start.inc.m"
    #include "UMSS7ConfigSS7FilterRuleSet.def.h"
    #include "test_end.inc.m"

    s=@"SS7FilterStagingArea";
    #include "test_start.inc.m"
    #include "UMSS7ConfigSS7FilterStagingArea.def.h"
    #include "test_end.inc.m"

    s=@"SS7FilterTraceFile";
    #include "test_start.inc.m"
    #include "UMSS7ConfigSS7FilterTraceFile.def.h"
    #include "test_end.inc.m"

    s=@"ServiceBillingEntity";
    #include "test_start.inc.m"
    #include "UMSS7ConfigServiceBillingEntity.def.h"
    #include "test_end.inc.m"

    s=@"ServiceProfile";
    #include "test_start.inc.m"
    #include "UMSS7ConfigServiceProfile.def.h"
    #include "test_end.inc.m"

    s=@"ServiceUser";
    #include "test_start.inc.m"
    #include "UMSS7ConfigServiceUser.def.h"
    #include "test_end.inc.m"

    s=@"StorageServer";
    #include "test_start.inc.m"
    #include "UMSS7ConfigStorageServer.def.h"
    #include "test_end.inc.m"

    s=@"SyslogDestination";
    #include "test_start.inc.m"
    #include "UMSS7ConfigSyslogDestination.def.h"
    #include "test_end.inc.m"

    s=@"TCAP";
    #include "test_start.inc.m"
    #include "UMSS7ConfigTCAP.def.h"
    #include "test_end.inc.m"

    s=@"TCAPFilter";
    #include "test_start.inc.m"
    #include "UMSS7ConfigTCAPFilter.def.h"
    #include "test_end.inc.m"

    s=@"TCAPFilterEntry";
    #include "test_start.inc.m"
    #include "UMSS7ConfigTCAPFilterEntry.def.h"
    #include "test_end.inc.m"

    s=@"Telnet";
    #include "test_start.inc.m"
    #include "UMSS7ConfigTelnet.def.h"
    #include "test_end.inc.m"

    s=@"VLR";
    #include "test_start.inc.m"
    #include "UMSS7ConfigVLR.def.h"
    #include "test_end.inc.m"

    s=@"Webserver";
    #include "test_start.inc.m"
    #include "UMSS7ConfigWebserver.def.h"
    #include "test_end.inc.m"

}
@end

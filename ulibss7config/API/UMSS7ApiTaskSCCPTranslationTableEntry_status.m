//
//  UMSS7ApiTaskSCCPTranslationTableEntry_status.m
//  ulibss7config
//
//  Created by Andreas Fink on 31.12.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSCCPTranslationTableEntry_status.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSCCPTranslationTableEntry.h"

@implementation UMSS7ApiTaskSCCPTranslationTableEntry_status

+ (NSString *)apiPath
{
    return @"/api/sccp-translation-table-entry-status";
}

- (void)main
{
    if(![self isAuthenticated])
    {
        [self sendErrorNotAuthenticated];
        return;
    }

    if(![self isAuthorized])
    {
        [self sendErrorNotAuthorized];
        return;
    }

    NSString *sccp_name     = _webRequest.params[@"sccp"];
    if(sccp_name.length==0)
    {
        [self sendErrorMissingParameter:@"sccp"];
        return;
    }
    NSString *table_name    = _webRequest.params[@"translation-table"];
    if(table_name.length==0)
    {
        [self sendErrorMissingParameter:@"translation-table"];
    }

    NSString *gta = _webRequest.params[@"gta"];
    gta = [UMSS7ConfigObject filterName:gta];
    NSString *entryName = [SccpGttRoutingTableEntry entryNameForGta:gta tableName:table_name];
    UMSS7ConfigStorage *cs = [_appDelegate runningConfig];
    UMSS7ConfigSCCPTranslationTableEntry *entry = [cs getSCCPTranslationTableEntry:entryName];

    if(entry==NULL)
    {
        [self sendErrorNotFound];
    }
    else
    {
        NSDictionary *oldConfig = entry.config.dictionaryCopy;
        @try
        {
            UMLayerSCCP *sccp_instance = [_appDelegate getSCCP:sccp_name];
            if(sccp_instance==NULL)
            {
                [self sendErrorNotFound:@"sccp"];
                return;
            }
            SccpGttSelector *selector = [sccp_instance.gttSelectorRegistry getSelectorByName:table_name];
            if(selector==NULL)
            {
                [self sendErrorNotFound:@"translation-table"];
                return;
            }

            SccpGttRoutingTable *rt = selector.routingTable;
            if(rt==NULL)
            {
                [self sendErrorNotFound:@"translation-table.routing-table"];
                return;
            }


            NSString *gta = _webRequest.params[@"gta"];
            gta = [UMSS7ConfigObject filterName:gta];
            NSString *entryName = [SccpGttRoutingTableEntry entryNameForGta:gta tableName:table_name];


            SccpGttRoutingTableEntry *rte = [rt findEntryByName:entryName];
            if(rte==NULL)
            {
                NSString *gta = oldConfig[@"gta"];
                rte = [rt findEntryByDigits:gta];
            }
            if(rte==NULL)
            {
                [self sendErrorNotFound:@"translation-table-entry"];
                return;
            }

            [self sendResultObject:[rte statusForL3RoutingTable:sccp_instance.mtp3RoutingTable]];
        }

        @catch(NSException *e)
        {
            [entry setConfig:oldConfig];
            [self sendException:e];
        }
    }
}

@end

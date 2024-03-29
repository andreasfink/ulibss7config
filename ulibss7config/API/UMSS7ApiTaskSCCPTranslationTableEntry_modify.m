//
//  UMSS7ApiTaskSCCPTranslationTableEntry_modify.m
//  ulibss7config
//
//  Created by Andreas Fink on 31.12.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSCCPTranslationTableEntry_modify.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSCCPTranslationTableEntry.h"

@implementation UMSS7ApiTaskSCCPTranslationTableEntry_modify

+ (NSString *)apiPath
{
    return @"/api/sccp-translation-table-entry-modify";
}

- (void)main
{
    @autoreleasepool
    {
        if(![self isAuthenticated])
        {
            [self sendErrorNotAuthenticated];
            return;
        }

        if(![self isAuthorised])
        {
            [self sendErrorNotAuthorised];
            return;
        }

        NSString *sccp_name     = _params[@"sccp"];
        if(sccp_name.length==0)
        {
            [self sendErrorMissingParameter:@"sccp"];
            return;
        }
        NSString *table_name    = _params[@"translation-table"];
        if(table_name.length==0)
        {
            [self sendErrorMissingParameter:@"translation-table"];
        }

        NSString *gta = _params[@"gta"];
        gta = [UMSS7ConfigObject filterName:gta];
        SccpGttRoutingTableEntry *e = [[SccpGttRoutingTableEntry alloc]initWithConfig:_params];
        NSString *entryName = e.name;
        e = NULL;
        UMSS7ConfigStorage *cs = [_appDelegate runningConfig];
        UMSS7ConfigSCCPTranslationTableEntry *entry = [cs getSCCPTranslationTableEntry:entryName];


        if(entry==NULL)
        {
            [self sendErrorNotFound];
        }
        else
        {
            NSDictionary *oldConfig = entry.config.dictionaryCopy;
            [entry setConfig:_params];
            NSDictionary *newConfig = entry.config.dictionaryCopy;

            @try
            {
                UMLayerSCCP *sccp_instance = [_appDelegate getSCCP:sccp_name];
                if(sccp_instance==NULL)
                {
                    [self sendErrorNotFound:@"sccp"];
                    [entry setConfig:oldConfig];
                    return;
                }
                SccpGttSelector *selector = [sccp_instance.gttSelectorRegistry getSelectorByName:table_name];
                if(selector==NULL)
                {
                    [self sendErrorNotFound:@"translation-table"];
                    [entry setConfig:oldConfig];
                    return;
                }

                SccpGttRoutingTable *rt = selector.routingTable;
                if(rt==NULL)
                {
                    [self sendErrorNotFound:@"translation-table.routing-table"];
                    [entry setConfig:oldConfig];
                    return;
                }
                SccpGttRoutingTableEntry *rte = [rt findEntryByName:entryName];
                if(rte==NULL)
                {
                    NSString *gta = newConfig[@"gta"];
                    rte = [rt findEntryByDigits:gta transactionNumber:NULL ssn:NULL operation:NULL appContext:NULL];
                }
                if(rte==NULL)
                {
                    rte = [[SccpGttRoutingTableEntry alloc]initWithConfig:newConfig];
                }
                [rt addEntry:rte];
                [self sendResultObject:newConfig];
            }

            @catch(NSException *e)
            {
                [entry setConfig:oldConfig];
                [self sendException:e];
            }
        }
    }
}
@end

//
//  UMSS7ApiTaskSCCPTranslationTableEntry_add.m
//  ulibss7config
//
//  Created by Andreas Fink on 31.12.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSCCPTranslationTableEntry_add.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSCCPTranslationTableEntry.h"

@implementation UMSS7ApiTaskSCCPTranslationTableEntry_add

+ (NSString *)apiPath
{
    return @"/api/sccp-translation-table-entry-add";
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
        UMSS7ConfigStorage *cs = [_appDelegate runningConfig];

        SccpGttRoutingTableEntry *e = [[SccpGttRoutingTableEntry alloc]initWithConfig:_params];
        NSString *entryName = e.name;
        e = NULL;

        UMSS7ConfigSCCPTranslationTableEntry *entry = [cs getSCCPTranslationTableEntry:entryName];
        if(entry!=NULL)
        {
            [self sendErrorAlreadyExisting];
            return;
        }
        @try
        {
            entry = [[UMSS7ConfigSCCPTranslationTableEntry alloc]initWithConfig:_params];

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
            NSDictionary *config = [entry.config dictionaryCopy];
            id gta_entry = config[@"gta"];
            if([gta_entry isKindOfClass:[NSArray class]])
            {
                NSArray *gtas = (NSArray *)gta_entry;
                for (NSString *gta in gtas)
                {
                    NSMutableDictionary *config2 = [config mutableCopy];
                    config2[@"gta"] = gta;
                    SccpGttRoutingTableEntry *rte = [[SccpGttRoutingTableEntry alloc]initWithConfig:config2];
                    [rt addEntry:rte];
                }
            }
            else if([gta_entry isKindOfClass:[NSArray class]])
            {
                SccpGttRoutingTableEntry *rte = [[SccpGttRoutingTableEntry alloc]initWithConfig:config];
                [rt addEntry:rte];
            }
        }

        @catch(NSException *e)
        {
            [self sendException:e];
        }
        [self sendResultObject:entry.config];
    }
}

@end

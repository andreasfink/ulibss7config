//
//  UMSS7ApiTaskSCCPTranslationTableEntry_action.m
//  ulibss7config
//
//  Created by Andreas Fink on 31.12.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSCCPTranslationTableEntry_action.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSCCPTranslationTableEntry.h"

@implementation UMSS7ApiTaskSCCPTranslationTableEntry_action

+ (NSString *)apiPath
{
    return @"/api/sccp-translation-table-entry-action";
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

        if(![self isAuthorized])
        {
            [self sendErrorNotAuthorized];
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
        NSString *entryName = [SccpGttRoutingTableEntry entryNameForGta:gta tableName:table_name];
        UMSS7ConfigStorage *cs = [_appDelegate runningConfig];
        UMSS7ConfigSCCPTranslationTableEntry *entry = [cs getSCCPTranslationTableEntry:entryName];

        NSString *action     = _params[@"action"];
        if(action.length==0)
        {
            [self sendErrorMissingParameter:@"action"];
        }

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
                if([action isEqualToString:@"enable"])
                {
                    rte.enabled=YES;
                }
                else if([action isEqualToString:@"disable"])
                {
                    rte.enabled=NO;
                }
                else
                {
                    [self sendErrorUnknownAction];
                }
                [self sendResultOK];
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

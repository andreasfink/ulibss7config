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

        if(entry==NULL)
        {
            [self sendErrorNotFound];
        }
        else
        {
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

                NSString *gta = _params[@"gta"];
                gta = [UMSS7ConfigObject filterName:gta];
                NSString *entryName = [SccpGttRoutingTableEntry entryNameForGta:gta tableName:table_name];


                SccpGttRoutingTableEntry *rte = [rt findEntryByName:entryName];
                if(rte==NULL)
                {
                    rte = [rt findEntryByDigits:gta transactionNumber:NULL ssn:NULL operation:NULL appContext:NULL];
                }
                if(rte==NULL)
                {
                    [self sendErrorNotFound:@"translation-table-entry"];
                    return;
                }
                NSLog(@"sccp_instance.mtp3RoutingTable=%@",sccp_instance.mtp3RoutingTable);

                UMSynchronizedSortedDictionary *dict = [rte statusForL3RoutingTable:sccp_instance.mtp3RoutingTable];

                @try
                {
                    UMJsonWriter *writer = [[UMJsonWriter alloc]init];
                    writer.humanReadable = YES;
                    NSString *string =  [writer stringWithObject:dict];
                    if(string.length==0)
                    {
                        NSLog(@"can not serialize dict: %@",dict);
                        NSLog(@"writer.error: %@",writer.error);
                    }
                    else
                    {
                        NSLog(@"json response: %@",string);
                    }
                }
                @catch(NSException *e)
                {
                    NSLog(@"Exception = %@",e);
                }
                if(dict)
                {
                    [self sendResultObject:dict];
                }
                else
                {
                    [self sendError:@"statusForL3RoutingTable returns NULL"];
                }
            }

            @catch(NSException *e)
            {
                [self sendException:e];
            }
        }
    }
}

@end

//
//  UMSS7ApiTaskSCCPTranslationTableEntry_list.m
//  ulibss7config
//
//  Created by Andreas Fink on 31.12.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSCCPTranslationTableEntry_list.h"


#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"

@implementation UMSS7ApiTaskSCCPTranslationTableEntry_list



+ (NSString *)apiPath
{
    return @"/api/sccp-translation-table-entry-list";
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

    SccpGttRoutingTable *rt = [self getRoutingTable];
    if(rt==NULL)
    {
        return;
    }
    NSArray *a = rt.list.allKeys;
    
    int details = [((NSString *)_params[@"details"]) intValue];
    switch(details)
    {
        case 0:
            [self sendResultObject:a];
            break;
        case 1:
        case 2:

            {
                NSMutableArray *entries = [[NSMutableArray alloc]init];
                for(NSString *name in a)
                {
                    SccpGttRoutingTableEntry *obj = rt.list[name];
                    if(obj)
                    {
                        [entries addObject:obj];
                    }
                }
                [self sendResultObject:entries];
            }
            break;
    }
}

@end


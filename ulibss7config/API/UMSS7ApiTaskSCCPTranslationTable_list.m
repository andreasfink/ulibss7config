//
//  UMSS7ApiTaskSCCPTranslationTable_list.m
//  ulibss7config
//
//  Created by Andreas Fink on 31.12.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSCCPTranslationTable_list.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"

@implementation UMSS7ApiTaskSCCPTranslationTable_list



+ (NSString *)apiPath
{
    return @"/api/sccp-translation-table-list";
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

        NSString *sccp_name = _params[@"sccp"];
        sccp_name = [UMSS7ConfigObject filterName:sccp_name];
        int details = [((NSString *)_params[@"details"]) intValue];

        NSArray *sccp_names;
        if(sccp_name.length == 0)
        {
            sccp_names = [_appDelegate getSCCPNames];
        }
        else
        {
            sccp_names = @[sccp_name];
        }

        UMSynchronizedSortedDictionary *dict = [[UMSynchronizedSortedDictionary alloc]init];
        for(sccp_name in sccp_names)
        {
            UMLayerSCCP *instance = [_appDelegate getSCCP:sccp_name];
            NSArray *names = [instance.gttSelectorRegistry listSelectorNames];
            if(details==0)
            {
                dict[sccp_name] = names;
            }
            else
            {
                NSMutableArray *entries = [[NSMutableArray alloc]init];
                for(NSString *name in names)
                {
                    SccpGttSelector *selector = [instance.gttSelectorRegistry getSelectorByName:name];
                    UMSynchronizedSortedDictionary *d2 = [[UMSynchronizedSortedDictionary alloc]init];
                    d2[@"name"] = selector.name;
                    d2[@"tt"]  = @(selector.tt);
                    d2[@"gti"]  = @(selector.gti);
                    d2[@"mp"]  = @(selector.np);
                    d2[@"nai"]  = @(selector.nai);
                    [entries addObject:d2];
                }
                dict[sccp_name] = entries;
            }
        }
        [self sendResultObject:dict];
    }
}

@end


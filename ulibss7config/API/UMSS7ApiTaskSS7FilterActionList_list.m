//
//  UMSS7ApiTaskSS7FilterActionList_list.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterActionList_list.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSS7FilterActionList.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigSS7FilterStagingArea.h"
#import "UMSS7ConfigSS7FilterAction.h"

@implementation UMSS7ApiTaskSS7FilterActionList_list

+ (NSString *)apiPath
{
    return @"/api/ss7-filter-action-list-list";
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
    
    // 1. Get Staging Area
    UMSS7ConfigSS7FilterStagingArea *stagingArea = [_appDelegate getStagingAreaForSession:_apiSession];
    if(stagingArea == NULL)
    {
        [self sendErrorNotFound:@"staging-area"];
    }
    else
    {
        @try
        {
            UMSynchronizedDictionary *listActions = [[UMSynchronizedDictionary alloc]init];
            NSArray *keys = [stagingArea.filter_action_list_dict allKeys];
            for(NSString *k in keys)
            {
                UMSS7ConfigSS7FilterActionList *ls = stagingArea.filter_action_list_dict[k];
                NSArray *actions = [ls getAllActions];
                UMSynchronizedDictionary *act = [[UMSynchronizedDictionary alloc]init];
                for(UMSS7ConfigSS7FilterAction *it in actions)
                {
                    act[it.name] = it;
                }
                listActions[k] = act;
            }
            [self sendResultObject:listActions];
        }
        @catch(NSException *e)
        {
            [self sendException:e];
        }
    }
    
}

@end

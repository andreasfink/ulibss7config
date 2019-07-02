//
//  UMSS7ApiTaskSS7FilterAction_add.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterAction_add.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSS7FilterAction.h"
#import "UMSS7ConfigSS7FilterStagingArea.h"
#import "UMSS7ConfigSS7FilterActionList.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskSS7FilterAction_add

+ (NSString *)apiPath
{
    return @"/api/ss7-filter-action-add";
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
        [self sendErrorNotFound:@"Staging-Area"];
    }
    else
    {
        @try
        {
            // 2. Get Action-List
            NSString *name = _webRequest.params[@"filter-action-list"];
            UMSS7ConfigSS7FilterActionList* list = stagingArea.filter_action_list_dict[name];
            
            // 3. Get Required external params
            NSString *action = _webRequest.params[@"action"];
            
            NSDictionary *d = [NSDictionary dictionary];

            // 4. Verify if action-list exists
            if(list == NULL)
            {
                // 4a. Not found
                [self sendErrorNotFound:name];
            }
            else if(action.length==0)
            {
                d = @{@"error" : @"missing-parameter", @"reason" :@"the action parameter is not passed"};
                [self sendError:[d jsonString]];
            }
            else
            {
                 // 4. adding
                UMSS7ConfigSS7FilterAction *action = [[UMSS7ConfigSS7FilterAction alloc]initWithConfig:_webRequest.params];
                UMSynchronizedSortedDictionary *config = action.config;
                NSString *order = _webRequest.params[@"order"];
                if(order == NULL)
                {
                    [list appendAction:action];
                }
                else
                {
                    NSInteger pos = [order integerValue];
                    [list insertAction:action atIndex:pos];
                }

                // 6. Return result
                [self sendResultObject:config];
            }
        }
        @catch(NSException *e)
        {
            [self sendException:e];
        }
    }
}

@end

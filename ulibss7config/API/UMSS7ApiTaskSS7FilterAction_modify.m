//
//  UMSS7ApiTaskSS7FilterAction_modify.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterAction_modify.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSS7FilterStagingArea.h"
#import "UMSS7ConfigSS7FilterActionList.h"
#import "UMSS7ConfigSS7FilterAction.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskSS7FilterAction_modify

+ (NSString *)apiPath
{
    return @"/api/ss7-filter-action-modify";
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
                NSString *name = _params[@"filter-action-list"];
                UMSS7ConfigSS7FilterActionList* list = stagingArea.filter_action_list_dict[name];
                
                // 3. Get index of action
                NSString *idx = _params[@"entry-nr"];
                
                // 4. Verify if action-list exists
                if(list == NULL)
                {
                    // 4a. Not found
                    [self sendErrorNotFound:name];
                }
                else if(idx.length==0)
                {
                    [self sendError:@"missing-parameter"  reason:@"the 'entry-nr' parameter is not passed"];

                }
                else
                {
                    // 4c. Get action
                    NSInteger i = [idx integerValue];
                    UMSS7ConfigSS7FilterAction* action = [list getActionAtIndex:i];
                    if(action == NULL)
                    {
                        // 4c-1. Action not found
                        [self sendError:@"not-found" reason:@"this action is not found"];
                    }
                    else
                    {
                        // apply modifications
                        [action setConfig:_params];
                        // 4c-2. return action
                        UMSynchronizedSortedDictionary *conf = action.config;
                        [stagingArea setDirty:YES];
                        [self sendResultObject:conf];
                    }
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

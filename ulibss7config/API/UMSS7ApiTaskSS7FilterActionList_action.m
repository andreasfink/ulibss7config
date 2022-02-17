//
//  UMSS7ApiTaskSS7FilterActionList_action.m
//  ulibss7config
//
//  Created by Andreas Fink on 28.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterActionList_action.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSS7FilterStagingArea.h"
#import "UMSS7ConfigSS7FilterActionList.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskSS7FilterActionList_action


+ (NSString *)apiPath
{
    return @"/api/ss7-filter-action-list-action";
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
                NSString *name = _params[@"filter-action-list"];
                NSString *action = _params[@"action"];
                UMSS7ConfigSS7FilterActionList *filterActionList = stagingArea.filter_action_list_dict[name];

                if(filterActionList == NULL)
                {
                    [self sendErrorNotFound:name];
                }
                else
                {
                    if([action isEqualToString:@"action-list"])
                    {
                        if(filterActionList.enabled == NULL)
                        {
                            filterActionList.enabled = @(YES);
                        }
                        if(filterActionList.enabled.boolValue)
                        {
                            [self sendResultObject:@[@"enable"]];
                        }
                        else
                        {
                            [self sendResultObject:@[@"disable"]];
                        }
                    }
                    else if([action isEqualToString:@"disable"])
                    {
                       filterActionList.enabled = @(NO);
                       [self sendResultOK];
                       [stagingArea setDirty:YES];
                    }
                    else if([action isEqualToString:@"enable"])
                    {
                        filterActionList.enabled = @(YES);
                        [self sendResultOK];
                        [stagingArea setDirty:YES];
                    }
                    else
                    {
                        [self sendErrorUnknownAction];
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

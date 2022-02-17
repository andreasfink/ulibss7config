//
//  UMSS7ApiTaskSS7FilterRuleSet_action.m
//  ulibss7config
//
//  Created by Andreas Fink on 28.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterRuleSet_action.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSS7FilterRuleSet.h"
#import "UMSS7ConfigSS7FilterStagingArea.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskSS7FilterRuleSet_action

+ (NSString *)apiPath
{
    return @"/api/ss7-filter-rule-set-action";
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
                NSString *name = _params[@"name"];
                NSString *action = _params[@"action"];
                UMSS7ConfigSS7FilterRuleSet *filterRuleSet = stagingArea.filter_rule_set_dict[name];
                if(filterRuleSet == NULL)
                {
                    [self sendErrorNotFound:name];
                }
                else
                {
                    if([action isEqualToString:@"action-list"])
                    {
                        if(filterRuleSet.enabled == NULL)
                        {
                            filterRuleSet.enabled = @(YES);
                        }
                        if(filterRuleSet.enabled.boolValue)
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
                       filterRuleSet.enabled = @(NO);
                       [self sendResultOK];
                       [stagingArea setDirty:YES];
                    }
                    else if([action isEqualToString:@"enable"])
                    {
                        filterRuleSet.enabled = @(YES);
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

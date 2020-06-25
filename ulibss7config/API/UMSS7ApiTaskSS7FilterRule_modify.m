//
//  UMSS7ApiTaskSS7FilterRule_modify.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterRule_modify.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSS7FilterRule.h"
#import "UMSS7ConfigSS7FilterStagingArea.h"
#import "UMSS7ConfigSS7FilterRuleSet.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskSS7FilterRule_modify

+ (NSString *)apiPath
{
    return @"/api/ss7-filter-rule-modify";
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
                // 2. Get Engine
                NSString *ruleset_name  = _params[@"filter-ruleset"];
                NSString *idx           = _params[@"entry-nr"];
                UMSS7ConfigSS7FilterRuleSet* rSet = stagingArea.filter_rule_set_dict[ruleset_name];
                if(rSet == NULL)
                {
                    // 5b. Not found
                    [self sendErrorNotFound:ruleset_name];
                }
                else if(idx == NULL)
                {
                    // 5c. Not found
                    [self sendErrorNotFound:@"Rule Position"];
                }
                else
                {
                    // 5d. Get rule
                    NSInteger i = [idx integerValue];
                    UMSS7ConfigSS7FilterRule* filterRule = [rSet getRuleAtIndex:i];
                    if(filterRule == NULL)
                    {
                        // 5d-1. Rule not found
                        [self sendErrorNotFound:@"Rule"];
                    }
                    else
                    {
                        // 5d-2. OK
                        UMSS7ConfigSS7FilterRule* newRule  = [[UMSS7ConfigSS7FilterRule alloc]initWithConfig:_params];
                        [rSet setRule:newRule atIndex:i];
                        [stagingArea setDirty:YES];
                        [self sendResultOK];
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

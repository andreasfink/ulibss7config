//
//  UMSS7ApiTaskSS7FilterRule_read.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterRule_read.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSS7FilterRule.h"
#import "UMSS7ConfigSS7FilterStagingArea.h"
#import "UMSS7ConfigSS7FilterRuleSet.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskSS7FilterRule_read

+ (NSString *)apiPath
{
    return @"/api/ss7-filter-rule-read";
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
                // 2. Get Rule-Set name
                NSString *ruleset_name = _params[@"filter-ruleset"];
                
                // 3. Get Rule-Set
                UMSS7ConfigSS7FilterRuleSet* rSet = stagingArea.filter_rule_set_dict[ruleset_name];
                
                // 4. Get index of rule
                NSString *idx = _params[@"entry-nr"];
                
                // 5. Verify if engine, rule-set, rule exist
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
                        // 5d-2. return rule
                        [self sendResultObject:filterRule];
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

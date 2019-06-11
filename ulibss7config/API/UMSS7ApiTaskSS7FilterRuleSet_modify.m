//
//  UMSS7ApiTaskSS7FilterRuleSet_modify.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterRuleSet_modify.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSS7FilterRuleset.h"
#import "UMSS7ConfigStorage.h"

@implementation UMSS7ApiTaskSS7FilterRuleSet_modify

+ (NSString *)apiPath
{
    return @"/api/ss7-filter-ruleset-modify";
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
            NSString *name = _webRequest.params[@"name"];
            UMSS7ConfigSS7FilterRuleset *rs = stagingArea.filter_rule_set_dict[name];
            if(rs == NULL)
            {
                [self sendErrorNotFound:name];
            }
            else
            {
                [rs setConfig:_webRequest];
                [self sendResultObject:rs.config];
            }
        }
        @catch(NSException *e)
        {
            [self sendException:e];
        }
    }
    [self sendErrorNotImplemented];
}

@end

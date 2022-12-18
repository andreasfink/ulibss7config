//
//  UMSS7ApiTaskSS7FilterRuleSet_modify.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterRuleSet_modify.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSS7FilterRuleSet.h"
#import "UMSS7ConfigSS7FilterStagingArea.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskSS7FilterRuleSet_modify

+ (NSString *)apiPath
{
    return @"/api/ss7-filter-ruleset-modify";
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
            [self sendErrorNotFound:@"staging-area"];
        }
        else
        {
            @try
            {
                NSString *name = _params[@"name"];
                UMSS7ConfigSS7FilterRuleSet *rs = stagingArea.filter_rule_set_dict[name];
                if(rs == NULL)
                {
                    [self sendErrorNotFound:name];
                }
                else
                {
                    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithDictionary:_params];
                    [rs setConfig:dict];
                    [stagingArea setDirty:YES];
                    [self sendResultObject:rs.config];
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

//
//  UMSS7ApiTaskSS7FilterRuleSet_list.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterRuleSet_list.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSS7FilterRuleset.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ApiSession.h"
#import "UMSS7ConfigSS7FilterStagingArea.h"
#import "UMSS7ConfigSS7FilterRule.h"

@implementation UMSS7ApiTaskSS7FilterRuleSet_list


+ (NSString *)apiPath
{
    return @"/api/ss7-filter-ruleset-list";
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
            
            NSString *no_values = _webRequest.params[@"no-values"];
            if([no_values isEqualToString:@"NO"])
            {
                NSMutableArray *gls = [[NSMutableArray alloc]init];
                NSArray *keys = [stagingArea.filter_rule_set_dict allKeys];
                for(NSString *k in keys)
                {
                    NSMutableArray *arr = [[NSMutableArray alloc]init];
                    UMSS7ConfigSS7FilterRuleset *ls = stagingArea.filter_rule_set_dict[k];
                    NSArray *rules = [ls getAllRules];
                    for(UMSS7ConfigSS7FilterRule *it in rules)
                    {
                        UMSynchronizedSortedDictionary *config = it.config;
                        [arr addObject:config];
                    }
                    [gls addObject:arr];
                }
                [self sendResultObject:gls];
                
            }
            else
            {
                NSArray<NSString *> *names = [stagingArea.filter_rule_set_dict allKeys];
                [self sendResultObject:names];
            }

		}
		@catch(NSException *e)
		{
			[self sendException:e];
		}
    }
	
}

@end

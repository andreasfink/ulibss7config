//
//  UMSS7ApiTaskSS7FilterRule_list.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterRule_list.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSS7FilterRule.h"
#import "UMSS7ConfigSS7FilterStagingArea.h"
#import "UMSS7ConfigSS7FilterRuleset.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskSS7FilterRule_list


+ (NSString *)apiPath
{
    return @"/api/ss7-filter-rule-list";
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
			// 2. Get Rule-Set
			NSString *ruleset_name = _webRequest.params[@"filter-ruleset"];
			UMSS7ConfigSS7FilterRuleset* rSet = stagingArea.filter_rule_set_dict[ruleset_name];
			
			// 3. Verify if rule-set exists
			if(rSet == NULL)
			{
				// 3a. Not found
				[self sendErrorNotFound:ruleset_name];
			}
			else
			{
				// 3b. Return Rules
				NSArray<UMSS7ConfigSS7FilterRule *> *rules = [rSet getAllRules];
				[self sendResultObject:rules];
			}
		}
		@catch(NSException *e)
		{
			[self sendException:e];
		}
    }
	
}

@end

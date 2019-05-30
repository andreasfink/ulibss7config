//
//  UMSS7ApiTaskSS7FilterRule_add.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterRule_add.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSS7FilterRule.h"
#import "UMSS7ConfigStagingAreaStorage.h"
#import "UMSS7ConfigSS7FilterRuleset.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskSS7FilterRule_add


+ (NSString *)apiPath
{
    return @"/api/ss7-filter-rule-add";
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
	UMSS7ConfigStagingAreaStorage *stagingArea = [_appDelegate getStagingAreaForSession:_apiSession.sessionKey];
	if(stagingArea == NULL)
    {
        [self sendErrorNotFound];
    }
    else
    {
		@try
		{
			// 1. Get All rule-sets from this staging area & scan them 
			NSString *ruleset_name = _webRequest.params[@"filter-ruleset"];
			UMSynchronizedDictionary* ruleSet = stagingArea.filter_rule_set_dict;
			NSArray *keys = [ruleSet allKeys];
			for(NSString *key in keys)
			{
				 UMSS7ConfigSS7FilterRuleset* rSet = ruleSet[key];
				 
				 // 2. If found append rule else skip
				 if(ruleset_name == rSet.name)
				 {
					  // 3. Create Rule from end-user input coming from outside
					 UMSS7ConfigSS7FilterRule* filterRule  = [[UMSS7ConfigSS7FilterRule alloc]initWithConfig:_webRequest.params];
					 
					 // 4. Append Rule
					 [rSet appendRule:filterRule];

					 // 5. Return result
					  UMSynchronizedSortedDictionary *config = filterRule.config;
					 [self sendResultObject:config];
				 } 
				 else
				 {
					 // skip
				 }
			}	 
		}
		@catch(NSException *e)
		{
			[self sendException:e];
		}
    }
}

@end

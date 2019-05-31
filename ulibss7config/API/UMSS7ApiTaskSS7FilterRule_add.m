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
			// 2. Get Engine  
			NSString *engine_name = _webRequest.params[@"engine"];
			UMPluginHandler *engine = [_appDelegate getSS7FilterEngineHandler:engine_name];
			
			// 3. Get Rule-Set 
			NSString *ruleset_name = _webRequest.params[@"filter-ruleset"];
			UMSS7ConfigSS7FilterRuleset* rSet = stagingArea.filter_rule_set_dict[ruleset_name];
			
			// 4. Verify if engine exists && rule-set exists
			if(engine == NULL || rSet == NULL)
			{
				[self sendErrorNotFound];
			}
			else
			{
				// 5. Create Rule from end-user input coming from outside
				UMSS7ConfigSS7FilterRule* filterRule  = [[UMSS7ConfigSS7FilterRule alloc]initWithConfig:_webRequest.params];	 
				NSString *idx = _webRequest.params[@"entry-nr"];
				if(idx == NULL)
				{
					// 5a. Append Rule
					[rSet appendRule:filterRule];
				}
				else
				{
					// 5b. Insert Rule
					NSInteger i = [idx integerValue];
					[rSet insertRule:filterRule atIndex:i];
				}

				// 6. Return result
				UMSynchronizedSortedDictionary *config = filterRule.config;
				[self sendResultObject:config];
			}
		}
		@catch(NSException *e)
		{
			[self sendException:e];
		}
    }
}

@end

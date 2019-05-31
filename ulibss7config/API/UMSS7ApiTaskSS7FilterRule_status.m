//
//  UMSS7ApiTaskSS7FilterRule_status.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterRule_status.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSS7FilterRule.h"
#import "UMSS7ConfigStagingAreaStorage.h"
#import "UMSS7ConfigSS7FilterRuleset.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskSS7FilterRule_status

+ (NSString *)apiPath
{
    return @"/api/ss7-filter-rule-status";
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
			
			// 4. Get index of rule
			NSString *idx = _webRequest.params[@"entry-nr"];
			
			// 5. Verify if engine, rule-set, rule exist
			if(engine == NULL || rSet == NULL || idx == NULL)
			{
				// 5a. Not found
				[self sendErrorNotFound];
			}
			else
			{
				// 5b. Get rule
				NSInteger i = [idx integerValue];
				UMSS7ConfigSS7FilterRule* filterRule = [rSet getRuleAtIndex:i];
				if(filterRule == NULL)
				{
				    // 5b-1. Rule not found
					[self sendErrorNotFound];
				}
				else
				{
					// 5b-2. OK
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

@end

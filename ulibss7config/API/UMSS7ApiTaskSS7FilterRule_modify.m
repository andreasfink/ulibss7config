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
#import "UMSS7ConfigStagingAreaStorage.h"
#import "UMSS7ConfigSS7FilterRuleset.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskSS7FilterRule_modify

+ (NSString *)apiPath
{
    return @"/api/ss7-filter-rule-modify";
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
        [self sendErrorNotFound:@"Staging-Area"];
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
			if(engine == NULL)
			{
				// 5a. Not found
				[self sendErrorNotFound:engine_name];
				
			}
			else if(rSet == NULL)
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
					UMSS7ConfigSS7FilterRule* newRule  = [[UMSS7ConfigSS7FilterRule alloc]initWithConfig:_webRequest.params];
					[rSet setRule:newRule atIndex:i];
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

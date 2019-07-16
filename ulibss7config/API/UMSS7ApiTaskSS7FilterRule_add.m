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
#import "UMSS7ConfigSS7FilterStagingArea.h"
#import "UMSS7ConfigSS7FilterRuleSet.h"
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
	
	UMSS7ConfigSS7FilterStagingArea *stagingArea = [_appDelegate getStagingAreaForSession:_apiSession];
	if(stagingArea == NULL)
    {
        [self sendErrorNotFound:@"Staging-Area"];
    }
    else
    {
		@try
		{
			// 1. Get Engine
			NSString *engine_name = _webRequest.params[@"engine"];
			UMPluginHandler *engine = [_appDelegate getSS7FilterEngineHandler:engine_name];
            
            // 2a. Get Engine config
            NSString *engine_config = _webRequest.params[@"engine-config"];
            
            // 2b. Get Engine config
            NSString *status = _webRequest.params[@"status"];
            
			// 3. Get Rule-Set 
			NSString *ruleset_name = _webRequest.params[@"filter-ruleset"];
			UMSS7ConfigSS7FilterRuleSet* rSet = stagingArea.filter_rule_set_dict[ruleset_name];
			
			// 4. Verify if engine exists && rule-set exists
			if(engine == NULL)
			{
				// 4a. Not found
				[self sendErrorNotFound:engine_name];
				
			}
            else if(engine_name == NULL)
            {
                // 4b. Not found
                [self sendErrorNotFound:@"engine"];
            }
            else if(engine_config == NULL)
            {
                // 4c. Not found
                [self sendErrorNotFound:@"engine-config"];
            }
            else if(status == NULL)
            {
                // 4c. Not found
                [self sendErrorNotFound:@"status"];
            }
			else if(rSet == NULL)
			{
				// 4d. Not found
				[self sendErrorNotFound:ruleset_name];
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
                [stagingArea setDirty:YES];
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

//
//  UMSS7ApiTaskSS7FilterRuleSet_action.m
//  ulibss7config
//
//  Created by Andreas Fink on 28.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterRuleSet_action.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSS7FilterRuleset.h"
#import "UMSS7ConfigSS7FilterStagingArea.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskSS7FilterRuleSet_action

+ (NSString *)apiPath
{
    return @"/api/ss7-filter-rule-set-action";
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
			NSString *name = _webRequest.params[@"name"];
			NSString *action = _webRequest.params[@"action"];
			UMSS7ConfigSS7FilterRuleset *rs = stagingArea.filter_rule_set_dict[name];
			if(rule_set_dict == NULL)
			{
				[self sendErrorNotFound:name];
			}
			else
			{
                /* we shoudl now call the live API to do some action for this object. */
                /* FIXME Andreas */
				[self sendResultOK];
			}
		}
		@catch(NSException *e)
		{
			[self sendException:e];
		}
    }
	
}
@end

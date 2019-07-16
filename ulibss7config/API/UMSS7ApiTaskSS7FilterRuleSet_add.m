//
//  UMSS7ApiTaskSS7FilterRuleSet_add.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterRuleSet_add.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSS7FilterRuleSet.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigSS7FilterStagingArea.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskSS7FilterRuleSet_add


+ (NSString *)apiPath
{
    return @"/api/ss7-filter-ruleset-add";
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

	// 1. call appDelegate getStagingAreaForSession:  to get current staging area storage.
	UMSS7ConfigSS7FilterStagingArea *stagingArea = [_appDelegate getStagingAreaForSession:_apiSession];
	if(stagingArea == NULL)
    {
        [self sendErrorNotFound:@"Staging-Area"];
    }
    else
    {
		@try
		{
			// 2. use filter_rule_set_dict property and add the ruleset to the dictionary with rulese.name as key
			UMSS7ConfigSS7FilterRuleSet *rule_set = [[UMSS7ConfigSS7FilterRuleSet alloc]initWithConfig:_webRequest.params];

            NSString *name = _webRequest.params[@"name"];
			stagingArea.filter_rule_set_dict[name] = rule_set;
            [stagingArea setDirty:YES];
			[self sendResultOK];
		}
		@catch(NSException *e)
		{
			[self sendException:e];
		}
    }
}

@end

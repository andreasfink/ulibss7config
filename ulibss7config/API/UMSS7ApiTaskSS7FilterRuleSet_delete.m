//
//  UMSS7ApiTaskSS7FilterRuleSet_delete.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterRuleSet_delete.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSS7FilterRuleset.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ApiSession.h"
#import "UMSS7ConfigSS7FilterStagingArea.h"

@implementation UMSS7ApiTaskSS7FilterRuleSet_delete


+ (NSString *)apiPath
{
    return @"/api/ss7-filter-ruleset-delete";
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
			NSString *name = _webRequest.params[@"name"];
            if(stagingArea.filter_rule_set_dict[name]== 0)
            {
                [self sendErrorNotFound:name];
            }
            else
            {
                [stagingArea.filter_rule_set_dict removeObjectForKey:name];
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

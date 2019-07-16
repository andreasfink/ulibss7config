//
//  UMSS7ApiTaskSS7FilterRuleSet_list.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterRuleSet_list.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSS7FilterRuleSet.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ApiSession.h"
#import "UMSS7ConfigSS7FilterStagingArea.h"

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
			NSArray<NSString *> *names = [stagingArea.filter_rule_set_dict allKeys];
			[self sendResultObject:names];
		}
		@catch(NSException *e)
		{
			[self sendException:e];
		}
    }
	
}

@end

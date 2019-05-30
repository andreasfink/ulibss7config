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
	
	UMSS7ConfigStagingAreaStorage *stagingArea = [_appDelegate runningConfig];
	UMSS7ConfigStorage *cs = [_appDelegate runningConfig];
	UMSS7ConfigM2PA *stagingArea = NULL;
    /* TODO : Add To AppDelegate a new method : getStagingArea
		UMSS7ConfigM2PA *stagingArea = [cs getStagingArea:name];
	*/
	if(stagingArea == NULL)
    {
        [self sendErrorNotFound];
    }
    else
    {
		@try
		{
			UMSS7ConfigSS7FilterRule* filterRule  = [[UMSS7ConfigSS7FilterRule alloc]initWithConfig:_webRequest.params];
			UMSynchronizedSortedDictionary *config = filterRule.config;
			/* TODO : Add to Staging Area
			[_appDelegate addFilterRuleToStagingArea:config.dictionaryCopy];
			*/
			[self sendResultObject:config];
		}
		@catch(NSException *e)
		{
			[self sendException:e];
		}
    }
}

@end

//
//  UMSS7ApiTaskSS7FilterActionList_action.m
//  ulibss7config
//
//  Created by Andreas Fink on 28.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterActionList_action.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSS7FilterStagingArea.h"
#import "UMSS7ConfigSS7FilterActionList.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskSS7FilterActionList_action


+ (NSString *)apiPath
{
    return @"/api/ss7-filter-action-list-action";
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
			//NSString *action = _webRequest.params[@"action"];
			UMSS7ConfigSS7FilterActionList *ls = stagingArea.filter_action_list_dict[name];
			if(ls == NULL)
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

//
//  UMSS7ApiTaskSS7FilterAction_read.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterAction_read.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSS7FilterRule.h"
#import "UMSS7ConfigStagingAreaStorage.h"
#import "UMSS7ConfigSS7FilterActionList.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskSS7FilterAction_read

+ (NSString *)apiPath
{
    return @"/api/ss7-filter-action-read";
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
	UMSS7ConfigStagingAreaStorage *stagingArea = [_appDelegate getStagingAreaForSession:_apiSession];
	if(stagingArea == NULL)
    {
        [self sendErrorNotFound:@"Staging-Area"];
    }
    else
    {
		@try
		{
			// 2. Get Action-List 
			NSString *name = _webRequest.params[@"filter-action-list"];
			UMSS7ConfigSS7FilterActionList* list = stagingArea.filter_action_list_dict[name];
			
			// 3. Get index of action
			NSString *idx = _webRequest.params[@"action"];
			
			// 4. Verify if action-list exists
			if(list == NULL)
			{
				// 4a. Not found
				[self sendErrorNotFound:name];
			}
			else if(idx == NULL)
			{
				// 4b. Not found
				[self sendErrorNotFound:@"Action Position"];
			}
			else
			{
				// 4c. Get action
				NSInteger i = [idx integerValue];
				UMSS7ConfigSS7FilterAction* action = [list getActionAtIndex:i];
				if(action == NULL)
				{
				    // 4c-1. Action not found
					[self sendErrorNotFound:@"Action"];
				}
				else
				{
					// 4c-2. return action
					[self sendResultObject:action];
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

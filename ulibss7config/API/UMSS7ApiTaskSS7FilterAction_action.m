//
//  UMSS7ApiTaskSS7FilterAction_action.m
//  ulibss7config
//
//  Created by Andreas Fink on 28.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterAction_action.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSS7FilterStagingArea.h"
#import "UMSS7ConfigSS7FilterActionList.h"
#import "UMSS7ConfigSS7FilterAction.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskSS7FilterAction_action


+ (NSString *)apiPath
{
    return @"/api/ss7-filter-action-action";
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
			// 2. Get Action-List 
            NSString *name = _params[@"filter-action-list"];
			UMSS7ConfigSS7FilterActionList* list = stagingArea.filter_action_list_dict[name];
			
			// 3. Get index of action
			NSString *idx = _params[@"entry-nr"];
            NSString *action = _params[@"action"];
            NSDictionary *d = [NSDictionary dictionary];
            
			// 4. Verify if action-list exists
			if(list == NULL)
			{
				// 4a. Not found
				[self sendErrorNotFound:name];
			}
            else if(idx.length==0)
            {
                d = @{@"error" : @"missing-parameter", @"reason" :@"the 'entry-nr' parameter is not passed"};
                [self sendError:[d jsonString]];
            }
            else if(action.length==0)
            {
                d = @{@"error" : @"missing-parameter", @"reason" :@"the action parameter is not passed"};
                [self sendError:[d jsonString]];
            }
			else
			{
				// 4c. Get action
				NSInteger i = [idx integerValue];
				UMSS7ConfigSS7FilterAction* action = [list getActionAtIndex:i];
				if(action == NULL)
				{
				    // 4c-1. Action not found
					[self sendErrorNotFound:@"entry-nr"];
				}
				else
				{
					// 4c-2. return action
					//UMSynchronizedSortedDictionary *conf = action.config;
					//[self sendResultObject:conf];
					/* we shoudl now call the live API to do some action for this object. */
					/* FIXME Andreas */
                    [stagingArea setDirty:YES];
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

//
//  UMSS7ApiTaskSS7FilterAction_status.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterAction_status.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSS7FilterRule.h"
#import "UMSS7ConfigSS7FilterStagingArea.h"
#import "UMSS7ConfigSS7FilterActionList.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskSS7FilterAction_status

+ (NSString *)apiPath
{
    return @"/api/ss7-filter-action-status";
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
			NSString *name = _webRequest.params[@"filter-action-list"];
			UMSS7ConfigSS7FilterActionList* list = stagingArea.filter_action_list_dict[name];
			
			// 3. Get index of action
			NSString *idx = _webRequest.params[@"entry-nr"];
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
			else
			{
				// 4c. Get action
				NSInteger i = [idx integerValue];
				UMSS7ConfigSS7FilterAction* action = [list getActionAtIndex:i];
				if(action == NULL)
				{
				    // 4c-1. Action not found
                    d = @{@"error" : @"not-found", @"reason" :@"this action is not found"};
                    [self sendError:[d jsonString]];
				}
				else
				{
					// 4c-2. return ok
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

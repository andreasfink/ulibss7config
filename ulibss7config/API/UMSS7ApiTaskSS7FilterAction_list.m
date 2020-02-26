//
//  UMSS7ApiTaskSS7FilterAction_list.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterAction_list.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSS7FilterRule.h"
#import "UMSS7ConfigSS7FilterStagingArea.h"
#import "UMSS7ConfigSS7FilterActionList.h"
#import "UMSS7ConfigSS7FilterAction.h"
#import "UMSS7ApiSession.h"


@implementation UMSS7ApiTaskSS7FilterAction_list

+ (NSString *)apiPath
{
    return @"/api/ss7-filter-action-list";
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

			// 3. Verify if action-list exists
			if(list == NULL)
			{
				// 3a. Not found
				[self sendErrorNotFound:name];
			}
			else
			{
				// 3b. list actions
				NSArray<UMSS7ConfigSS7FilterAction *> *actions = [list getAllActions];
                NSMutableArray *arr = [[NSMutableArray alloc]init];
                for(UMSS7ConfigSS7FilterAction *k in actions)
                {
                    UMSynchronizedSortedDictionary *config = k.config;
                    [arr addObject:config];
                }
				[self sendResultObject:arr];
			}
		}
		@catch(NSException *e)
		{
			[self sendException:e];
		}
    }
	
}

@end

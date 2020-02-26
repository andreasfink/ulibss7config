//
//  UMSS7ApiTaskSS7FilterActionList_read.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterActionList_read.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSS7FilterStagingArea.h"
#import "UMSS7ConfigSS7FilterActionList.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskSS7FilterActionList_read

+ (NSString *)apiPath
{
    return @"/api/ss7-filter-action-list-read";
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
			NSString *name = _params[@"name"];
			UMSS7ConfigSS7FilterActionList* list = stagingArea.filter_action_list_dict[name];

			// 3. Verify if action-list exists
            if(name.length==0)
            {
                [self sendError:@"missing-parameter"  reason:@"'name' parameter is not passed"];
            }
            else if(list == NULL)
			{
				// 3a. Not found
				[self sendErrorNotFound:name];
			}
			else
			{
				// 3b. return list
				[self sendResultObject:list.config];
			}
			
			[self sendResultObject:stagingArea.config];
			
		}
		@catch(NSException *e)
		{
			[self sendException:e];
		}
    }
	
}

@end

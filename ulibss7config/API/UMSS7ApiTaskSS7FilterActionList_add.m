//
//  UMSS7ApiTaskSS7FilterActionList_add.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterActionList_add.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSS7FilterStagingArea.h"
#import "UMSS7ConfigSS7FilterActionList.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskSS7FilterActionList_add


+ (NSString *)apiPath
{
    return @"/api/ss7-filter-action-list-add";
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
    
	// 1. Get Action-list external parameters
	NSString *name = _params[@"name"];

	// 2. call appDelegate getStagingAreaForSession:  to get current staging area storage.
	UMSS7ConfigSS7FilterStagingArea *stagingArea = [_appDelegate getStagingAreaForSession:_apiSession];
	if(stagingArea == NULL)
    {
        [self sendErrorNotFound:@"Staging-Area"];
    }
    else if(name.length==0)
    {
        [self sendError: @"missing-parameter" reason:@"'name' parameter is not passed"];
    }
    else
    {
		@try
		{
			// 3. use filter_action_list_dict property and add the list to the dictionary with list.name as key
			UMSS7ConfigSS7FilterActionList *list = [[UMSS7ConfigSS7FilterActionList alloc]initWithConfig:_params];
			stagingArea.filter_action_list_dict[name] = list;
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

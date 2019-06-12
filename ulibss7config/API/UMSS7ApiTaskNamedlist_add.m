//
//  UMSS7ApiTaskNamedlist_add.m
//  ulibss7config
//
//  Created by Andreas Fink on 28.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskNamedlist_add.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigSS7FilterStagingArea.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskNamedlist_add


+ (NSString *)apiPath
{
    return @"/api/namedlist-add";
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
    
	@try
	{
		// 1. Get external parameters
		NSString *listName = _webRequest.params[@"list"];
		NSString *value = _webRequest.params[@"value"];
		NSDictionary *d = [NSDictionary dictionary];
		if(listName.length==0)
		{
			d = @{@"error" : @"missing-parameter", @"reason" :@"the list parameter is not passed"}; 
			[self sendError:[d jsonString]];
		}
		else if(value.length==0)
		{
			d = @{@"error" : @"missing-parameter", @"reason" :@"the value parameter is not passed" };
			[self sendError:[d jsonString]];
		}
		else if([value isEqualToString:@"_dirty"])
		{
			d = @{@"error" : @"invalid-parameter", @"reason" :@"the value '_dirty' is a reserved value" };
			[self sendError:[d jsonString]];
		}
		else
		{
			// 2. call appDelegate getStagingAreaForSession:  to get current staging area storage.
			UMSS7ConfigSS7FilterStagingArea *stagingArea = [_appDelegate getStagingAreaForSession:_apiSession];
			if(stagingArea == NULL)
			{
				[self sendErrorNotFound:@"Staging-Area"];
			}
			else
			{
				// 3. adding
				[_appDelegate namedlist_add:listName value:value];
				[self sendResultOK];
			}
		}
	}
	@catch(NSException *e)
	{
		[self sendException:e];
	}
}
@end

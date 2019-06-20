//
//  UMSS7ApiTaskNamedlist_delete.m
//  ulibss7config
//
//  Created by Andreas Fink on 28.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskNamedlist_delete.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskNamedlist_delete


+ (NSString *)apiPath
{
    return @"/api/namedlist-remove";
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
		NSString *listName = _webRequest.params[@"name"];
        if(listName.length==0)
        {
            /* backwards compatibility to old api of SMSProx4 */
            listName = _webRequest.params[@"list"];
        }
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
			// 2. Remove if value is contained in list
			[_appDelegate namedlist_remove:listName value:value];
			[self sendResultOK];
		}
	}
	@catch(NSException *e)
	{
		[self sendException:e];
	}
	
}
@end

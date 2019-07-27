//
//  UMSS7ApiTaskNamedlist_read.m
//  ulibss7config
//
//  Created by Andreas Fink on 28.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskNamedlist_read.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskNamedlist_read


+ (NSString *)apiPath
{
    return @"/api/namedlist-read";
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
		NSString *listName = _params[@"name"];
        if(listName.length==0)
        {
            /* backwards compatibility to old api of SMSProx4 */
            listName = _params[@"list"];
        }

		NSDictionary *d = [NSDictionary dictionary];
		if(listName.length==0)
		{
			d = @{@"error" : @"missing-parameter", @"reason" :@"the list parameter is not passed"}; 
			[self sendError:[d jsonString]];
		}
		else
		{
			// 2. Read
			NSArray *ls = [_appDelegate namedlist_get:listName];
			[self sendResultObject:ls];
		}
	}
	@catch(NSException *e)
	{
		[self sendException:e];
	}
	
}
@end

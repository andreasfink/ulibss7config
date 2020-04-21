//
//  UMSS7ApiTaskNamedlist_lists.m
//  ulibss7config
//
//  Created by Andreas Fink on 12.06.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskNamedlist_lists.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskNamedlist_lists


+ (NSString *)apiPath
{
    return @"/api/namedlist-lists";
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
		// 1. list
		UMSynchronizedArray *names = [_appDelegate namedlist_lists];
		[self sendResultObject:names];
	}
	@catch(NSException *e)
	{
		[self sendException:e];
	}
}

@end

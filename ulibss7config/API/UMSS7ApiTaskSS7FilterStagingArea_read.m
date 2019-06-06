//
//  UMSS7ApiTaskSS7FilterStagingArea_read.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//
#import "UMSS7ApiTaskSS7FilterStagingArea_read.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSS7FilterStagingArea.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskSS7FilterStagingArea_read


+ (NSString *)apiPath
{
    return @"/api/ss7-filter-staging-area-read";
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
	_apiSession.currentStorageAreaName = _webRequest.params[@"name"];
	UMSS7ConfigSS7FilterStagingArea *stagingArea = [_appDelegate getStagingAreaForSession:_apiSession];
	if(stagingArea == NULL)
    {
        [self sendErrorNotFound:@"Staging-Area"];
    }
    else
    {
		@try
		{
			NSLog(@"[OUT: stagingArea.path] = %@",stagingArea.config);
			
			[self sendResultObject:stagingArea.config];
		}
		@catch(NSException *e)
		{
			[self sendException:e];
		}
    }
	
}
@end

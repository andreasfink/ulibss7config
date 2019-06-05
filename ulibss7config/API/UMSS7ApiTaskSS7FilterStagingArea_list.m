//
//  UMSS7ApiTaskSS7FilterStagingArea_list.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterStagingArea_list.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStagingAreaStorage.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskSS7FilterStagingArea_list


+ (NSString *)apiPath
{
    return @"/api/ss7-filter-staging-area-list";
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
	UMSS7ConfigStagingAreaStorage *stagingArea = [_appDelegate getStagingAreaForSession:_apiSession];
	if(stagingArea == NULL)
    {
        [self sendErrorNotFound:@"Staging-Area"];
    }
    else
    {
		@try
		{
			NSArray<NSString *> *areas = [_appDelegate getSS7FilterStagingAreaNames];
			[self sendResultObject:areas];
		}
		@catch(NSException *e)
		{
			[self sendException:e];
		}
    }
}
@end

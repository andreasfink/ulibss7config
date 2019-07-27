//
//  UMSS7ApiTaskSS7FilterStagingArea_status.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//
#import "UMSS7ApiTaskSS7FilterStagingArea_status.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSS7FilterStagingArea.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskSS7FilterStagingArea_status


+ (NSString *)apiPath
{
    return @"/api/ss7-filter-staging-area-status";
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
			NSString *name = _params[@"name"];
			NSArray<NSString *> *names = [_appDelegate getSS7FilterStagingAreaNames];
			BOOL exist = NO;
			for(NSString *n in names)
			{
				if([n isEqualToString:name])
				{
					exist = YES;
					break;
				}
			}
			
			if(exist)
			{
				[self sendResultOK];
			}
			else
			{
				[self sendErrorNotFound:name];
			}
		}
		@catch(NSException *e)
		{
			[self sendException:e];
		}
    }
}
@end

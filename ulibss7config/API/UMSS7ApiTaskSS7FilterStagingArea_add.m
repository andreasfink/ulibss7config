//
//  UMSS7ApiTaskSS7FilterStagingArea_add.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterStagingArea_add.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSS7FilterStagingArea.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskSS7FilterStagingArea_add


+ (NSString *)apiPath
{
    return @"/api/ss7-filter-staging-area-add";
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
	NSString *name = _params[@"name"];
	_apiSession.currentStorageAreaName = name;
	
	UMSS7ConfigSS7FilterStagingArea *stagingArea = [_appDelegate getStagingAreaForSession:_apiSession];
	if(stagingArea != NULL)
    {
        [self sendErrorAlreadyExisting];
    }
    else
    {
		@try
		{
			NSDictionary *d = [NSDictionary dictionary];
			if([name isEqualToString:@"current"])
			{
				d = @{@"error" : @"invalid-parameter", @"reason" :@"this name is not allowed"}; 
				[self sendError:[d jsonString]];
			}
            else if(name == NULL)
            {
                d = @{@"error" : @"missing-parameter", @"reason" :@"name is required"};
                [self sendError:[d jsonString]];
            }
			else
			{
				[_appDelegate createSS7FilterStagingArea:_params];

				[self sendResultOK];
			}
		}
		@catch(NSException *e)
		{
			[self sendException:e];
		}
    }
}
@end

//
//  UMSS7ApiTaskSS7FilterStagingArea_modify.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterStagingArea_modify.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSS7FilterStagingArea.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskSS7FilterStagingArea_modify


+ (NSString *)apiPath
{
    return @"/api/ss7-filter-staging-area-modify";
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
			NSString *old_name = _webRequest.params[@"name"];
			NSString *new_name = _webRequest.params[@"newname"];
            if(new_name != NULL)
            {
                [_appDelegate renameSS7FilterStagingArea:old_name newName:new_name];
                
                NSDictionary *ds = [[NSDictionary alloc] initWithDictionary:_webRequest.params];
                [ds setValue:new_name forKey:@"name"];
                [_appDelegate updateSS7FilterStagingArea:ds];
            }
            else
            {
                [_appDelegate updateSS7FilterStagingArea:_webRequest.params];
                 [stagingArea setDirty:YES];
            }
			[self sendResultOK];
		}
		@catch(NSException *e)
		{
			[self sendException:e];
		}
    }
	
}
@end

//
//  UMSS7ApiTaskSS7FilterLogFile_action.m
//  ulibss7config
//
//  Created by Andreas Fink on 28.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterLogFile_action.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ApiSession.h"


@implementation UMSS7ApiTaskSS7FilterLogFile_action


+ (NSString *)apiPath
{
    return @"/api/ss7-filter-logfile-action";
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
		NSString *name = _webRequest.params[@"name"];
		NSString *action = _webRequest.params[@"action"];
		NSDictionary *d = [NSDictionary dictionary];
		if(name.length==0)
		{
			d = @{@"error" : @"missing-parameter", @"reason" :@"the name parameter is not passed"}; 
			[self sendError:[d jsonString]];
		}
		else if(action.length==0)
		{
			d = @{@"error" : @"missing-parameter", @"reason" :@"the action parameter is not passed" };
			[self sendError:[d jsonString]];
		}
		else
		{
			// 2. Action
			[_appDelegate logfile_action:name action:action];
			[self sendResultOK];
		}
	}
	@catch(NSException *e)
	{
		[self sendException:e];
	}
	
}
@end

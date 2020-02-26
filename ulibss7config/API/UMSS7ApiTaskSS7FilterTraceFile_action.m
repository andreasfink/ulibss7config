//
//  UMSS7ApiTaskSS7FilterTraceFile_action.m
//  ulibss7config
//
//  Created by Andreas Fink on 28.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterTraceFile_action.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ApiSession.h"


@implementation UMSS7ApiTaskSS7FilterTraceFile_action


+ (NSString *)apiPath
{
    return @"/api/ss7-filter-tracefile-action";
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
		NSString *name = _params[@"name"];
		NSString *action = _params[@"action"];
		if(name.length==0)
		{
			[self sendError:@"missing-parameter" reason:@"the 'name' parameter is not passed"];
		}
		else if(action.length==0)
		{
            [self sendError:@"missing-parameter" reason:@"the 'action' parameter is not passed"];
		}
		else
		{
			// 2. Action
			[_appDelegate tracefile_action:name action:action];
			[self sendResultOK];
		}
	}
	@catch(NSException *e)
	{
		[self sendException:e];
	}
	
}
@end

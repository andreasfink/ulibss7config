//
//  UMSS7ApiTaskSS7FilterTraceFile_modify.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterTraceFile_modify.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskSS7FilterTraceFile_modify

+ (NSString *)apiPath
{
    return @"/api/ss7-filter-tracefile-modify";
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
		NSString *enable = _params[@"enabled"];
		if(name.length==0)
		{
            [self sendError:@"missing-parameter" reason:@"the name parameter is not passed"];
		}
		else if(enable.length==0)
		{
            [self sendError:@"missing-parameter" reason:@"the enabled parameter is not passed"];
		}
		else
		{
			// 2. Enable
			NSString *enable = _params[@"enable"];
			BOOL en = [enable boolValue];
			
			[_appDelegate tracefile_enable:name enable:en];
			[self sendResultOK];
		}
	}
	@catch(NSException *e)
	{
		[self sendException:e];
	}
	
}

@end

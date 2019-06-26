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
    return @"/api/ss7-filter-logfile-modify";
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
		NSString *enable = _webRequest.params[@"enable"];
		NSDictionary *d = [NSDictionary dictionary];
		if(name.length==0)
		{
			d = @{@"error" : @"missing-parameter", @"reason" :@"the name parameter is not passed"}; 
			[self sendError:[d jsonString]];
		}
		else if(enable.length==0)
		{
			d = @{@"error" : @"missing-parameter", @"reason" :@"the enable parameter is not passed" };
			[self sendError:[d jsonString]];
		}
		else
		{
			// 2. Enable
			NSString *enable = _webRequest.params[@"enable"];
			BOOL en = [enable boolValue];
			
			[_appDelegate logfile_enable:name enable:en];
			[self sendResultOK];
		}
	}
	@catch(NSException *e)
	{
		[self sendException:e];
	}
	
}

@end

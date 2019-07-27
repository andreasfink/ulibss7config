//
//  UMSS7ApiTaskSS7FilterTraceFile_read.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterTraceFile_read.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ApiSession.h"
#import "UMSS7ConfigSS7FilterTraceFile.h"

@implementation UMSS7ApiTaskSS7FilterTraceFile_read

+ (NSString *)apiPath
{
    return @"/api/ss7-filter-tracefile-read";
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
		NSDictionary *d = [NSDictionary dictionary];
		if(name.length==0)
		{
			d = @{@"error" : @"missing-parameter", @"reason" :@"the 'name' parameter is not passed"};
			[self sendError:[d jsonString]];
		}
		else
		{
			// 2. Read
			UMSS7ConfigSS7FilterTraceFile *log = [_appDelegate tracefile_get:name];
			[self sendResultObject:log.config];
		}
	}
	@catch(NSException *e)
	{
		[self sendException:e];
	}
	
}

@end

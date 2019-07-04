//
//  UMSS7ApiTaskSS7FilterTraceFile_add.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterTraceFile_add.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ApiSession.h"
#import "UMSS7ConfigSS7FilterTraceFile.h"

@implementation UMSS7ApiTaskSS7FilterTraceFile_add

+ (NSString *)apiPath
{
    return @"/api/ss7-filter-tracefile-add";
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
		NSString *file = _webRequest.params[@"filename"];
		NSDictionary *d = [NSDictionary dictionary];
		if(name.length==0)
		{
			d = @{@"error" : @"missing-parameter", @"reason" :@"the 'name' parameter is not passed"}; 
			[self sendError:[d jsonString]];
		}
		else if(file.length==0)
		{
			d = @{@"error" : @"missing-parameter", @"reason" :@"the 'filename' parameter is not passed" };
			[self sendError:[d jsonString]];
		}
		else
		{
			// 2. adding
            UMSS7ConfigSS7FilterTraceFile *traceFile = [[UMSS7ConfigSS7FilterTraceFile alloc]initWithConfig:_webRequest.params];
            UMSynchronizedSortedDictionary *config = traceFile.config;
            [_appDelegate logfile_add:config];
            [self sendResultObject:config];
            
		}
	}
	@catch(NSException *e)
	{
		[self sendException:e];
	}
}

@end

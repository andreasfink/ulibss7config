//
//  UMSS7ApiTaskSS7FilterLogFile_add.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterLogFile_add.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskSS7FilterLogFile_add

+ (NSString *)apiPath
{
    return @"/api/ss7-filter-logfile-add";
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
		NSString *file = _webRequest.params[@"file"];
		NSDictionary *d = [NSDictionary dictionary];
		if(name.length==0)
		{
			d = @{@"error" : @"missing-parameter", @"reason" :@"the name parameter is not passed"}; 
			[self sendError:[d jsonString]];
		}
		else if(file.length==0)
		{
			d = @{@"error" : @"missing-parameter", @"reason" :@"the file parameter is not passed" };
			[self sendError:[d jsonString]];
		}
		else
		{
			// 2. adding
			NSString *format = _webRequest.params[@"format"];
			NSString *enable = _webRequest.params[@"enable"];
			NSString *minutes = _webRequest.params[@"rotate-minutes"];
			NSString *packets = _webRequest.params[@"rotate-packets"];
			
			NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
			f.numberStyle = NSNumberFormatterNoStyle;
			
			NSNumber *min = [f numberFromString:minutes];
			NSNumber *pack = [f numberFromString:packets];
			BOOL en = [enable boolValue];

			[_appDelegate logfile_add:name file:file format:format rotate_minutes:min rotate_packets:pack enable:en];
			[self sendResultOK];
		}
	}
	@catch(NSException *e)
	{
		[self sendException:e];
	}
}

@end

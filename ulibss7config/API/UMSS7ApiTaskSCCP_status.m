//
//  UMSS7ApiTaskSCCP_status.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSCCP_status.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStorage.h"
#import <ulibsccp/ulibsccp.h>

@implementation UMSS7ApiTaskSCCP_status

+ (NSString *)apiPath
{
    return @"/api/sccp-status";
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
	
	NSString *name = _webRequest.params[@"name"];
	name = [UMSS7ConfigObject filterName:name];
	UMLayerSCCP *sccp = [_appDelegate getSCCP:name];
	
	if(sccp)
	{
		UMSynchronizedSortedDictionary *dict = [sccp statisticalInfo];
        NSString *json = [dict jsonString];
        NSLog(@"%@",json);
		[self sendResultObject:dict];
	}
	else
	{
		[self sendErrorNotFound];
	}
}
@end

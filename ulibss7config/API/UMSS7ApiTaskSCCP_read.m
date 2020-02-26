//
//  UMSS7ApiTaskSCCP_read.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSCCP_read.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigSCCP.h"

@implementation UMSS7ApiTaskSCCP_read

+ (NSString *)apiPath
{
    return @"/api/sccp-read";
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

    NSString *name = _params[@"name"];
    UMSS7ConfigStorage *cs = [_appDelegate runningConfig];
    UMSS7ConfigSCCP *obj = [cs getSCCP:name];
    if(obj)
    {
        [self sendResultObject:obj.config];
    }
    else
    {
        [self sendErrorNotFound];
    }
}

@end



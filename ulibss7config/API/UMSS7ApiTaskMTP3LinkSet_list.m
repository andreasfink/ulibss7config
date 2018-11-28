//
//  UMSS7ApiTaskMTP3LinkSet_list.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskMTP3LinkSet_list.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"

@implementation UMSS7ApiTaskMTP3LinkSet_list

+ (NSString *)apiPath
{
    return @"/api/mtp3-linkset-list";
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

    UMSS7ConfigStorage *cs = [_appDelegate runningConfig];
    NSArray *names = [cs getMTP3LinkSetNames];
    [self sendResultObject:names];
}

@end


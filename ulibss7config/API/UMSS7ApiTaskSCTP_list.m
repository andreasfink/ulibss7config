//
//  UMSS7ApiTaskSCTP_list.m
//  estp
//
//  Created by Andreas Fink on 12.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSCTP_list.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"

@implementation UMSS7ApiTaskSCTP_list

+ (NSString *)apiPath
{
    return @"/api/sctp-list";
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
    NSArray *names = [cs getSCTPNames];
    [self sendResultObject:names];
}

@end

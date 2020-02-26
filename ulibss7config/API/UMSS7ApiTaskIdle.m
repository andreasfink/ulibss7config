//
//  UMSS7ApiTaskIdle.m
//  ulibss7config
//
//  Created by Andreas Fink on 12.11.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskIdle.h"

@implementation UMSS7ApiTaskIdle


+ (NSString *)apiPath
{
    return @"/api/idle";
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
    [self sendResultOK];
}

@end

//
//  UMSS7ApiTaskNamedlist_contains.m
//  ulibss7config
//
//  Created by Andreas Fink on 12.06.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskNamedlist_contains.h"

@implementation UMSS7ApiTaskNamedlist_contains


+ (NSString *)apiPath
{
    return @"/api/namedlist-contains";
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
    [self sendErrorNotImplemented];
}
@end

//
//  UMSS7ApiTaskNamedlist_delete.m
//  ulibss7config
//
//  Created by Andreas Fink on 28.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskNamedlist_delete.h"

@implementation UMSS7ApiTaskNamedlist_delete


+ (NSString *)apiPath
{
    return @"/api/namedlist-delete";
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

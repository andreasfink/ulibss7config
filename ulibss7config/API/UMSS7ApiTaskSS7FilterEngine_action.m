//
//  UMSS7ApiTaskSS7FilterEngine_action.m
//  ulibss7config
//
//  Created by Andreas Fink on 29.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterEngine_action.h"

@implementation UMSS7ApiTaskSS7FilterEngine_action

+ (NSString *)apiPath
{
    return @"/api/ss7-filter-engine-action";
}

- (void)main
{
    @autoreleasepool
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
}

@end

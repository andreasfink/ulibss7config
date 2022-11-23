//
//  UMSS7ApiTaskSS7FilterEngine_status.m
//  ulibss7config
//
//  Created by Andreas Fink on 29.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterEngine_status.h"

@implementation UMSS7ApiTaskSS7FilterEngine_status

+ (NSString *)apiPath
{
    return @"/api/ss7-filter-engine-status";
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

        if(![self isAuthorised])
        {
            [self sendErrorNotAuthorised];
            return;
        }
        [self sendErrorNotImplemented];
    }
}


@end

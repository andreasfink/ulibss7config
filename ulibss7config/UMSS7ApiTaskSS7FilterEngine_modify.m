//
//  UMSS7ApiTaskSS7FilterEngine_modify.m
//  ulibss7config
//
//  Created by Andreas Fink on 29.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterEngine_modify.h"

@implementation UMSS7ApiTaskSS7FilterEngine_modify

+ (NSString *)apiPath
{
    return @"/api/ss7-filter-engine-modify";
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

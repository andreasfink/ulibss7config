//
//  UMSS7ApiTaskSS7FilterEngine_list.m
//  ulibss7config
//
//  Created by Andreas Fink on 29.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterEngine_list.h"

@implementation UMSS7ApiTaskSS7FilterEngine_list


+ (NSString *)apiPath
{
    return @"/api/ss7-filter-engine-list";
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
        NSArray *arr = [_appDelegate getSS7FilterEngineNames];
        [self sendResultObject:arr];
    }
}

@end

//
//  UMSS7ApiTaskStatistics_status.m
//  ulibss7config
//
//  Created by Andreas Fink on 07.08.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskStatistics_status.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ApiSession.h"


@implementation UMSS7ApiTaskStatistics_status

+ (NSString *)apiPath
{
    return @"/api/statistics-status";
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


//
//  UMSS7ApiTaskStatistics_status.m
//  ulibss7config
//
//  Created by Andreas Fink on 07.08.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskStatistics_status.h"
#import <ulibss7config/UMSS7ConfigObject.h>
#import "UMSS7ConfigStorage.h"
#import <ulibss7config/UMSS7ConfigAppDelegateProtocol.h>
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

        if(![self isAuthorised])
        {
            [self sendErrorNotAuthorised];
            return;
        }

        [self sendErrorNotImplemented];
    }
}

@end


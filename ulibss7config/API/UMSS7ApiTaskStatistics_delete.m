//
//  UMSS7ApiTaskStatistics_delete.m
//  ulibss7config
//
//  Created by Andreas Fink on 05.07.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskStatistics_delete.h"
#import <ulibss7config/UMSS7ConfigObject.h>
#import "UMSS7ConfigStorage.h"
#import <ulibss7config/UMSS7ConfigAppDelegateProtocol.h>
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskStatistics_delete


+ (NSString *)apiPath
{
    return @"/api/statistics-delete";
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

        @try
        {
            [self sendErrorNotImplemented];
        }
        @catch(NSException *e)
        {
            [self sendException:e];
        }
    }
}

@end


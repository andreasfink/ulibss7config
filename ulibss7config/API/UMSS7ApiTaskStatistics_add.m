//
//  UMSS7ApiTaskStatistics_add.m
//  ulibss7config
//
//  Created by Andreas Fink on 05.07.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskStatistics_add.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskStatistics_add

+ (NSString *)apiPath
{
    return @"/api/statistics-add";
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

    @try
    {
        // 1. Get external parameters
        NSString *statisticsName = _params[@"name"];


        if(statisticsName.length==0)
        {
            [self sendErrorMissingParameter:@"name"];
        }
        else
        {
            // 2. adding
            [_appDelegate statistics_add:statisticsName params:_webRequest.params];
            [self sendResultOK];
        }
    }
    @catch(NSException *e)
    {
        [self sendException:e];
    }
}
@end

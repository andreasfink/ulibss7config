//
//  UMSS7ApiTaskStatistics_modify.m
//  ulibss7config
//
//  Created by Andreas Fink on 07.08.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskStatistics_modify.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskStatistics_modify


+ (NSString *)apiPath
{
    return @"/api/statistics-modify";
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
        NSString *statisticsName = _params[@"name"];
        NSString *statisticsKey  = _params[@"key"];
        NSString *b = _params[@"no-values"];
        BOOL noValues = [b boolValue];
#pragma unused(statisticsKey)
#pragma unused(noValues)

        if(statisticsName.length==0)
        {
            [self sendErrorMissingParameter:statisticsName];
        }
        else
        {
            UMStatistic *stat = [_appDelegate statistics_get:statisticsName];
            if(stat==NULL)
            {
                [self sendErrorNotFound];
            }
            else
            {
                [_appDelegate statistics_modify:_name params:_params];
                [self sendResultOK];
            }
        }
    }
    @catch(NSException *e)
    {
        [self sendException:e];
    }

}

@end


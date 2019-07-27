//
//  UMSS7ApiTaskStatistics_read.m
//  ulibss7config
//
//  Created by Andreas Fink on 05.07.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskStatistics_read.h"

#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskStatistics_read

+ (NSString *)apiPath
{
    return @"/api/statistics-read";
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
        NSString *statisticsKey = _params[@"key"];
        NSString *b = _params[@"no-values"];
        BOOL noValues = [b boolValue];

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
                id result;

                if(noValues == YES)
                {
                    result = [stat getStatistic];
                }
                else
                {
                    if(statisticsKey.length> 0)
                    {
                        result = [stat getStatisticForKey:statisticsKey];
                    }
                    else
                    {
                        result = [stat getStatistics];
                    }
                }
                if(result==NULL)
                {
                    [self sendErrorNotFound];
                }
                else
                {
                    [self sendResultObject:result];
                }
            }
        }
    }
    @catch(NSException *e)
    {
        [self sendException:e];
    }

}

@end


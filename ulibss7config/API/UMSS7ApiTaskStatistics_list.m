//
//  UMSS7ApiTaskStatistics_list.m
//  ulibss7config
//
//  Created by Andreas Fink on 05.07.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskStatistics_list.h"

@implementation UMSS7ApiTaskStatistics_list



+ (NSString *)apiPath
{
    return @"/api/statistics-list";
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
    NSArray *arr = [_appDelegate getStatisticsNames];
    [self sendResultObject:arr];
}

@end

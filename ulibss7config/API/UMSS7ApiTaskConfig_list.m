//
//  UMSS7ApiTaskConfig_list.m
//  ulibss7config
//
//  Created by Andreas Fink on 07.02.2020.
//  Copyright © 2020 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskConfig_list.h"
#import "UMSS7ConfigStorage.h"

@implementation UMSS7ApiTaskConfig_list

+ (NSString *)apiPath
{
    return @"/api/config-list";
}

- (void)main
{
    if(![self isAuthenticated])
    {
        [self sendErrorNotAuthenticated];
        return;
    }

    UMSS7ConfigStorage *cs = [_appDelegate runningConfig];
    [self sendResultObject:[cs fullConfigOjbect]];
}

@end


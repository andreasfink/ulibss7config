//
//  UMSS7ApiTaskSS7FilterStagingArea_list.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterStagingArea_list.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSS7FilterStagingArea.h"
#import "UMSS7ConfigStorage.h"

@implementation UMSS7ApiTaskSS7FilterStagingArea_list


+ (NSString *)apiPath
{
    return @"/api/ss7-filter-staging-area-list";
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
    [self sendErrorNotImplemented];
}
@end

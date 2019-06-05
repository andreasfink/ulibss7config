//
//  UMSS7ApiTaskSS7FilterRule_action.m
//  ulibss7config
//
//  Created by Andreas Fink on 28.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterRule_action.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStagingAreaStorage.h"
#import "UMSS7ConfigStorage.h"


@implementation UMSS7ApiTaskSS7FilterRule_action


+ (NSString *)apiPath
{
    return @"/api/ss7-filter-rule-action";
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

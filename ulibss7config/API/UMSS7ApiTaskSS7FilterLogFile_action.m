//
//  UMSS7ApiTaskSS7FilterLogFile_action.m
//  ulibss7config
//
//  Created by Andreas Fink on 28.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterLogFile_action.h"

@implementation UMSS7ApiTaskSS7FilterLogFile_action


+ (NSString *)apiPath
{
    return @"/api/ss7-filter-logfile-action";
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

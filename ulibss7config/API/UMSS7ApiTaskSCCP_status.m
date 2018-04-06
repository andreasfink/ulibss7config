//
//  UMSS7ApiTaskSCCP_status.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSCCP_status.h"

@implementation UMSS7ApiTaskSCCP_status

+ (NSString *)apiPath
{
    return @"/api/sccp-status";
}

- (void)main
{
    if(![self isAuthenticated])
    {
        [self sendErrorNotAuthenticated];
        return;
    }
}
@end

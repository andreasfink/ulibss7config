//
//  UMSS7ApiTaskLogout.m
//  estp
//
//  Created by Andreas Fink on 15.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskLogout.h"

@implementation UMSS7ApiTaskLogout


+ (NSString *)apiPath
{
    return @"/api/logout";
}

- (void)main
{
    if(![self isAuthenticated])
    {
        [self sendErrorNotAuthenticated];
        return;
    }
    return [self sendResultOK];
}
@end

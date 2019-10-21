//
//  UMSS7ApiTaskM2PA_list.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskM2PA_list.h"
#import "UMSS7ConfigStorage.h"

@implementation UMSS7ApiTaskM2PA_list

+ (NSString *)apiPath
{
    return @"/api/m2pa-list";
}

- (void)main
{
    if(![self isAuthenticated])
    {
        [self sendErrorNotAuthenticated];
        return;
    }

    UMSS7ConfigStorage *cs = [_appDelegate runningConfig];
    NSArray *names = [cs getM2PANames];

    [self sendResultObject:names];
}

@end

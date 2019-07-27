//
//  UMSS7ApiTaskM2PA_read.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskM2PA_read.h"
#import "UMSS7ConfigAppDelegateProtocol.h"

#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigM2PA.h"

@implementation UMSS7ApiTaskM2PA_read

+ (NSString *)apiPath
{
    return @"/api/m2pa-read";
}

- (void)main
{
    if(![self isAuthenticated])
    {
        [self sendErrorNotAuthenticated];
        return;
    }

    NSString *name = _params[@"name"];
    UMSS7ConfigStorage *cs = [_appDelegate runningConfig];
    UMSS7ConfigM2PA *obj = [cs getM2PA:name];
    if(obj)
    {
        [self sendResultObject:obj.config];
    }
    else
    {
        [self sendErrorNotFound];
    }
}


@end


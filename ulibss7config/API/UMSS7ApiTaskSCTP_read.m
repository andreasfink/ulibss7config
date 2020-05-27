//
//  UMSS7ApiTaskSCTP_read.m
//  estp
//
//  Created by Andreas Fink on 12.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSCTP_read.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigSCTP.h"

@implementation UMSS7ApiTaskSCTP_read

+ (NSString *)apiPath
{
    return @"/api/sctp-read";
}

- (void)main
{
    @autoreleasepool
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

        NSString *name = _params[@"name"];
        name = [UMSS7ConfigObject filterName:name];
        UMSS7ConfigStorage *cs = [_appDelegate runningConfig];
        UMSS7ConfigSCTP *obj = [cs getSCTP:name];
        if(obj)
        {
            [self sendResultObject:obj.config];
        }
        else
        {
            [self sendErrorNotFound];
        }
    }
}


@end

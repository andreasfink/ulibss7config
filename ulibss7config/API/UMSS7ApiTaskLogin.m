//
//  UMSS7ApiTaskLogin.m
//  estp
//
//  Created by Andreas Fink on 15.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskLogin.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigAdminUser.h"

#import "UMSS7ApiSession.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigApiUser.h"

@implementation UMSS7ApiTaskLogin

+ (NSString *)apiPath
{
    return @"/api/login";
}

- (void)main
{
    @autoreleasepool
    {
        NSString *username = _params[@"username"];
        NSString *password = _params[@"password"];
        UMSS7ConfigApiUser *user = [_appDelegate.runningConfig getApiUser:username];
        if(user)
        {
            if([password isEqualToString:user.password])
            {
                UMSS7ApiSession *session = [[UMSS7ApiSession alloc]initWithHttpRequest:_webRequest user:user];
                [_appDelegate addApiSession:session];
                [self sendResultObject:session.sessionKey];
            }
            else
            {
                return [self sendErrorNotAuthenticated];
            }
        }
        else
        {
            return [self sendErrorNotAuthenticated];
        }
    }
}

@end


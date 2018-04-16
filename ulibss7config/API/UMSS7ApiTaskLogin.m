//
//  UMSS7ApiTaskLogin.m
//  estp
//
//  Created by Andreas Fink on 15.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskLogin.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigUser.h"

#import "UMSS7ApiSession.h"
#import "UMSS7ConfigAppDelegateProtocol.h"

@implementation UMSS7ApiTaskLogin

+ (NSString *)apiPath
{
    return @"/api/login";
}

- (void)main
{
    NSString *username = _webRequest.params[@"username"];
    NSString *password = _webRequest.params[@"password"];
    UMSS7ConfigUser *user = [_appDelegate.runningConfig getUser:username];
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

@end


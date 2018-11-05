//
//  UMSS7ApiTaskServiceUser_action.m
//  ulibss7config
//
//  Created by Andreas Fink on 08.05.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskServiceUser_action.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigServiceUser.h"

@implementation UMSS7ApiTaskServiceUser_action


+ (NSString *)apiPath
{
    return @"/api/serviceuser-read";
}

- (void)main
{
    if(![self isAuthenticated])
    {
        [self sendErrorNotAuthenticated];
        return;
    }

    NSString *name = _webRequest.params[@"name"];
    name = [UMSS7ConfigObject filterName:name];
    UMSS7ConfigStorage *cs = [_appDelegate runningConfig];
    UMSS7ConfigServiceUser *obj = [cs getServiceUser:name];
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

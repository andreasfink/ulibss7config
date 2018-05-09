//
//  UMSS7ApiTaskSMSCUser_action.m
//  ulibss7config
//
//  Created by Andreas Fink on 08.05.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSMSCUser_action.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigSMSCUser.h"

@implementation UMSS7ApiTaskSMSCUser_action


+ (NSString *)apiPath
{
    return @"/api/smscuser-read";
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
    UMSS7ConfigSMSCUser *obj = [cs getSMSCUser:name];
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

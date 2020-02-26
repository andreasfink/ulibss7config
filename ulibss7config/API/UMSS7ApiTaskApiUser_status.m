//
//  UMSS7ApiTaskApiUser_status.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskApiUser_status.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigApiUser.h"
#import "UMSS7ConfigStorage.h"

@implementation UMSS7ApiTaskApiUser_status



+ (NSString *)apiPath
{
    return @"/api/apiuser-status";
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

    NSString *name = _params[@"name"];
    name = [UMSS7ConfigObject filterName:name];
    UMSS7ConfigStorage *cs = [_appDelegate runningConfig];
    UMSS7ConfigApiUser *usr = [cs getApiUser:name];
    if(usr==NULL)
    {
        [self sendErrorNotFound];
    }
    else
    {
        UMSynchronizedSortedDictionary *config = usr.config;
        [self sendResultObject:config];
    }
}

@end

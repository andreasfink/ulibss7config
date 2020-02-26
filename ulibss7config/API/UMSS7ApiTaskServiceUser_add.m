//
//  UMSS7ApiTaskServiceUser_add.m
//  ulibss7config
//
//  Created by Andreas Fink on 08.05.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskServiceUser_add.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigServiceUser.h"
#import "UMSS7ConfigStorage.h"

@implementation UMSS7ApiTaskServiceUser_add

+ (NSString *)apiPath
{
    return @"/api/serviceuser-add";
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
    UMSS7ConfigServiceUser *usr = [cs getServiceUser:name];
    if(usr!=NULL)
    {
        [self sendErrorAlreadyExisting];
    }
    else
    {
        @try
        {
            [cs addServiceUser:usr];
            UMSynchronizedSortedDictionary *config = usr.config;
            [self sendResultObject:config];
        }
        @catch(NSException *e)
        {
            [self sendException:e];
        }
    }
}

@end

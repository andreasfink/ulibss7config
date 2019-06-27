//
//  UMSS7ApiTaskApiUser_add.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskApiUser_add.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigApiUser.h"
#import "UMSS7ConfigStorage.h"

@implementation UMSS7ApiTaskApiUser_add


+ (NSString *)apiPath
{
    return @"/api/apiuser-add";
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

    NSString *name = _webRequest.params[@"name"];
    name = [UMSS7ConfigObject filterName:name];
    UMSS7ConfigStorage *cs = [_appDelegate runningConfig];
    UMSS7ConfigApiUser *usr = [cs getApiUser:name];
    if(usr!=NULL)
    {
        [self sendErrorAlreadyExisting];
    }
    else
    {
        @try
        {
            UMSS7ConfigApiUser *usr = [[UMSS7ConfigApiUser alloc] initWithConfig:_webRequest.params];
            [cs addApiUser:usr];
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

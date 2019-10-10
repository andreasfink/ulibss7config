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

    NSString *name = _params[@"name"];
    NSString *pwd = _params[@"password"];
    name = [UMSS7ConfigObject filterName:name];
    UMSS7ConfigStorage *cs = [_appDelegate runningConfig];
    UMSS7ConfigApiUser *usr = [cs getApiUser:name];
    NSDictionary *d = [NSDictionary dictionary];
    if(usr!=NULL)
    {
        [self sendErrorAlreadyExisting];
    }
    else if(name.length==0)
    {
        [self sendError:@"missing-parameter" reason:@"'name' parameter is not passed"];
    }
    else if(pwd.length==0)
    {
        [self sendError:@"missing-parameter" reason:@"'password' parameter is not passed"];

    }
    else
    {
        @try
        {
            UMSS7ConfigApiUser *usr = [[UMSS7ConfigApiUser alloc] initWithConfig:_params];
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

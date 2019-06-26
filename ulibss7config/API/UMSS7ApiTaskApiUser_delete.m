//
//  UMSS7ApiTaskApiUser_delete.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskApiUser_delete.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigApiUser.h"
#import "UMSS7ConfigStorage.h"

@implementation UMSS7ApiTaskApiUser_delete

+ (NSString *)apiPath
{
    return @"/api/apiuser-delete";
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
    NSDictionary *d = [NSDictionary dictionary];
    if(usr==NULL)
    {
        [self sendErrorNotFound];
    }
    else if([name isEqualToString:usr.name])
    {
        d = @{@"error" : @"invalid-parameter", @"reason" :@"current user is not allowed to be deleted"};
        [self sendError:[d jsonString]];
    }
    else
    {
        [cs deleteApiUser:name];
        [self sendResultOK];
    }
}

@end


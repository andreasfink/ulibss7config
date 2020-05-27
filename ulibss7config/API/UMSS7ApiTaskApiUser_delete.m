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
#import "UMSS7ApiSession.h"

@implementation UMSS7ApiTaskApiUser_delete

+ (NSString *)apiPath
{
    return @"/api/apiuser-delete";
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
        UMSS7ConfigApiUser *usr = [cs getApiUser:name];
        NSUInteger users = [[cs getApiUserNames] count];
        UMSS7ConfigApiUser *currentUser = _apiSession.currentUser;
        if(usr==NULL)
        {
            [self sendErrorNotFound];
        }
        else if([name isEqualToString:currentUser.name])
        {
            [self sendError: @"invalid-parameter" reason: @"current user is not allowed to be deleted"];
        }
        else if(users < 2)
        {
            [self sendError: @"invalid-parameter" reason: @"system has only 1 user and can't be deleted"];
        }
        else
        {
            [cs deleteApiUser:name];
            [self sendResultOK];
        }
    }
}

@end


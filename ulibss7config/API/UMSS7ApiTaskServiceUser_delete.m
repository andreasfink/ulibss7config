//
//  UMSS7ApiTaskServiceUser_delete.m
//  ulibss7config
//
//  Created by Andreas Fink on 08.05.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskServiceUser_delete.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigServiceUser.h"
#import "UMSS7ConfigStorage.h"

@implementation UMSS7ApiTaskServiceUser_delete

+ (NSString *)apiPath
{
    return @"/api/serviceuser-delete";
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

        if(![self isAuthorised])
        {
            [self sendErrorNotAuthorised];
            return;
        }

        NSString *name = _params[@"name"];
        name = [UMSS7ConfigObject filterName:name];
        UMSS7ConfigStorage *cs = [_appDelegate runningConfig];
        UMSS7ConfigServiceUser *usr = [cs getServiceUser:name];
        if(usr==NULL)
        {
            [self sendErrorNotFound];
        }
        else
        {
            [cs deleteServiceUser:name];
            [self sendResultOK];
        }
    }
}

@end


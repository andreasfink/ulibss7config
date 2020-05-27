//
//  UMSS7ApiTaskApiUser_modify.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskApiUser_modify.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigApiUser.h"
#import "UMSS7ConfigStorage.h"

@implementation UMSS7ApiTaskApiUser_modify



+ (NSString *)apiPath
{
    return @"/api/apiuser-modify";
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
        UMSS7ConfigApiUser *config_object = [cs getApiUser:name];
        if(config_object==NULL)
        {
            [self sendErrorNotFound];
        }
        else
        {
            [config_object setConfig:_params];
            NSDictionary *config = config_object.config.dictionaryCopy;
            if(config_object.nameChanged)
            {
                [cs deleteApiUser:name];
                [cs addApiUser:config_object];
            }
            [self sendResultObject:config];
        }
    }
}

@end

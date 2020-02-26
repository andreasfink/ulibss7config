//
//  UMSS7ApiTaskServiceUser_modify.m
//  ulibss7config
//
//  Created by Andreas Fink on 08.05.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskServiceUser_modify.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigServiceUser.h"
#import "UMSS7ConfigStorage.h"

@implementation UMSS7ApiTaskServiceUser_modify

+ (NSString *)apiPath
{
    return @"/api/serviceuser-modify";
}



- (void)main
{
    if(![self isAuthenticated])
    {
        [self sendErrorNotAuthenticated];
        return;
    }

    NSString *name = _params[@"name"];
    name = [UMSS7ConfigObject filterName:name];
    UMSS7ConfigStorage *cs = [_appDelegate runningConfig];
    UMSS7ConfigServiceUser *config_object = [cs getServiceUser:name];
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
            [cs deleteServiceUser:name];
            [cs addServiceUser:config_object];
        }
        [self sendResultObject:config];
    }
}

@end

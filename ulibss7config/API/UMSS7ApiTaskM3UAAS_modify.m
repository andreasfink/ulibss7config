//
//  UMSS7ApiTaskM3UAAS_modify.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskM3UAAS_modify.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigM3UAAS.h"

@implementation UMSS7ApiTaskM3UAAS_modify
+ (NSString *)apiPath
{
    return @"/api/m3ua-as-modify";
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
    UMSS7ConfigStorage *config_storage = [_appDelegate runningConfig];

    UMSS7ConfigM3UAAS *config_object = [config_storage getM3UAAS:name];
    UMM3UAApplicationServer *instance = [_appDelegate getM3UAAS:name];

    if((instance!=NULL) || (config_object==NULL))
    {
        [self sendErrorNotFound];
    }
    else
    {
        [config_object setConfig:_params];
        NSDictionary *config = config_object.config.dictionaryCopy;
        [instance setConfig:config applicationContext:_appDelegate];
        [self sendResultObject:config];
    }
}
@end

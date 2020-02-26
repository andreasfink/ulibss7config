//
//  UMSS7ApiTaskM2PA_modify.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskM2PA_modify.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigM2PA.h"

@implementation UMSS7ApiTaskM2PA_modify

+ (NSString *)apiPath
{
    return @"/api/m2pa-modify";
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

    UMSS7ConfigM2PA *config_object = [config_storage getM2PA:name];
    UMLayerM2PA *instance = [_appDelegate getM2PA:name];

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

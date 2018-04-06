//
//  UMSS7ApiTaskMTP3_modify.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskMTP3_modify.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigMTP3.h"

@implementation UMSS7ApiTaskMTP3_modify

+ (NSString *)apiPath
{
    return @"/api/mtp3-modify";
}

- (void)main
{
    if(![self isAuthenticated])
    {
        [self sendErrorNotAuthenticated];
        return;
    }
    NSString *name = _webRequest.params[@"name"];
    name = [UMSS7ConfigObject filterName:name];
    UMSS7ConfigStorage *config_storage = [_appDelegate runningConfig];

    UMSS7ConfigMTP3 *config_object = [config_storage getMTP3:name];
    UMLayerMTP3 *instance = [_appDelegate getMTP3:name];

    if((instance!=NULL) || (config_object==NULL))
    {
        [self sendErrorNotFound];
    }
    else
    {
        [config_object setConfig:_webRequest.params];
        NSDictionary *config = config_object.config.dictionaryCopy;
        [instance setConfig:config applicationContext:_appDelegate];
        [self sendResultObject:config];
    }
}
@end

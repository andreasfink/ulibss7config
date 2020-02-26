//
//  UMSS7ApiTaskSCTP_modify.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSCTP_modify.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSCTP.h"

@implementation UMSS7ApiTaskSCTP_modify

+ (NSString *)apiPath
{
    return @"/api/sctp-modify";
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
    name = [UMSS7ConfigObject filterName:name];
    UMSS7ConfigStorage *cs = [_appDelegate runningConfig];
    UMSS7ConfigSCTP *config_object = [cs getSCTP:name];
    UMLayerSctp *instance = [_appDelegate getSCTP:name];
    if((instance==NULL) || (config_object==NULL))
    {
        [self sendErrorNotFound];
    }
    else
    {
        [config_object setConfig:_params];
        NSDictionary *config = config_object.config.dictionaryCopy;
        [instance setConfig:config applicationContext:_appDelegate];
        if(config_object.nameChanged)
        {
            [cs deleteSCTP:name];
            [cs addSCTP:config_object];
            [_appDelegate renameSCTP:name to:config_object.name];
        }
        [self sendResultObject:config];
    }
}

@end

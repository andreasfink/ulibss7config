//
//  UMSS7ApiTaskMTP3LinkSet_modify.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskMTP3LinkSet_modify.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigMTP3LinkSet.h"

@implementation UMSS7ApiTaskMTP3LinkSet_modify

+ (NSString *)apiPath
{
    return @"/api/mtp3-linkset-modify";
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
        UMSS7ConfigStorage *config_storage = [_appDelegate runningConfig];

        UMSS7ConfigMTP3LinkSet *config_object = [config_storage getMTP3LinkSet:name];
        UMMTP3LinkSet *instance = [_appDelegate getMTP3LinkSet:name];

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
}
@end

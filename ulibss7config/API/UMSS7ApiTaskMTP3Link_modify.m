//
//  UMSS7ApiTaskMTP3Link_modify.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//
#import <ulibmtp3/ulibmtp3.h>
#import "UMSS7ApiTaskMTP3Link_modify.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigMTP3Link.h"

@implementation UMSS7ApiTaskMTP3Link_modify

+ (NSString *)apiPath
{
    return @"/api/mtp3-link-modify";
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
    UMSS7ConfigStorage *config_storage = [_appDelegate runningConfig];

    UMSS7ConfigMTP3Link *config_object = [config_storage getMTP3Link:name];
    UMMTP3Link *instance = [_appDelegate getMTP3_Link:name];

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

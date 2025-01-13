//
//  UMSS7SConfigServiceUser.m
//  ulibss7config
//
//  Created by Andreas Fink on 08.05.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigServiceUser.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigServiceUser

+ (NSString *)type
{
    return @"service-user";
}
- (NSString *)type
{
    return [UMSS7ConfigServiceUser type];
}

- (UMSS7ConfigServiceUser *)initWithConfig:(NSDictionary *)dict
{
    self = [super initWithConfig:dict];
    if(self)
    {
        [self setConfig:dict];
    }
    return self;
}


- (void)appendConfigToString:(NSMutableString *)o
{
    [super appendConfigToString:o];
    APPEND_CONFIG_STRING(o,@"password",_password);
    APPEND_CONFIG_STRING(o,@"groupname",_groupname);
    APPEND_CONFIG_STRING(o,@"useroptions",_useroptions);
    APPEND_CONFIG_STRING(o,@"short-id",_shortId);
    APPEND_CONFIG_DOUBLE(o,@"speed-limit",_speedLimit);
    APPEND_CONFIG_STRING(o,@"billing-entity",_billingEntity);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
    APPEND_DICT_STRING(o,@"password",_password);
    APPEND_DICT_STRING(o,@"groupname",_groupname);
    APPEND_DICT_STRING(o,@"useroptions",_useroptions);
    APPEND_DICT_STRING(o,@"short-id",_shortId);
    APPEND_DICT_DOUBLE(o,@"speed-limit",_speedLimit);
    APPEND_DICT_STRING(o,@"billing-entity",_billingEntity);
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    SET_DICT_STRING(o,@"password",_password);
    SET_DICT_STRING(o,@"groupname",_groupname);
    SET_DICT_STRING(o,@"useroptions",_useroptions);
    SET_DICT_STRING(o,@"short-id",_shortId);
    SET_DICT_DOUBLE(o,@"speed-limit",_speedLimit);
    SET_DICT_STRING(o,@"billing-entity",_billingEntity);
}

- (UMSS7ConfigServiceUser *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigServiceUser allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end

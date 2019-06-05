//
//  UMSS7ConfigSS7FilterAction.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSS7FilterAction.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigSS7FilterAction

+ (NSString *)type
{
    return @"ss7-filter-action";
}

- (NSString *)type
{
    return [UMSS7ConfigSS7FilterAction type];
}


- (void)appendConfigToString:(NSMutableString *)s
{
    [super appendConfigToString:s];
    APPEND_CONFIG_DATE(s,@"created-timestamp",_createdTimestamp);
    APPEND_CONFIG_DATE(s,@"modified-timestamp",_modifiedTimestamp);
    APPEND_CONFIG_STRING(s,@"action",_action);
    APPEND_CONFIG_STRING(s,@"log",_log);
    APPEND_CONFIG_INTEGER(s,@"error",_error);
    APPEND_CONFIG_STRING(s,@"reroute-destination",_rerouteDestination);
    APPEND_CONFIG_STRING(s,@"reroute-called-address",_rerouteCalledAddress);
    APPEND_CONFIG_STRING(s,@"reroute-called-address-prefix",_rerouteCalledAddressPrefix);
    APPEND_CONFIG_STRING(s,@"tag",_tag);
    APPEND_CONFIG_STRING(s,@"description",_userDescription);
}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];
    APPEND_DICT_DATE(dict,@"created-timestamp",_createdTimestamp);
    APPEND_DICT_DATE(dict,@"modified-timestamp",_modifiedTimestamp);
    APPEND_DICT_STRING(dict,@"action",_action);
    APPEND_DICT_STRING(dict,@"log",_log);
    APPEND_DICT_INTEGER(dict,@"error",_error);
    APPEND_DICT_STRING(dict,@"reroute-destination",_rerouteDestination);
    APPEND_DICT_STRING(dict,@"reroute-called-address",_rerouteCalledAddress);
    APPEND_DICT_STRING(dict,@"reroute-called-address-prefix",_rerouteCalledAddressPrefix);
    APPEND_DICT_STRING(dict,@"tag",_tag);
    APPEND_DICT_STRING(dict,@"description",_userDescription);
    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_DATE(dict,@"created-timestamp",_createdTimestamp);
    SET_DICT_DATE(dict,@"modified-timestamp",_modifiedTimestamp);
    SET_DICT_STRING(dict,@"action",_action);
    SET_DICT_STRING(dict,@"log",_log);
    SET_DICT_INTEGER(dict,@"error",_error);
    SET_DICT_STRING(dict,@"reroute-destination",_rerouteDestination);
    SET_DICT_STRING(dict,@"reroute-called-address",_rerouteCalledAddress);
    SET_DICT_STRING(dict,@"reroute-called-address-prefix",_rerouteCalledAddressPrefix);
    SET_DICT_STRING(dict,@"tag",_tag);
    SET_DICT_STRING(dict,@"description",_userDescription);
}

- (UMSS7ConfigSS7FilterAction *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSS7FilterAction allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end

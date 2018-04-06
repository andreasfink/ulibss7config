//
//  UMSS7ConfigTCAPFilterEntry.m
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigTCAPFilterEntry.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigTCAPFilterEntry

+ (NSString *)type
{
    return @"tcap-filter-entry";
}
- (NSString *)type
{
    return [UMSS7ConfigTCAPFilterEntry type];
}

- (UMSS7ConfigTCAPFilterEntry *)initWithConfig:(NSDictionary *)dict
{
    self = [super initWithConfig:dict];
    if(self)
    {
        [self setConfig:dict];
    }
    return self;
}


- (void)appendConfigToString:(NSMutableString *)s
{
    [super appendConfigToString:s];
    APPEND_CONFIG_STRING(s,@"filter",_filter);
    APPEND_CONFIG_STRING(s,@"command",_command);
    APPEND_CONFIG_STRING(s,@"operation",_operation);
    APPEND_CONFIG_ARRAY_VERBOSE(s,@"application-context",_applicationContexts);
    APPEND_CONFIG_STRING(s,@"result",_result);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];
    APPEND_DICT_STRING(dict,@"filter",_filter);
    APPEND_DICT_STRING(dict,@"command",_command);
    APPEND_DICT_STRING(dict,@"operation",_operation);
    APPEND_DICT_ARRAY(dict,@"application-context",_applicationContexts);
    APPEND_DICT_STRING(dict,@"result",_result);
    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_STRING(dict,@"filter",_filter);
    SET_DICT_STRING(dict,@"command",_command);
    SET_DICT_STRING(dict,@"operation",_operation);
    SET_DICT_ARRAY(dict,@"application-context",_applicationContexts);
    SET_DICT_STRING(dict,@"result",_result);
}

- (UMSS7ConfigTCAPFilterEntry *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigTCAPFilterEntry allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end


//
//  UMSS7ConfigMTP3FilterEntry.m
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigMTP3FilterEntry.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigMTP3FilterEntry

+ (NSString *)type
{
    return @"mtp3-filter-entry";
}
- (NSString *)type
{
    return [UMSS7ConfigMTP3FilterEntry type];
}

- (UMSS7ConfigMTP3FilterEntry *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(s,@"result",_result);
    APPEND_CONFIG_STRING(s,@"opc",_result);
    APPEND_CONFIG_STRING(s,@"dpc",_result);
    APPEND_CONFIG_INTEGER(s,@"si",_result);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];
    APPEND_DICT_STRING(dict,@"filter",_filter);
    APPEND_DICT_STRING(dict,@"result",_result);
    APPEND_DICT_STRING(dict,@"opc",_result);
    APPEND_DICT_STRING(dict,@"dpc",_result);
    APPEND_DICT_INTEGER(dict,@"si",_result);
    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_FILTERED_STRING(dict,@"filter",_filter);
    SET_DICT_STRING(dict,@"result",_result);
    SET_DICT_STRING(dict,@"opc",_opc);
    SET_DICT_STRING(dict,@"dpc",_dpc);
    SET_DICT_INTEGER(dict,@"si",_si);
}

- (UMSS7ConfigMTP3FilterEntry *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigMTP3FilterEntry allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}


@end



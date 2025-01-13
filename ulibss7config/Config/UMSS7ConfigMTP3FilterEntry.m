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


- (void)appendConfigToString:(NSMutableString *)o
{
    [super appendConfigToString:o];
    APPEND_CONFIG_STRING(o,@"filter",_filter);
    APPEND_CONFIG_STRING(o,@"result",_result);
    APPEND_CONFIG_STRING(o,@"opc",_result);
    APPEND_CONFIG_STRING(o,@"dpc",_result);
    APPEND_CONFIG_INTEGER(o,@"si",_result);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
    APPEND_DICT_STRING(o,@"filter",_filter);
    APPEND_DICT_STRING(o,@"result",_result);
    APPEND_DICT_STRING(o,@"opc",_result);
    APPEND_DICT_STRING(o,@"dpc",_result);
    APPEND_DICT_INTEGER(o,@"si",_result);
    return dict;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
    SET_DICT_FILTERED_STRING(dict,@"filter",_filter);
    SET_DICT_STRING(o,@"result",_result);
    SET_DICT_STRING(o,@"opc",_opc);
    SET_DICT_STRING(o,@"dpc",_dpc);
    SET_DICT_INTEGER(o,@"si",_si);
}

- (UMSS7ConfigMTP3FilterEntry *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigMTP3FilterEntry allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}


@end



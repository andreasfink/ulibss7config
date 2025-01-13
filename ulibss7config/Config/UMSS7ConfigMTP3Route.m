//
//  UMSS7ConfigMtp3Route.m
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigMTP3Route.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigMTP3Route


+ (NSString *)type
{
    return @"mtp3-route";
}

- (NSString *)type
{
    return [UMSS7ConfigMTP3Route type];
}

- (NSString *)name
{
    if(_as)
    {
        return [NSString stringWithFormat:@"%@:AS:%@:%@",_mtp3,_as,_dpc];
    }
    else
    {
        return [NSString stringWithFormat:@"%@:LS:%@:%@",_mtp3,_ls,_dpc];
    }
}

- (UMSS7ConfigMTP3Route *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(o,@"mtp3",_mtp3);
    APPEND_CONFIG_ARRAY_VERBOSE(s,@"dpc",_dpc);
    APPEND_CONFIG_STRING(o,@"ls",_ls);
    APPEND_CONFIG_STRING(o,@"as",_as);
    APPEND_CONFIG_INTEGER(o,@"priority",_priority);
    APPEND_CONFIG_DOUBLE(o,@"weight",_weight);
    APPEND_CONFIG_DOUBLE(o,@"local-preference",_localPreference);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];

    APPEND_DICT_STRING(o,@"mtp3",_mtp3);
    APPEND_DICT_ARRAY(dict,@"dpc",_dpc);
    APPEND_DICT_STRING(o,@"ls",_ls);
    APPEND_DICT_STRING(o,@"as",_as);
    APPEND_DICT_INTEGER(o,@"priority",_priority);
    APPEND_DICT_DOUBLE(o,@"weight",_weight);
    APPEND_DICT_DOUBLE(o,@"local-preference",_localPreference);
    return dict;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
    SET_DICT_FILTERED_STRING(dict,@"mtp3",_mtp3);
    SET_DICT_ARRAY(dict,@"dpc",_dpc);
    SET_DICT_FILTERED_STRING(dict,@"ls",_ls);
    SET_DICT_FILTERED_STRING(dict,@"as",_as);
    SET_DICT_INTEGER(o,@"priority",_priority);
    SET_DICT_DOUBLE(o,@"weight",_weight);
    SET_DICT_DOUBLE(o,@"local-preference",_localPreference);
}

- (UMSS7ConfigMTP3Route *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigMTP3Route allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end

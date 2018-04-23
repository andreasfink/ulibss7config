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

- (void)appendConfigToString:(NSMutableString *)s
{
    [super appendConfigToString:s];
    APPEND_CONFIG_STRING(s,@"mtp3",_mtp3);
    APPEND_CONFIG_STRING(s,@"dpc",_dpc);
    APPEND_CONFIG_STRING(s,@"ls",_ls);
    APPEND_CONFIG_STRING(s,@"as",_as);
    APPEND_CONFIG_INTEGER(s,@"priority",_priority);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];

    APPEND_DICT_STRING(dict,@"mtp3",_mtp3);
    APPEND_DICT_STRING(dict,@"dpc",_dpc);
    APPEND_DICT_STRING(dict,@"ls",_ls);
    APPEND_DICT_STRING(dict,@"as",_as);
    APPEND_DICT_INTEGER(dict,@"priority",_priority);
    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_STRING(dict,@"mtp3",_mtp3);
    SET_DICT_STRING(dict,@"dpc",_dpc);
    SET_DICT_STRING(dict,@"ls",_ls);
    SET_DICT_STRING(dict,@"as",_as);
    SET_DICT_INTEGER(dict,@"priority",_priority);
}

- (UMSS7ConfigMTP3Route *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigMTP3Route allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end

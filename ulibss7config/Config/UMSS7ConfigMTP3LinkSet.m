//
//  UMSS7ConfigMtp3LinkSet.m
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigMTP3LinkSet.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigMTP3LinkSet

+ (NSString *)type
{
    return @"mtp3-linkset";
}

- (NSString *)type
{
    return [UMSS7ConfigMTP3LinkSet type];
}


- (UMSS7ConfigMTP3LinkSet *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(s,@"apc",_apc);
    APPEND_CONFIG_STRING(s,@"opc",_opc);
    APPEND_CONFIG_DOUBLE(s,@"speed",_speed);
    APPEND_CONFIG_INTEGER(s,@"override-network-indicator",_overrideNetworkIndicator);
    APPEND_CONFIG_STRING(s,@"tt-map-in",_ttmap_in);
    APPEND_CONFIG_STRING(s,@"tt-map-out",_ttmap_out);

}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];
    APPEND_DICT_STRING(dict,@"mtp3",_mtp3);
    APPEND_DICT_STRING(dict,@"apc",_apc);
    APPEND_DICT_STRING(dict,@"opc",_opc);
    APPEND_DICT_DOUBLE(dict,@"speed",_speed);
    APPEND_DICT_INTEGER(dict,@"override-network-indicator",_overrideNetworkIndicator);
    APPEND_DICT_STRING(dict,@"tt-map-in",_ttmap_in);
    APPEND_DICT_STRING(dict,@"tt-map-out",_ttmap_out);

    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_FILTERED_STRING(dict,@"mtp3",_mtp3);
    SET_DICT_STRING(dict,@"apc",_apc);
    SET_DICT_STRING(dict,@"opc",_opc);
    SET_DICT_DOUBLE(dict,@"speed",_speed);
    SET_DICT_INTEGER(dict,@"override-network-indicator",_overrideNetworkIndicator);
    SET_DICT_STRING(dict,@"tt-map-in",_ttmap_in);
    SET_DICT_STRING(dict,@"tt-map-out",_ttmap_out);
}

- (UMSS7ConfigMTP3LinkSet *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigMTP3LinkSet allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}


@end
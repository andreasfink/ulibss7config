//
//  UMSS7ConfigM3UAAS.m
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigM3UAAS.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigM3UAAS

+ (NSString *)type
{
    return @"m3ua-as";
}

- (NSString *)type
{
    return [UMSS7ConfigM3UAAS type];
}


- (UMSS7ConfigM3UAAS *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_INTEGER(s,@"routing-key",_routingKey);
    APPEND_CONFIG_STRING(s,@"traffic-mode",_trafficMode);
    APPEND_CONFIG_INTEGER(s,@"override-network-indicator",_overrideNetworkIndicator);
}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];
    APPEND_DICT_STRING(dict,@"mtp3",_mtp3);
    APPEND_DICT_STRING(dict,@"apc",_apc);
    APPEND_DICT_INTEGER(dict,@"routing-key",_routingKey);
    APPEND_DICT_STRING(dict,@"traffic-mode",_trafficMode);
    APPEND_DICT_INTEGER(dict,@"override-network-indicator",_overrideNetworkIndicator);

    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_STRING(dict,@"mtp3",_mtp3);
    SET_DICT_STRING(dict,@"apc",_apc);
    SET_DICT_INTEGER(dict,@"routing-key",_routingKey);
    SET_DICT_STRING(dict,@"traffic-mode",_trafficMode);
    SET_DICT_INTEGER(dict,@"override-network-indicator",_overrideNetworkIndicator);
}

- (UMSS7ConfigM3UAAS *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigM3UAAS allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}


@end

//
//  UMSS7ConfigMTP3.m
//  estp
//
//  Created by Andreas Fink on 01.02.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigMTP3.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigMTP3


+ (NSString *)type
{
    return @"mtp3";
}

- (NSString *)type
{
    return [UMSS7ConfigMTP3 type];
}

- (UMSS7ConfigMTP3 *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(s,@"variant",_variant);
    APPEND_CONFIG_STRING(s,@"opc",_opc);
    APPEND_CONFIG_STRING(s,@"ni",_networkIndicator);
    APPEND_CONFIG_STRING(s,@"problematic-packet-dumper",_problematicPacketDumper);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];
    APPEND_DICT_STRING(dict,@"variant",_variant);
    APPEND_DICT_STRING(dict,@"opc",_opc);
    APPEND_DICT_STRING(dict,@"ni",_networkIndicator);
    APPEND_DICT_STRING(dict,@"problematic-packet-dumper",_problematicPacketDumper);

    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_STRING(dict,@"variant",_variant);
    SET_DICT_STRING(dict,@"opc",_opc);
    SET_DICT_STRING(dict,@"ni",_networkIndicator);
    SET_DICT_STRING(dict,@"problematic-packet-dumper",_problematicPacketDumper);
}

- (UMSS7ConfigMTP3 *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigMTP3 allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end

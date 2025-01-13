//
//  UMSS7ConfigMTP3.m
//  estp
//
//  Created by Andreas Fink on 01.02.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigMTP3.h"
#import "UMSS7ConfigMacroHelper.h"

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

- (void)appendConfigToString:(NSMutableString *)o
{
    [super appendConfigToString:o];
    APPEND_CONFIG_STRING(o,@"variant",_variant);
    APPEND_CONFIG_STRING(o,@"opc",_opc);
    APPEND_CONFIG_STRING(o,@"ni",_networkIndicator);
    APPEND_CONFIG_STRING(o,@"mode",_mode);
    APPEND_CONFIG_STRING(o,@"problematic-packet-dumper",_problematicPacketDumper);
    APPEND_CONFIG_STRING(o,@"routing-update-log",_routingUpdateLog);
    APPEND_CONFIG_STRING(o,@"routing-update-db-pool",_routingUpdateDbPool);
    APPEND_CONFIG_STRING(o,@"routing-update-db-table",_routingUpdateDbTable);
    APPEND_CONFIG_STRING(o,@"routing-update-db-instance",_routingUpdateDbInstance);
    APPEND_CONFIG_BOOLEAN(o,@"routing-update-db-autocreate",_routingUpdateDbAutocreate);
    APPEND_CONFIG_STRING(o,@"statistic-db-pool",_statisticDbPool);
    APPEND_CONFIG_STRING(o,@"statistic-db-table",_statisticDbTable);
    APPEND_CONFIG_STRING(o,@"statistic-db-instance",_statisticDbInstance);
    APPEND_CONFIG_BOOLEAN(o,@"statistic-db-autocreate",_statisticDbAutocreate);
}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
    APPEND_DICT_STRING(o,@"variant",_variant);
    APPEND_DICT_STRING(o,@"opc",_opc);
    APPEND_DICT_STRING(o,@"ni",_networkIndicator);
    APPEND_DICT_STRING(o,@"mode",_mode);
    APPEND_DICT_STRING(o,@"problematic-packet-dumper",_problematicPacketDumper);
    APPEND_DICT_STRING(o,@"routing-update-log",_routingUpdateLog);
    APPEND_DICT_STRING(o,@"statistic-db-pool",_statisticDbPool);
    APPEND_DICT_STRING(o,@"statistic-db-table",_statisticDbTable);
    APPEND_DICT_STRING(o,@"statistic-db-instance",_statisticDbInstance);
    APPEND_DICT_BOOLEAN(o,@"statistic-db-autocreate",_statisticDbAutocreate);
    APPEND_DICT_STRING(o,@"routing-update-db-pool",_routingUpdateDbPool);
    APPEND_DICT_STRING(o,@"routing-update-db-table",_routingUpdateDbTable);
    APPEND_DICT_STRING(o,@"routing-update-db-instance",_routingUpdateDbInstance);
    APPEND_DICT_BOOLEAN(o,@"routing-update-db-autocreate",_routingUpdateDbAutocreate);
    return dict;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
    SET_DICT_STRING(o,@"variant",_variant);
    SET_DICT_STRING(o,@"opc",_opc);
    SET_DICT_STRING(o,@"ni",_networkIndicator);
    SET_DICT_STRING(o,@"mode",_mode);
    SET_DICT_FILTERED_STRING(dict,@"problematic-packet-dumper",_problematicPacketDumper);
    SET_DICT_STRING(o,@"routing-update-log",_routingUpdateLog);
    SET_DICT_STRING(o,@"statistic-db-pool",_statisticDbPool);
    SET_DICT_STRING(o,@"statistic-db-table",_statisticDbTable);
    SET_DICT_STRING(o,@"statistic-db-instance",_statisticDbInstance);
    SET_DICT_BOOLEAN(o,@"statistic-db-autocreate",_statisticDbAutocreate);
    SET_DICT_STRING(o,@"routing-update-db-pool",_routingUpdateDbPool);
    SET_DICT_STRING(o,@"routing-update-db-table",_routingUpdateDbTable);
    SET_DICT_STRING(o,@"routing-update-db-instance",_routingUpdateDbInstance);
    SET_DICT_BOOLEAN(o,@"routing-update-db-autocreate",_routingUpdateDbAutocreate);

}

- (UMSS7ConfigMTP3 *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigMTP3 allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end

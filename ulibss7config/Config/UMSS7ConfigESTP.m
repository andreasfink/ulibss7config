//
//  UMSS7ConfigESTP.m
//  ulibss7config
//
//  Created by Andreas Fink on 18.06.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigESTP.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigESTP


+ (NSString *)type
{
    return @"estp";
}

- (NSString *)type
{
    return [UMSS7ConfigESTP type];
}


- (UMSS7ConfigESTP *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(s,@"number",_number);
    APPEND_CONFIG_STRING(s,@"sccp",_sccp);
    APPEND_CONFIG_STRING(s,@"license-directory",_licenseDirectory);
    APPEND_CONFIG_STRING(s,@"filter-engine-directory",_filterEngineDirectory);
    APPEND_CONFIG_STRING(s,@"gtt-accounting-db-pool",_gttAccountingDbPool);
    APPEND_CONFIG_STRING(s,@"gtt-accounting-table",_gttAccountingTable);
    APPEND_CONFIG_STRING(s,@"gtt-accounting-prefixes-table",_gttAccountingPrefixesTable);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];

    APPEND_DICT_STRING(dict,@"number",_number);
    APPEND_DICT_STRING(dict,@"sccp",_sccp);
    APPEND_DICT_STRING(dict,@"license-directory",_licenseDirectory);
    APPEND_DICT_STRING(dict,@"filter-engine-directory",_filterEngineDirectory);
    APPEND_DICT_STRING(dict,@"gtt-accounting-db-pool",_gttAccountingDbPool);
    APPEND_DICT_STRING(dict,@"gtt-accounting-table",_gttAccountingTable);
    APPEND_DICT_STRING(dict,@"gtt-accounting-prefixes-table",_gttAccountingPrefixesTable);
    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_STRING(dict,@"number",_number);
    SET_DICT_STRING(dict,@"sccp",_sccp);
    SET_DICT_STRING(dict,@"license-directory",_licenseDirectory);
    SET_DICT_STRING(dict,@"filter-engine-directory",_filterEngineDirectory);
    SET_DICT_STRING(dict,@"gtt-accounting-db-pool",_gttAccountingDbPool);
    SET_DICT_STRING(dict,@"gtt-accounting-table",_gttAccountingTable);
    SET_DICT_STRING(dict,@"gtt-accounting-prefixes-table",_gttAccountingPrefixesTable);
}


- (UMSS7ConfigESTP *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigESTP allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end



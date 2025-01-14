//
//  UMSS7ConfigESTP.m
//  ulibss7config
//
//  Created by Andreas Fink on 18.06.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigESTP.h"
#import "UMSS7ConfigMacroHelper.h"

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


- (void)appendConfigToString:(NSMutableString *)o
{
    [super appendConfigToString:o];
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigESTP.def.h"
#include "UMSS7Config_macroClear.h"
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];

    APPEND_DICT_STRING(o,@"number",_number);
    APPEND_DICT_STRING(o,@"sccp",_sccp);
    APPEND_DICT_STRING(o,@"license-directory",_licenseDirectory);
    APPEND_DICT_STRING(o,@"filter-engine-directory",_filterEngineDirectory);
    APPEND_DICT_STRING(o,@"gtt-accounting-db-pool",_gttAccountingDbPool);
    APPEND_DICT_STRING(o,@"gtt-accounting-table",_gttAccountingTable);
    APPEND_DICT_STRING(o,@"gtt-accounting-prefixes-table",_gttAccountingPrefixesTable);
    return dict;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
    SET_DICT_STRING(o,@"number",_number);
    SET_DICT_STRING(o,@"sccp",_sccp);
    SET_DICT_STRING(o,@"license-directory",_licenseDirectory);
    SET_DICT_STRING(o,@"filter-engine-directory",_filterEngineDirectory);
    SET_DICT_STRING(o,@"gtt-accounting-db-pool",_gttAccountingDbPool);
    SET_DICT_STRING(o,@"gtt-accounting-table",_gttAccountingTable);
    SET_DICT_STRING(o,@"gtt-accounting-prefixes-table",_gttAccountingPrefixesTable);
}


- (UMSS7ConfigESTP *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigESTP allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end



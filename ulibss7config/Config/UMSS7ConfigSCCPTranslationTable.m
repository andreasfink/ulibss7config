//
//  UMSS7ConfigSCCPTranslationTable.m
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSCCPTranslationTable.h"
#import "UMSS7ConfigSCCPTranslationTableEntry.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigSCCPTranslationTable


+ (NSString *)type
{
    return @"sccp-translation-table";
}

- (NSString *)type
{
    return [UMSS7ConfigSCCPTranslationTable type];
}


- (UMSS7ConfigSCCPTranslationTable *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(s,@"sccp",_sccp);
    APPEND_CONFIG_INTEGER(s,@"tt",_tt);
    APPEND_CONFIG_INTEGER(s,@"gti",_gti);
    APPEND_CONFIG_INTEGER(s,@"np",_np);
    APPEND_CONFIG_INTEGER(s,@"nai",_nai);
    APPEND_CONFIG_STRING(s,@"pre-translation",_preTranslation);
    APPEND_CONFIG_STRING(s,@"post-translation",_postTranslation);
    APPEND_CONFIG_STRING(s,@"default-destination",_defaultDestination);
    APPEND_CONFIG_STRING(s,@"translation-table-db-pool",_translationTableDbPool);
    APPEND_CONFIG_STRING(s,@"translation-table-db-table",_translationTableDbTable);
    APPEND_CONFIG_STRING(s,@"translation-table-db-blacklist-table",_translationTableDbBlacklistTable);
    APPEND_CONFIG_BOOLEAN(s,@"translation-table-db-autocreate",_translationTableDbAutocreate);
    APPEND_CONFIG_DOUBLE(s,@"translation-table-db-check-intervall",_translationTableDbCheckIntervall);

    for(UMSS7ConfigSCCPTranslationTableEntry *e in _subEntries)
    {
        [s appendString:@"\n"];
        [e appendConfigToString:s];
    }
}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];

    APPEND_DICT_STRING(dict,@"sccp",_sccp);
    APPEND_DICT_INTEGER(dict,@"tt",_tt);
    APPEND_DICT_INTEGER(dict,@"gti",_gti);
    APPEND_DICT_INTEGER(dict,@"np",_np);
    APPEND_DICT_INTEGER(dict,@"nai",_nai);
    APPEND_DICT_STRING(dict,@"pre-translation",_preTranslation);
    APPEND_DICT_STRING(dict,@"post-translation",_postTranslation);
    APPEND_DICT_STRING(dict,@"default-destination",_defaultDestination);
    APPEND_DICT_STRING(dict,@"translation-table-db-pool",_translationTableDbPool);
    APPEND_DICT_STRING(dict,@"translation-table-db-table",_translationTableDbTable);
    APPEND_DICT_STRING(dict,@"translation-table-db-blacklist-table",_translationTableDbBlacklistTable);
    APPEND_DICT_BOOLEAN(dict,@"translation-table-db-autocreate",_translationTableDbAutocreate);
    APPEND_DICT_DOUBLE(dict,@"translation-table-db-check-intervall",_translationTableDbCheckIntervall);

    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_FILTERED_STRING(dict,@"sccp",_sccp);
    SET_DICT_INTEGER(dict,@"tt",_tt);
    SET_DICT_INTEGER(dict,@"gti",_gti);
    SET_DICT_INTEGER(dict,@"np",_np);
    SET_DICT_INTEGER(dict,@"nai",_nai);
    SET_DICT_FILTERED_STRING(dict,@"pre-translation",_preTranslation);
    SET_DICT_FILTERED_STRING(dict,@"post-translation",_postTranslation);
    SET_DICT_FILTERED_STRING(dict,@"default-destination",_defaultDestination);
    SET_DICT_STRING(dict,@"translation-table-db-pool",_translationTableDbPool);
    SET_DICT_STRING(dict,@"translation-table-db-table",_translationTableDbTable);
    SET_DICT_STRING(dict,@"translation-table-db-blacklist-table",_translationTableDbBlacklistTable);
    SET_DICT_BOOLEAN(dict,@"translation-table-db-autocreate",_translationTableDbAutocreate);
    SET_DICT_DOUBLE(dict,@"translation-table-db-check-intervall",_translationTableDbCheckIntervall);
}


- (void)setSubConfig:(NSArray *)configs
{
    for(NSDictionary *config in configs)
    {
        UMSS7ConfigSCCPTranslationTableEntry *entry = [[UMSS7ConfigSCCPTranslationTableEntry alloc]initWithConfig:config];
        [_subEntries addObject:entry];
    }
}

- (UMSS7ConfigSCCPTranslationTable *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSCCPTranslationTable allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end


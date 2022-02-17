//
//  UMSS7ConfigSCCPTranslationTableEntry.m
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSCCPTranslationTableEntry.h"
#import "UMSS7ConfigMacros.h"
#import <ulibgt/ulibgt.h>

@implementation UMSS7ConfigSCCPTranslationTableEntry

+ (NSString *)type
{
    return @"sccp-translation-table-entry";
}

- (NSString *)type
{
    return [UMSS7ConfigSCCPTranslationTableEntry type];
}


- (UMSS7ConfigSCCPTranslationTableEntry *)initWithConfig:(NSDictionary *)dict
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
    [super appendConfigToString:s withoutName:YES];
    APPEND_CONFIG_STRING(s,@"table",_translationTableName);
    APPEND_CONFIG_STRING(s,@"gta",_gta);
    APPEND_CONFIG_STRING(s,@"destination",_sccpDestination);
    APPEND_CONFIG_STRING(s,@"post-translation",_postTranslation);
    APPEND_CONFIG_STRING(s,@"gt-owner",_gtOwner);
    APPEND_CONFIG_STRING(s,@"gt-user",_gtUser);
    APPEND_CONFIG_INTEGER(s,@"transaction-id-start",_tidStart);
    APPEND_CONFIG_INTEGER(s,@"transaction-id-end",_tidEnd);
    APPEND_CONFIG_STRING(s,@"transaction-id-range",_tidRange);
    APPEND_CONFIG_STRING(s,@"ssn",_ssn);
    APPEND_CONFIG_STRING(s,@"opcopde",_opcode);
    APPEND_CONFIG_STRING(s,@"application-context",_appcontext);
}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super configWithoutName:YES];
    APPEND_DICT_STRING(dict,@"table",_translationTableName);
    APPEND_DICT_STRING(dict,@"gta",_gta);
    APPEND_DICT_STRING(dict,@"destination",_sccpDestination);
    APPEND_DICT_STRING(dict,@"post-translation",_postTranslation);
    APPEND_DICT_STRING(dict,@"gt-owner",_gtOwner);
    APPEND_DICT_STRING(dict,@"gt-user",_gtUser);
    APPEND_DICT_INTEGER(dict,@"transaction-id-start",_tidStart);
    APPEND_DICT_INTEGER(dict,@"transaction-id-end",_tidEnd);
    APPEND_DICT_STRING(dict,@"transaction-id-range",_tidRange);
    APPEND_DICT_STRING(dict,@"ssn",_ssn);
    APPEND_DICT_STRING(dict,@"opcopde",_opcode);
    APPEND_DICT_STRING(dict,@"application-context",_appcontext);
    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_FILTERED_STRING(dict,@"table",_translationTableName);
    SET_DICT_STRING(dict,@"gta",_gta);
    SET_DICT_FILTERED_STRING(dict,@"destination",_sccpDestination);
    SET_DICT_FILTERED_STRING(dict,@"post-translation",_postTranslation);
    SET_DICT_FILTERED_STRING(dict,@"gt-owner",_gtOwner);
    SET_DICT_FILTERED_STRING(dict,@"gt-user",_gtUser);
    SET_DICT_INTEGER(dict,@"transaction-id-start",_tidStart);
    SET_DICT_INTEGER(dict,@"transaction-id-end",_tidEnd);
    SET_DICT_STRING(dict,@"transaction-id-range",_tidRange);
    SET_DICT_STRING(dict,@"ssn",_ssn);
    SET_DICT_STRING(dict,@"opcopde",_opcode);
    SET_DICT_STRING(dict,@"application-context",_appcontext);
    _name = [SccpGttRoutingTableEntry entryNameForGta:_gta tableName:_translationTableName];
}

- (UMSS7ConfigSCCPTranslationTableEntry *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return  [[UMSS7ConfigSCCPTranslationTableEntry allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end

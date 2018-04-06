//
//  UMSS7ConfigSCCPTranslationTableEntry.m
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSCCPTranslationTableEntry.h"
#import "UMSS7ConfigMacros.h"

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
    [super appendConfigToString:s];
    APPEND_CONFIG_STRING(s,@"table",_translationTableName);
    APPEND_CONFIG_STRING(s,@"gta",_gta);
    APPEND_CONFIG_STRING(s,@"destination",_sccpDestination);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];
    APPEND_DICT_STRING(dict,@"table",_translationTableName);
    APPEND_DICT_STRING(dict,@"gta",_gta);
    APPEND_DICT_STRING(dict,@"destination",_sccpDestination);
    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_STRING(dict,@"table",_translationTableName);
    SET_DICT_STRING(dict,@"gta",_gta);
    SET_DICT_STRING(dict,@"destination",_sccpDestination);
}

- (UMSS7ConfigSCCPTranslationTableEntry *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSCCPTranslationTableEntry allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end

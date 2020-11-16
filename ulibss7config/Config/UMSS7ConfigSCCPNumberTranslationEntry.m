//
//  UMSS7ConfigSCCPNumberTranslationEntry.m
//  ulibss7config
//
//  Created by Andreas Fink on 20.04.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSCCPNumberTranslationEntry.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigSCCPNumberTranslationEntry

+ (NSString *)type
{
    return @"sccp-number-translation-entry";
}

- (NSString *)type
{
    return [UMSS7ConfigSCCPNumberTranslationEntry type];
}

- (UMSS7ConfigSCCPNumberTranslationEntry *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(s,@"sccp-number-translation",_sccpNumberTranslation);
    APPEND_CONFIG_STRING(s,@"in-address",_inAddress);
    APPEND_CONFIG_STRING(s,@"out-address",_outAddress);
    APPEND_CONFIG_INTEGER(s,@"new-nai",_replacementNAI);
    APPEND_CONFIG_INTEGER(s,@"new-np",_replacementNP);
    APPEND_CONFIG_INTEGER(s,@"remove-digits",_removeDigits);
    APPEND_CONFIG_STRING(s,@"append-digits",_appendDigits);


}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];
    APPEND_DICT_STRING(dict,@"sccp-number-translation",_sccpNumberTranslation);
    APPEND_DICT_STRING(dict,@"in-address",_inAddress);
    APPEND_DICT_STRING(dict,@"out-address",_outAddress);
    APPEND_DICT_INTEGER(dict,@"new-nai",_replacementNAI);
    APPEND_DICT_INTEGER(dict,@"new-np",_replacementNP);
    APPEND_DICT_INTEGER(dict,@"remove-digits",_removeDigits);
    APPEND_DICT_STRING(dict,@"append-digits",_appendDigits);
    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_FILTERED_STRING(dict,@"sccp-number-translation",_sccpNumberTranslation);
    SET_DICT_STRING(dict,@"in-address",_inAddress);
    SET_DICT_STRING(dict,@"out-address",_outAddress);
    SET_DICT_INTEGER(dict,@"new-nai",_replacementNAI);
    SET_DICT_INTEGER(dict,@"new-np",_replacementNP);
    SET_DICT_INTEGER(dict,@"remove-digits",_removeDigits);
    SET_DICT_STRING(dict,@"append-digits",_appendDigits);
}

- (UMSS7ConfigSCCPNumberTranslationEntry *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSCCPNumberTranslationEntry allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end

//
//  UMSS7ConfigSCCPNumberTranslationEntry.m
//  ulibss7config
//
//  Created by Andreas Fink on 20.04.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSCCPNumberTranslationEntry.h"
#import "UMSS7ConfigMacroHelper.h"

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

- (void)appendConfigToString:(NSMutableString *)o
{
    [super appendConfigToString:o];
    APPEND_CONFIG_STRING(o,@"sccp-number-translation",_sccpNumberTranslation);
    APPEND_CONFIG_STRING(o,@"in-address",_inAddress);
    APPEND_CONFIG_STRING(o,@"out-address",_outAddress);
    APPEND_CONFIG_INTEGER(o,@"new-tt",_replacementTT);
    APPEND_CONFIG_INTEGER(o,@"new-calling-party-tt",_replacementCallingPartyTT);
    APPEND_CONFIG_INTEGER(o,@"new-called-party-tt",_replacementCalledPartyTT);
    APPEND_CONFIG_INTEGER(o,@"new-nai",_replacementNAI);
    APPEND_CONFIG_INTEGER(o,@"new-np",_replacementNP);
    APPEND_CONFIG_INTEGER(o,@"remove-digits",_removeDigits);
    APPEND_CONFIG_STRING(o,@"append-digits",_appendDigits);


}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
    APPEND_DICT_STRING(o,@"sccp-number-translation",_sccpNumberTranslation);
    APPEND_DICT_STRING(o,@"in-address",_inAddress);
    APPEND_DICT_STRING(o,@"out-address",_outAddress);
    APPEND_DICT_INTEGER(o,@"new-tt",_replacementTT);
    APPEND_DICT_INTEGER(o,@"new-calling-party-tt",_replacementCallingPartyTT);
    APPEND_DICT_INTEGER(o,@"new-called-party-tt",_replacementCalledPartyTT);
    APPEND_DICT_INTEGER(o,@"new-nai",_replacementNAI);
    APPEND_DICT_INTEGER(o,@"new-np",_replacementNP);
    APPEND_DICT_INTEGER(o,@"remove-digits",_removeDigits);
    APPEND_DICT_STRING(o,@"append-digits",_appendDigits);
    return dict;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
    SET_DICT_FILTERED_STRING(dict,@"sccp-number-translation",_sccpNumberTranslation);
    SET_DICT_STRING(o,@"in-address",_inAddress);
    SET_DICT_STRING(o,@"out-address",_outAddress);
    SET_DICT_INTEGER(o,@"new-tt",_replacementTT);
    SET_DICT_INTEGER(o,@"new-calling-party-tt",_replacementCallingPartyTT);
    SET_DICT_INTEGER(o,@"new-called-party-tt",_replacementCalledPartyTT);
    SET_DICT_INTEGER(o,@"new-nai",_replacementNAI);
    SET_DICT_INTEGER(o,@"new-np",_replacementNP);
    SET_DICT_INTEGER(o,@"remove-digits",_removeDigits);
    SET_DICT_STRING(o,@"append-digits",_appendDigits);
}

- (UMSS7ConfigSCCPNumberTranslationEntry *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSCCPNumberTranslationEntry allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end

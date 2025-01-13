//
//  UMSS7ConfigSCCPDestinationGroupEntry.m
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSCCPDestinationEntry.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigSCCPDestinationEntry


+ (NSString *)type
{
    return @"sccp-destination-entry";
}

- (NSString *)type
{
    return [UMSS7ConfigSCCPDestinationEntry type];
}


- (UMSS7ConfigSCCPDestinationEntry *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(o,@"destination",_destination);
    APPEND_CONFIG_STRING(o,@"next-sccp-instance",_nextSccpInstance);
    APPEND_CONFIG_STRING(o,@"point-code",_dpc);
    APPEND_CONFIG_STRING(o,@"application-server",_applicationServer);
    APPEND_CONFIG_INTEGER(o,@"cost",_cost);
    APPEND_CONFIG_INTEGER(o,@"weigth",_weigth);
    APPEND_CONFIG_INTEGER(o,@"subsystem",_subsystem);
    APPEND_CONFIG_INTEGER(o,@"ntt",_overrideCalledTT);
    APPEND_CONFIG_INTEGER(o,@"set-called-tt",_overrideCalledTT);
    APPEND_CONFIG_INTEGER(o,@"set-calling-tt",_overrideCallingTT);
    APPEND_CONFIG_STRING(o,@"add-prefix",_addPrefix);
    APPEND_CONFIG_STRING(o,@"add-postfix",_addPostfix);
    APPEND_CONFIG_STRING(o,@"post-translation",_postTranslation);
    APPEND_CONFIG_STRING(o,@"mtp3",_mtp3Instance);
    APPEND_CONFIG_INTEGER(o,@"set-gti",_setGti);
    APPEND_CONFIG_INTEGER(o,@"set-nai",_setNai);
    APPEND_CONFIG_INTEGER(o,@"set-npi",_setNpi);
    APPEND_CONFIG_INTEGER(o,@"set-encoding",_setEncoding);
    APPEND_CONFIG_INTEGER(o,@"set-national",_setNational);
    APPEND_CONFIG_INTEGER(o,@"remove-digits",_removeDigits);
    APPEND_CONFIG_INTEGER(o,@"limit-digit-length",_limitDigitLength);
    APPEND_CONFIG_BOOLEAN(o,@"ansi-to-itu",_ansiToItu);
    APPEND_CONFIG_BOOLEAN(o,@"itu-to-ansi",_ituToAnsi);
}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
    APPEND_DICT_STRING(o,@"destination",_destination);
    APPEND_DICT_STRING(o,@"next-sccp-instance",_nextSccpInstance);
    APPEND_DICT_STRING(o,@"point-code",_dpc);
    APPEND_DICT_STRING(o,@"application-server",_applicationServer);
    APPEND_DICT_INTEGER(o,@"cost",_cost);
    APPEND_DICT_INTEGER(o,@"weight",_weigth);
    APPEND_DICT_INTEGER(o,@"subsystem",_subsystem);
    APPEND_DICT_INTEGER(o,@"ntt",_overrideCalledTT);
    APPEND_DICT_INTEGER(o,@"set-called-tt",_overrideCalledTT);
    APPEND_DICT_INTEGER(o,@"set-calling-tt",_overrideCallingTT);
    APPEND_DICT_STRING(o,@"add-prefix",_addPrefix);
    APPEND_DICT_STRING(o,@"add-postfix",_addPostfix);
    APPEND_DICT_STRING(o,@"post-translation",_postTranslation);
    APPEND_DICT_STRING(o,@"mtp3",_mtp3Instance);
    APPEND_DICT_INTEGER(o,@"set-gti",_setGti);
    APPEND_DICT_INTEGER(o,@"set-nai",_setNai);
    APPEND_DICT_INTEGER(o,@"set-npi",_setNpi);
    APPEND_DICT_INTEGER(o,@"set-encoding",_setEncoding);
    APPEND_DICT_INTEGER(o,@"set-national",_setNational);
    APPEND_DICT_INTEGER(o,@"remove-digits",_removeDigits);
    APPEND_DICT_INTEGER(o,@"limit-digit-length",_limitDigitLength);
    APPEND_DICT_BOOLEAN(o,@"ansi-to-itu",_ansiToItu);
    APPEND_DICT_BOOLEAN(o,@"itu-to-ansi",_ituToAnsi);
    return dict;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
    SET_DICT_FILTERED_STRING(dict,@"destination",_destination);
    SET_DICT_STRING(o,@"next-sccp-instance",_nextSccpInstance);
    SET_DICT_STRING(o,@"point-code",_dpc);
    SET_DICT_FILTERED_STRING(dict,@"application-server",_applicationServer);
    SET_DICT_INTEGER(o,@"cost",_cost);
    SET_DICT_INTEGER(o,@"weigth",_weight);
    SET_DICT_INTEGER(o,@"subsystem",_subsystem);
    SET_DICT_INTEGER(o,@"ntt",_overrideCalledTT);
    SET_DICT_INTEGER(o,@"set-called-tt",_overrideCalledTT);
    SET_DICT_INTEGER(o,@"set-calling-tt",_overrideCallingTT);
    SET_DICT_STRING(o,@"add-prefix",_addPrefix);
    SET_DICT_STRING(o,@"add-postfix",_addPostfix);
    SET_DICT_STRING(o,@"mtp3",_mtp3Instance);
    SET_DICT_INTEGER(o,@"set-gti",_setGti);
    SET_DICT_INTEGER(o,@"set-nai",_setNai);
    SET_DICT_INTEGER(o,@"set-npi",_setNpi);
    SET_DICT_INTEGER(o,@"set-encoding",_setEncoding);
    SET_DICT_INTEGER(o,@"set-national",_setNational);
    SET_DICT_INTEGER(o,@"remove-digits",_removeDigits);
    SET_DICT_INTEGER(o,@"limit-digit-length",_limitDigitLength);
    SET_DICT_BOOLEAN(o,@"ansi-to-itu",_ansiToItu);
    SET_DICT_BOOLEAN(o,@"itu-to-ansi",_ituToAnsi);

}

- (UMSS7ConfigSCCPDestinationEntry *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSCCPDestinationEntry allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end

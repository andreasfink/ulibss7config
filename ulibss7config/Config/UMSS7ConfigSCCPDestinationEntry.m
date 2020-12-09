//
//  UMSS7ConfigSCCPDestinationGroupEntry.m
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSCCPDestinationEntry.h"
#import "UMSS7ConfigMacros.h"

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

- (void)appendConfigToString:(NSMutableString *)s
{
    [super appendConfigToString:s];
    APPEND_CONFIG_STRING(s,@"destination",_destination);
    APPEND_CONFIG_STRING(s,@"next-sccp-instance",_nextSccpInstance);
    APPEND_CONFIG_STRING(s,@"point-code",_dpc);
    APPEND_CONFIG_STRING(s,@"application-server",_applicationServer);
    APPEND_CONFIG_INTEGER(s,@"cost",_cost);
    APPEND_CONFIG_INTEGER(s,@"weigth",_weigth);
    APPEND_CONFIG_INTEGER(s,@"subsystem",_subsystem);
    //APPEND_CONFIG_INTEGER(s,@"ntt",_overrideCalledTT);
    APPEND_CONFIG_INTEGER(s,@"set-called-tt",_overrideCalledTT);
    APPEND_CONFIG_INTEGER(s,@"set-calling-tt",_overrideCallingTT);
    APPEND_CONFIG_STRING(s,@"add-prefix",_addPrefix);
    APPEND_CONFIG_STRING(s,@"add-postfix",_addPostfix);
    APPEND_CONFIG_STRING(s,@"mtp3",_mtp3Instance);
    APPEND_CONFIG_INTEGER(s,@"set-gti",_setGti);
    APPEND_CONFIG_INTEGER(s,@"set-nai",_setNai);
    APPEND_CONFIG_INTEGER(s,@"set-npi",_setNpi);
    APPEND_CONFIG_INTEGER(s,@"set-encoding",_setEncoding);
    APPEND_CONFIG_INTEGER(s,@"set-national",_setNational);
    APPEND_CONFIG_INTEGER(s,@"remove-digits",_removeDigits);
    APPEND_CONFIG_INTEGER(s,@"limit-digit-length",_limitDigitLength);

    APPEND_CONFIG_BOOLEAN(s,@"ansi-to-itu",_ansiToItu);
    APPEND_CONFIG_BOOLEAN(s,@"itu-to-ansi",_ituToAnsi);
}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];
    APPEND_DICT_STRING(dict,@"destination",_destination);
    APPEND_DICT_STRING(dict,@"next-sccp-instance",_nextSccpInstance);
    APPEND_DICT_STRING(dict,@"point-code",_dpc);
    APPEND_DICT_STRING(dict,@"application-server",_applicationServer);
    APPEND_DICT_INTEGER(dict,@"cost",_cost);
    APPEND_DICT_INTEGER(dict,@"weight",_weigth);
    APPEND_DICT_INTEGER(dict,@"subsystem",_subsystem);
    //APPEND_DICT_INTEGER(dict,@"ntt",_overrideCalledTT);
    APPEND_DICT_INTEGER(dict,@"set-called-tt",_overrideCalledTT);
    APPEND_DICT_INTEGER(dict,@"set-calling-tt",_overrideCallingTT);
    APPEND_DICT_STRING(dict,@"add-prefix",_addPrefix);
    APPEND_DICT_STRING(dict,@"add-prefix",_addPostfix);
    APPEND_DICT_STRING(dict,@"mtp3",_mtp3Instance);
    APPEND_DICT_INTEGER(dict,@"set-gti",_setGti);
    APPEND_DICT_INTEGER(dict,@"set-nai",_setNai);
    APPEND_DICT_INTEGER(dict,@"set-npi",_setNpi);
    APPEND_DICT_INTEGER(dict,@"set-encoding",_setEncoding);
    APPEND_DICT_INTEGER(dict,@"set-national",_setNational);
    APPEND_DICT_INTEGER(dict,@"remove-digits",_removeDigits);
    APPEND_DICT_INTEGER(dict,@"limit-digit-length",_limitDigitLength);
    APPEND_DICT_BOOLEAN(dict,@"ansi-to-itu",_ansiToItu);
    APPEND_DICT_BOOLEAN(dict,@"itu-to-ansi",_ituToAnsi);

    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_FILTERED_STRING(dict,@"destination",_destination);
    SET_DICT_STRING(dict,@"next-sccp-instance",_nextSccpInstance);
    SET_DICT_STRING(dict,@"point-code",_dpc);
    SET_DICT_FILTERED_STRING(dict,@"application-server",_applicationServer);
    SET_DICT_INTEGER(dict,@"cost",_weight);
    SET_DICT_INTEGER(dict,@"weigth",_weight);
    SET_DICT_INTEGER(dict,@"subsystem",_subsystem);
    SET_DICT_INTEGER(dict,@"ntt",_overrideCalledTT);
    SET_DICT_INTEGER(dict,@"set-called-tt",_overrideCalledTT);
    SET_DICT_INTEGER(dict,@"set-calling-tt",_overrideCallingTT);
    SET_DICT_STRING(dict,@"add-prefix",_addPrefix);
    SET_DICT_STRING(dict,@"add-postfix",_addPostfix);
    SET_DICT_STRING(dict,@"mtp3",_mtp3Instance);
    SET_DICT_INTEGER(dict,@"set-gti",_setGti);
    SET_DICT_INTEGER(dict,@"set-nai",_setNai);
    SET_DICT_INTEGER(dict,@"set-npi",_setNpi);
    SET_DICT_INTEGER(dict,@"set-encoding",_setEncoding);
    SET_DICT_INTEGER(dict,@"set-national",_setNational);
    SET_DICT_INTEGER(dict,@"remove-digits",_removeDigits);
    SET_DICT_INTEGER(dict,@"limit-digit-length",_limitDigitLength);
    SET_DICT_BOOLEAN(dict,@"ansi-to-itu",_ansiToItu);
    SET_DICT_BOOLEAN(dict,@"itu-to-ansi",_ituToAnsi);

}

- (UMSS7ConfigSCCPDestinationEntry *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSCCPDestinationEntry allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end

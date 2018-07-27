//
//  UMSS7ConfigSMSC.m
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSMSC.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigSMSC

+ (NSString *)type
{
    return @"smsc";
}

- (NSString *)type
{
    return [UMSS7ConfigSMSC type];
}


- (UMSS7ConfigSMSC *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(s,@"attach-to",_attachTo);
    APPEND_CONFIG_STRING(s,@"number",_number);
    APPEND_CONFIG_STRING(s,@"full-trace-directory",_fullTraceDirectory);
    APPEND_CONFIG_STRING(s,@"timeout-trace-directory",_timeoutTraceDirectory);
    APPEND_CONFIG_INTEGER(s,@"smsc-translation-type",_smscTranslationType);
    APPEND_CONFIG_INTEGER(s,@"srism-translation-type",_srismTranslationType);
    APPEND_CONFIG_INTEGER(s,@"forwardsm-translation-type",_forwardsmTranslationType);
    APPEND_CONFIG_DOUBLE(s,@"timeout",_timeout);

}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];

    APPEND_DICT_STRING(dict,@"attach-to",_attachTo);
    APPEND_DICT_STRING(dict,@"number",_number);
    APPEND_DICT_STRING(dict,@"full-trace-directory",_fullTraceDirectory);
    APPEND_DICT_STRING(dict,@"timeout-trace-directory",_timeoutTraceDirectory);
    APPEND_DICT_INTEGER(dict,@"smsc-translation-type",_smscTranslationType);
    APPEND_DICT_INTEGER(dict,@"srism-translation-type",_srismTranslationType);
    APPEND_DICT_INTEGER(dict,@"forwardsm-translation-type",_forwardsmTranslationType);
    APPEND_DICT_DOUBLE(dict,@"timeout",_timeout);
    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_STRING(dict,@"attach-to",_attachTo);
    SET_DICT_STRING(dict,@"number",_number);
    SET_DICT_STRING(dict,@"full-trace-directory",_fullTraceDirectory);
    SET_DICT_STRING(dict,@"timeout-trace-directory",_timeoutTraceDirectory);
    SET_DICT_INTEGER(dict,@"smsc-translation-type",_smscTranslationType);
    SET_DICT_INTEGER(dict,@"srism-translation-type",_srismTranslationType);
    SET_DICT_INTEGER(dict,@"forwardsm-translation-type",_forwardsmTranslationType);
    SET_DICT_DOUBLE(dict,@"timeout",_timeout);
}


- (UMSS7ConfigSMSC *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSMSC allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}
@end



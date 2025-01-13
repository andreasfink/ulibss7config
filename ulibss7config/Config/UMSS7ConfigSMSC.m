//
//  UMSS7ConfigSMSC.m
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSMSC.h"
#import "UMSS7ConfigMacroHelper.h"

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


- (void)appendConfigToString:(NSMutableString *)o
{
    [super appendConfigToString:o];
    APPEND_CONFIG_STRING(o,@"attach-to",_attachTo);
    APPEND_CONFIG_STRING(o,@"number",_number);
    APPEND_CONFIG_STRING(o,@"full-trace-directory",_fullTraceDirectory);
    APPEND_CONFIG_STRING(o,@"timeout-trace-directory",_timeoutTraceDirectory);
    APPEND_CONFIG_INTEGER(o,@"smsc-translation-type",_smscTranslationType);
    APPEND_CONFIG_INTEGER(o,@"srism-translation-type",_srismTranslationType);
    APPEND_CONFIG_INTEGER(o,@"forwardsm-translation-type",_forwardsmTranslationType);
    APPEND_CONFIG_DOUBLE(o,@"timeout",_timeout);

}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];

    APPEND_DICT_STRING(o,@"attach-to",_attachTo);
    APPEND_DICT_STRING(o,@"number",_number);
    APPEND_DICT_STRING(o,@"full-trace-directory",_fullTraceDirectory);
    APPEND_DICT_STRING(o,@"timeout-trace-directory",_timeoutTraceDirectory);
    APPEND_DICT_INTEGER(o,@"smsc-translation-type",_smscTranslationType);
    APPEND_DICT_INTEGER(o,@"srism-translation-type",_srismTranslationType);
    APPEND_DICT_INTEGER(o,@"forwardsm-translation-type",_forwardsmTranslationType);
    APPEND_DICT_DOUBLE(o,@"timeout",_timeout);
    return dict;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
    SET_DICT_STRING(o,@"attach-to",_attachTo);
    SET_DICT_STRING(o,@"number",_number);
    SET_DICT_STRING(o,@"full-trace-directory",_fullTraceDirectory);
    SET_DICT_STRING(o,@"timeout-trace-directory",_timeoutTraceDirectory);
    SET_DICT_INTEGER(o,@"smsc-translation-type",_smscTranslationType);
    SET_DICT_INTEGER(o,@"srism-translation-type",_srismTranslationType);
    SET_DICT_INTEGER(o,@"forwardsm-translation-type",_forwardsmTranslationType);
    SET_DICT_DOUBLE(o,@"timeout",_timeout);
}


- (UMSS7ConfigSMSC *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSMSC allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}
@end



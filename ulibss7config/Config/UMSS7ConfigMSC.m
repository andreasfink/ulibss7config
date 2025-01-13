//
//  UMSS7ConfigMSC.m
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigMSC.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigMSC

+ (NSString *)type
{
    return @"msc";
}

- (NSString *)type
{
    return [UMSS7ConfigMSC type];
}


- (UMSS7ConfigMSC *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_DOUBLE(o,@"timeout",_timeout);
    APPEND_CONFIG_STRING(o,@"sms-forward-url",_smsForwardUrl);
    APPEND_CONFIG_INTEGER(o,@"sms-error-code",_smsErrorCode);
    APPEND_CONFIG_INTEGER(o,@"answer-translation-type",_answerTranslationType);
    APPEND_CONFIG_STRING(o,@"imsi-pool",_imsiPool);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];

    APPEND_DICT_STRING(o,@"attach-to",_attachTo);
    APPEND_DICT_STRING(o,@"number",_number);
    APPEND_DICT_DOUBLE(o,@"timeout",_timeout);
    APPEND_DICT_STRING(o,@"sms-forward-url",_smsForwardUrl);
    APPEND_DICT_INTEGER(o,@"sms-error-code",_smsErrorCode);
    APPEND_DICT_INTEGER(o,@"answer-translation-type",_answerTranslationType);
    APPEND_DICT_STRING(o,@"imsi-pool",_imsiPool);

    return dict;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
    SET_DICT_STRING(o,@"attach-to",_attachTo);
    SET_DICT_STRING(o,@"number",_number);
    SET_DICT_DOUBLE(o,@"timeout",_timeout);
    SET_DICT_STRING(o,@"sms-forward-url",_smsForwardUrl);
    SET_DICT_INTEGER(o,@"sms-error-code",_smsErrorCode);
    SET_DICT_INTEGER(o,@"answer-translation-type",_answerTranslationType);
    SET_DICT_STRING(o,@"imsi-pool",_imsiPool);
}

- (UMSS7ConfigMSC *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigMSC allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end



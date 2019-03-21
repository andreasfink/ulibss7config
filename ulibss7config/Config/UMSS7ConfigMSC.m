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


- (void)appendConfigToString:(NSMutableString *)s
{
    [super appendConfigToString:s];
    APPEND_CONFIG_STRING(s,@"attach-to",_attachTo);
    APPEND_CONFIG_STRING(s,@"number",_number);
    APPEND_CONFIG_DOUBLE(s,@"timeout",_timeout);
    APPEND_CONFIG_STRING(s,@"sms-forward-url",_smsForwardUrl);
    APPEND_CONFIG_INTEGER(s,@"answer-translation-type",_answerTranslationType);
    APPEND_CONFIG_STRING(s,@"imsi-pool",_imsiPool);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];

    APPEND_DICT_STRING(dict,@"attach-to",_attachTo);
    APPEND_DICT_STRING(dict,@"number",_number);
    APPEND_DICT_DOUBLE(dict,@"timeout",_timeout);
    APPEND_DICT_STRING(dict,@"sms-forward-url",_smsForwardUrl);
    APPEND_DICT_INTEGER(dict,@"answer-translation-type",_answerTranslationType);
    APPEND_DICT_STRING(dict,@"imsi-pool",_imsiPool);

    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_STRING(dict,@"attach-to",_attachTo);
    SET_DICT_STRING(dict,@"number",_number);
    SET_DICT_DOUBLE(dict,@"timeout",_timeout);
    SET_DICT_STRING(dict,@"sms-forward-url",_smsForwardUrl);
    SET_DICT_INTEGER(dict,@"answer-translation-type",_answerTranslationType);
    SET_DICT_STRING(dict,@"imsi-pool",_imsiPool);
}

- (UMSS7ConfigMSC *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigMSC allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end



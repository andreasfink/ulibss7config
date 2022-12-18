//
//  UMSS7ConfigSGSN.m
//  ulibss7config
//
//  Created by Andreas Fink on 08.06.20.
//  Copyright © 2020 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSGSN.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigSGSN


+ (NSString *)type
{
    return @"sgsn";
}

- (NSString *)type
{
    return [UMSS7ConfigSGSN type];
}


- (UMSS7ConfigSGSN *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_INTEGER(s,@"answer-translation-type",_answerTranslationType);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];

    APPEND_DICT_STRING(dict,@"attach-to",_attachTo);
    APPEND_DICT_STRING(dict,@"number",_number);
    APPEND_DICT_DOUBLE(dict,@"timeout",_timeout);
    APPEND_DICT_INTEGER(dict,@"answer-translation-type",_answerTranslationType);
    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_STRING(dict,@"attach-to",_attachTo);
    SET_DICT_STRING(dict,@"number",_number);
    SET_DICT_DOUBLE(dict,@"timeout",_timeout);
    SET_DICT_INTEGER(dict,@"answer-translation-type",_answerTranslationType);
}

- (UMSS7ConfigSGSN *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSGSN allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end



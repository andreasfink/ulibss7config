//
//  UMSS7ConfigCAMEL.m
//  ulibss7config
//
//  Created by Andreas Fink on 09.03.20.
//  Copyright © 2020 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigCAMEL.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigCAMEL


+ (NSString *)type
{
    return @"camel";
}

- (NSString *)type
{
    return [UMSS7ConfigCAMEL type];
}


- (UMSS7ConfigCAMEL *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(s,@"address",_address);
    APPEND_CONFIG_STRING(s,@"ssn",_ssn);
    APPEND_CONFIG_DOUBLE(s,@"timeout",_timeout);
}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];

    APPEND_DICT_STRING(dict,@"attach-to",_attachTo);
    APPEND_DICT_STRING(dict,@"address",_address);
    APPEND_DICT_STRING(dict,@"ssn",_ssn);
    APPEND_DICT_DOUBLE(dict,@"timeout",_timeout);
    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_STRING(dict,@"attach-to",_attachTo);
    SET_DICT_STRING(dict,@"address",_address);
    SET_DICT_STRING(dict,@"ssn",_ssn);
    SET_DICT_DOUBLE(dict,@"timeout",_timeout);
}

- (UMSS7ConfigCAMEL *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigCAMEL allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end

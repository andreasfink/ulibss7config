//
//  UMSS7ConfigTCAP.m
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigTCAP.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigTCAP


+ (NSString *)type
{
    return @"tcap";
}

- (NSString *)type
{
    return [UMSS7ConfigTCAP type];
}

- (UMSS7ConfigTCAP *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(s,@"variant",_variant);
    APPEND_CONFIG_STRING(s,@"subsystem",_subsystem);
    APPEND_CONFIG_STRING(s,@"number",_number);
    APPEND_CONFIG_STRING(s,@"transaction-id-range",_range);
    APPEND_CONFIG_DOUBLE(s,@"timeout",_timeout);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];

    APPEND_DICT_STRING(dict,@"attach-to",_attachTo);
    APPEND_DICT_STRING(dict,@"variant",_variant);
    APPEND_DICT_STRING(dict,@"subsystem",_subsystem);
    APPEND_DICT_STRING(dict,@"number",_number);
    APPEND_DICT_STRING(dict,@"transaction-id-range",_range);
    APPEND_DICT_DOUBLE(dict,@"timeout",_timeout);

    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_STRING(dict,@"attach-to",_attachTo);
    SET_DICT_STRING(dict,@"variant",_variant);
    SET_DICT_STRING(dict,@"attach-ssn",_subsystem);/* backwards compatibility */
    SET_DICT_STRING(dict,@"subsystem",_subsystem);
    SET_DICT_STRING(dict,@"attach-number",_number);/* backwards compatibility */
    SET_DICT_STRING(dict,@"number",_number);
    SET_DICT_STRING(dict,@"transaction-id-range",_range);
    SET_DICT_DOUBLE(dict,@"timeout",_timeout);
}

- (UMSS7ConfigTCAP *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigTCAP allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}


@end

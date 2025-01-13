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

- (void)appendConfigToString:(NSMutableString *)o
{
    [super appendConfigToString:o];
    APPEND_CONFIG_STRING(o,@"attach-to",_attachTo);
    APPEND_CONFIG_STRING(o,@"variant",_variant);
    APPEND_CONFIG_STRING(o,@"subsystem",_subsystem);
    APPEND_CONFIG_STRING(o,@"number",_number);
    APPEND_CONFIG_STRING(o,@"transaction-id-range",_range);
    APPEND_CONFIG_DOUBLE(o,@"timeout",_timeout);
    APPEND_CONFIG_STRING(o,@"transaction-id-pool-type",_poolType);

}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];

    APPEND_DICT_STRING(o,@"attach-to",_attachTo);
    APPEND_DICT_STRING(o,@"variant",_variant);
    APPEND_DICT_STRING(o,@"subsystem",_subsystem);
    APPEND_DICT_STRING(o,@"number",_number);
    APPEND_DICT_STRING(o,@"transaction-id-range",_range);
    APPEND_DICT_DOUBLE(o,@"timeout",_timeout);
    APPEND_DICT_STRING(o,@"transaction-id-pool-type",_poolType);

    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
    SET_DICT_STRING(o,@"attach-to",_attachTo);
    SET_DICT_STRING(o,@"variant",_variant);
    SET_DICT_STRING(o,@"attach-ssn",_subsystem);/* backwards compatibility */
    SET_DICT_STRING(o,@"subsystem",_subsystem);
    SET_DICT_STRING(o,@"attach-number",_number);/* backwards compatibility */
    SET_DICT_STRING(o,@"number",_number);
    SET_DICT_STRING(o,@"transaction-id-range",_range);
    SET_DICT_STRING(o,@"transaction-id-pool-type",_poolType);
    SET_DICT_DOUBLE(o,@"timeout",_timeout);
}

- (UMSS7ConfigTCAP *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigTCAP allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}


@end

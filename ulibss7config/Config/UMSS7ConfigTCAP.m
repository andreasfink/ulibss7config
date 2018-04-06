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
    APPEND_CONFIG_INTEGER(s,@"subsystem",_subsystem);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];

    APPEND_DICT_STRING(dict,@"attach-to",_attachTo);
    APPEND_DICT_STRING(dict,@"variant",_variant);
    APPEND_DICT_INTEGER(dict,@"subsystem",_subsystem);
    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_STRING(dict,@"attach-to",_attachTo);
    SET_DICT_STRING(dict,@"variant",_variant);
    SET_DICT_INTEGER(dict,@"subsystem",_subsystem);

}

- (UMSS7ConfigTCAP *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigTCAP allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}


@end

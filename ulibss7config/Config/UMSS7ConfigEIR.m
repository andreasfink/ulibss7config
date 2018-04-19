//
//  UMSS7ConfigEIR.m
//  ulibss7config
//
//  Created by Andreas Fink on 19.04.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigEIR.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigEIR


+ (NSString *)type
{
    return @"eir";
}

- (NSString *)type
{
    return [UMSS7ConfigEIR type];
}


- (UMSS7ConfigEIR *)initWithConfig:(NSDictionary *)dict
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
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];

    APPEND_DICT_STRING(dict,@"attach-to",_attachTo);
    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_STRING(dict,@"attach-to",_attachTo);
}


- (UMSS7ConfigMSC *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigMSC allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end



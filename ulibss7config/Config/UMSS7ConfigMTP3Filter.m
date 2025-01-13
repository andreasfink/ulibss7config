//
//  UMSS7ConfigMTP3Filter.m
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigMTP3Filter.h"
#import "UMSS7ConfigMTP3FilterEntry.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigMTP3Filter

+ (NSString *)type
{
    return @"mtp3-filter";
}
- (NSString *)type
{
    return [UMSS7ConfigMTP3Filter type];
}

- (UMSS7ConfigMTP3Filter *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(o,@"default-result",_defaultResult);
    APPEND_CONFIG_STRING(o,@"plug-in",_plugIn);
    for(UMSS7ConfigMTP3FilterEntry *e in _subEntries)
    {
        [s appendString:@"\n"];
        [e appendConfigToString:s];
    }
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
    APPEND_DICT_STRING(o,@"default-result",_defaultResult);
    APPEND_DICT_STRING(o,@"plug-in",_plugIn);

    return dict;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
    SET_DICT_STRING(o,@"default-result",_defaultResult);
    SET_DICT_STRING(o,@"plug-in",_plugIn);
}

- (void)setSubConfig:(NSArray *)configs
{
    for(NSDictionary *config in configs)
    {
        UMSS7ConfigMTP3FilterEntry *entry = [[UMSS7ConfigMTP3FilterEntry alloc]initWithConfig:config];
        [_subEntries addObject:entry];
    }
}

- (UMSS7ConfigMTP3Filter *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigMTP3Filter allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}


@end

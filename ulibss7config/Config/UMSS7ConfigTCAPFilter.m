//
//  UMSS7ConfigTCAPFilter.m
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigTCAPFilter.h"
#import "UMSS7ConfigMacros.h"
#import "UMSS7ConfigTCAPFilterEntry.h"

@implementation UMSS7ConfigTCAPFilter

+ (NSString *)type
{
    return @"tcap-filter";
}
- (NSString *)type
{
    return [UMSS7ConfigTCAPFilter type];
}

- (UMSS7ConfigTCAPFilter *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_INTEGER(s,@"bypass-translation-type",_bypassTranslationType);
    APPEND_CONFIG_STRING(s,@"default-result",_defaultResult);
    for(UMSS7ConfigTCAPFilterEntry *e in _subEntries)
    {
        [s appendString:@"\n"];
        [e appendConfigToString:s];
    }
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];
    APPEND_DICT_INTEGER(dict,@"bypass-translation-type",_bypassTranslationType);
    APPEND_DICT_STRING(dict,@"default-result",_defaultResult);
    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_INTEGER(dict,@"bypass-translation-type",_bypassTranslationType);
    SET_DICT_STRING(dict,@"default-result",_defaultResult);
}

- (void)setSubConfig:(NSArray *)configs
{
    for(NSDictionary *config in configs)
    {
        UMSS7ConfigTCAPFilterEntry *entry = [[UMSS7ConfigTCAPFilterEntry alloc]initWithConfig:config];
        [_subEntries addObject:entry];
    }
}


- (UMSS7ConfigTCAPFilter *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigTCAPFilter allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}



@end


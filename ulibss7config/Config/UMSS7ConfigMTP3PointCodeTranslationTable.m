//
//  UMSS7ConfigMTP3PointCodeTranslationTable.m
//  ulibss7config
//
//  Created by Andreas Fink on 04.11.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigMTP3PointCodeTranslationTable.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigMTP3PointCodeTranslationTable


+ (NSString *)type
{
    return @"mtp3-pointcode-translation";
}

- (NSString *)type
{
    return [UMSS7ConfigMTP3PointCodeTranslationTable type];
}

- (UMSS7ConfigMTP3PointCodeTranslationTable *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(s,@"default-local-pc",_defaultLocalPc);
    APPEND_CONFIG_STRING(s,@"default-remote-pc",_defaultLocalPc);
    APPEND_CONFIG_INTEGER(s,@"local-ni",_localNi);
    APPEND_CONFIG_INTEGER(s,@"remote-ni",_remoteNi);
    APPEND_CONFIG_ARRAY_VERBOSE(s,@"map",_pcmap)
}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];
    APPEND_DICT_STRING(dict,@"default-local-pc",_defaultLocalPc);
    APPEND_DICT_STRING(dict,@"default-remote-pc",_defaultLocalPc);
    APPEND_DICT_INTEGER(dict,@"local-ni",_localNi);
    APPEND_DICT_INTEGER(dict,@"remote-ni",_remoteNi);
    APPEND_DICT_ARRAY(dict,@"map",_pcmap);
    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_STRING(dict,@"default-local-pc",_defaultLocalPc);
    SET_DICT_STRING(dict,@"default-remote-pc",_defaultLocalPc);
    SET_DICT_INTEGER(dict,@"local-ni",_localNi);
    SET_DICT_INTEGER(dict,@"remote-ni",_remoteNi);
    SET_DICT_ARRAY(dict,@"map",_pcmap);
}

- (UMSS7ConfigMTP3PointCodeTranslationTable *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigMTP3PointCodeTranslationTable allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end

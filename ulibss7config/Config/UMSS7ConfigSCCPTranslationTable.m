//
//  UMSS7ConfigSCCPTranslationTable.m
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSCCPTranslationTable.h"
#import "UMSS7ConfigSCCPTranslationTableEntry.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigSCCPTranslationTable


+ (NSString *)type
{
    return @"sccp-translation-table";
}

- (NSString *)type
{
    return [UMSS7ConfigSCCPTranslationTable type];
}


- (UMSS7ConfigSCCPTranslationTable *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(s,@"sccp",_sccp);
    APPEND_CONFIG_INTEGER(s,@"tt",_tt);
    APPEND_CONFIG_INTEGER(s,@"gti",_gti);
    APPEND_CONFIG_INTEGER(s,@"np",_np);
    APPEND_CONFIG_INTEGER(s,@"nai",_nai);

    for(UMSS7ConfigSCCPTranslationTableEntry *e in _subEntries)
    {
        [s appendString:@"\n"];
        [e appendConfigToString:s];
    }

}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];

    APPEND_DICT_STRING(dict,@"sccp",_sccp);
    APPEND_DICT_INTEGER(dict,@"tt",_tt);
    APPEND_DICT_INTEGER(dict,@"gti",_gti);
    APPEND_DICT_INTEGER(dict,@"np",_np);
    APPEND_DICT_INTEGER(dict,@"nai",_nai);
    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_STRING(dict,@"sccp",_sccp);
    SET_DICT_INTEGER(dict,@"tt",_tt);
    SET_DICT_INTEGER(dict,@"gti",_gti);
    SET_DICT_INTEGER(dict,@"np",_np);
    SET_DICT_INTEGER(dict,@"nai",_nai);
}


- (void)setSubConfig:(NSArray *)configs
{
    for(NSDictionary *config in configs)
    {
        UMSS7ConfigSCCPTranslationTableEntry *entry = [[UMSS7ConfigSCCPTranslationTableEntry alloc]initWithConfig:config];
        [_subEntries addObject:entry];
    }
}

- (UMSS7ConfigSCCPTranslationTable *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSCCPTranslationTable allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end


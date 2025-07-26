//
//  UMSS7ConfigSCCPTranslationTable.m
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSCCPTranslationTable.h"
#import "UMSS7ConfigSCCPTranslationTableEntry.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigSCCPTranslationTable


+ (NSString *)groupName
{
    return @"sccp-translation-table";
}

- (NSString *)groupName
{
    return [UMSS7ConfigSCCPTranslationTable groupName];
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

- (void)appendConfigToString:(NSMutableString *)o
{
    [super appendConfigToString:o];
#include "UMSS7Config_macroAppendConfig.h"
#include "UMSS7ConfigSCCPTranslationTable.def.h"
#include "UMSS7Config_macroClear.h"

    for(UMSS7ConfigSCCPTranslationTableEntry *e in _subEntries)
    {
        [o appendString:@"\n"];
        [e appendConfigToString:o];
    }
}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];

#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigSCCPTranslationTable.def.h"
#include "UMSS7Config_macroClear.h"

    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigSCCPTranslationTable.def.h"
#include "UMSS7Config_macroClear.h"
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


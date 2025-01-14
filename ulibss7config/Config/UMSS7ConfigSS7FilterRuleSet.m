//
//  UMSS7ConfigSS7FilterRuleSet.m
//  ulibss7config
//
//  Created by Andreas Fink on 17.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSS7FilterRuleSet.h"
#import "UMSS7ConfigSS7FilterRule.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigSS7FilterRuleSet


+ (NSString *)type
{
    return @"ss7-filter-ruleset";
}

- (NSString *)type
{
    return [UMSS7ConfigSS7FilterRuleSet type];
}

- (UMSS7ConfigSS7FilterRuleSet *)init
{
    self = [super init];
    if(self)
    {
        _entries = [[UMSynchronizedArray alloc]init];
    }
    return self;
}

- (UMSS7ConfigSS7FilterRuleSet *)initWithConfig:(NSDictionary *)dict
{
    self = [super initWithConfig:dict];
    if(self)
    {
        _entries = [[UMSynchronizedArray alloc]init];
        [self setConfig:dict];
    }
    return self;
}



- (void)appendConfigToString:(NSMutableString *)o
{
    [super appendConfigToString:o];
#include "UMSS7Config_macroAppendConfig.h"
#include "UMSS7ConfigSS7FilterRuleSet.def.h"
#include "UMSS7Config_macroClear.h"
}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigSS7FilterRuleSet.def.h"
#include "UMSS7Config_macroClear.h"
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigSS7FilterRuleSet.def.h"
#include "UMSS7Config_macroClear.h"

    if(o[@"rules"])
    {
        id b = o[@"rules"];
        if([b isKindOfClass:[NSArray class]])
        {
            NSArray *a = (NSArray *)b;
            _entries = [[UMSynchronizedArray alloc]init];
            for(id c in a)
            {
                if([c isKindOfClass:[NSDictionary class]])
                {
                    NSDictionary *d = (NSDictionary *)c;
                    UMSS7ConfigSS7FilterRule *rule = [[UMSS7ConfigSS7FilterRule alloc]initWithConfig:d];
                    [_entries addObject:rule];
                }
            }
        }
    }
}

- (UMSS7ConfigSS7FilterRule *)getRuleAtIndex:(NSInteger)idx
{
    return _entries[idx];
}

- (void)setRule:(UMSS7ConfigSS7FilterRule *)rule atIndex:(NSInteger)idx
{
    _entries[idx] = rule;
}

- (void)insertRule:(UMSS7ConfigSS7FilterRule *)rule  atIndex:(NSInteger)idx
{
    [_entries insertObject:rule atIndex:idx];
}

- (void)appendRule:(UMSS7ConfigSS7FilterRule *)rule
{
    [_entries addObject:rule];
}

- (void)removeRuleAtIndex:(NSInteger)idx
{
    [_entries removeObjectAtIndex:idx];

}

- (NSArray<UMSS7ConfigSS7FilterRule *> *)getAllRules
{
    return [_entries arrayCopy];
}

- (NSArray<NSDictionary *> *)subConfigs
{
    NSMutableArray *configs = [[NSMutableArray alloc]init];
    for(UMSS7ConfigSS7FilterRule *co in _entries)
    {
        [configs addObject:[co.config dictionaryCopy]];
    }
    return configs;
}

@end

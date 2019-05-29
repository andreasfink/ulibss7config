//
//  UMSS7ConfigSS7FilterRuleset.m
//  ulibss7config
//
//  Created by Andreas Fink on 17.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSS7FilterRuleset.h"
#import "UMSS7ConfigSS7FilterRule.h"

@implementation UMSS7ConfigSS7FilterRuleset

- (UMSS7ConfigSS7FilterRuleset *)init
{
    self = [super init];
    if(self)
    {
        _entries = [[UMSynchronizedArray alloc]init];
    }
    return self;
}

- (UMSS7ConfigSS7FilterRuleset *)initWithConfig:(NSDictionary *)dict
{
    self = [super initWithConfig:dict];
    if(self)
    {
        _entries = [[UMSynchronizedArray alloc]init];
        [self setConfig:dict];
    }
    return self;
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

@end

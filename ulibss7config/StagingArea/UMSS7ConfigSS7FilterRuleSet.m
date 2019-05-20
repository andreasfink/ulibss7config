//
//  UMSS7ConfigSS7FilterRuleSet.m
//  ulibss7config
//
//  Created by Andreas Fink on 17.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSS7FilterRuleSet.h"
#import "UMSS7ConfigSS7FilterRule.h"

@implementation UMSS7ConfigSS7FilterRuleSet



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
- (void)removeRuleAtPosition:(NSInteger)idx
{
    [_entries removeObjectAtIndex:idx];

}

- (NSArray<UMSS7ConfigSS7FilterRule *> *)getAllRules
{
    return [_entries arrayCopy];
}

@end

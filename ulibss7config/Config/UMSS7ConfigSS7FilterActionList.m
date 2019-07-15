//
//  UMSS7ConfigSS7FilterActionList.m
//  ulibss7config
//
//  Created by Andreas Fink on 17.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSS7FilterActionList.h"
#import "UMSS7ConfigMacros.h"
#import "UMSS7ConfigSS7FilterAction.h"

@implementation UMSS7ConfigSS7FilterActionList

- (UMSS7ConfigSS7FilterActionList *)init
{
    self = [super init];
    if(self)
    {
        _entries = [[UMSynchronizedArray alloc]init];
    }
    return self;
}

- (UMSS7ConfigSS7FilterActionList *)initWithConfig:(NSDictionary *)dict
{
    self = [super initWithConfig:dict];
    if(self)
    {
        _entries = [[UMSynchronizedArray alloc]init];
        [self setConfig:dict];
    }
    return self;
}

+ (NSString *)type
{
	return @"ss7-filter-action-list";
}

- (NSString *)type
{
	return [UMSS7ConfigSS7FilterActionList type];
}


- (void)appendConfigToString:(NSMutableString *)s
{
	[super appendConfigToString:s];
    APPEND_CONFIG_DATE(s,@"created-timestamp",_createdTimestamp);
    APPEND_CONFIG_DATE(s,@"modified-timestamp",_modifiedTimestamp);
}

- (UMSynchronizedSortedDictionary *)config
{
	UMSynchronizedSortedDictionary *dict = [super config];
    APPEND_DICT_DATE(dict,@"created-timestamp",_createdTimestamp);
    APPEND_DICT_DATE(dict,@"modified-timestamp",_modifiedTimestamp);
    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_DATE(dict,@"created-timestamp",_createdTimestamp);
    SET_DICT_DATE(dict,@"modified-timestamp",_modifiedTimestamp);
}

- (UMSS7ConfigSS7FilterActionList *)copyWithZone:(NSZone *)zone
{
	UMSynchronizedSortedDictionary *currentConfig = [self config];
	return [[UMSS7ConfigSS7FilterActionList allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

- (UMSS7ConfigSS7FilterAction *)getActionAtIndex:(NSInteger)idx
{
    return _entries[idx];
}

- (void)setAction:(UMSS7ConfigSS7FilterAction *)action atIndex:(NSInteger)idx
{
    _entries[idx] = action;
}

- (void)insertAction:(UMSS7ConfigSS7FilterAction *)action  atIndex:(NSInteger)idx
{
    [_entries insertObject:action atIndex:idx];
}

- (void)appendAction:(UMSS7ConfigSS7FilterAction *)rule
{
    [_entries addObject:rule];
}

- (void)removeActionAtIndex:(NSInteger)idx
{
    [_entries removeObjectAtIndex:idx];

}

- (NSArray<UMSS7ConfigSS7FilterAction *> *)getAllActions
{
    return [_entries arrayCopy];
}

- (NSArray<NSDictionary *> *)subConfigs
{
    NSMutableArray *configs = [[NSMutableArray alloc]init];
    for(UMSS7ConfigSS7FilterAction *co in _entries)
    {
        [configs addObject:[co.config dictionaryCopy]];
    }
    return configs;
}

@end

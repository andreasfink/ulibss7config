//
//  UMSS7ConfigStagingAreaStorage.m
//  ulibss7config
//
//  Created by Andreas Fink on 19.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSS7FilterStagingArea.h"
#import "UMSS7ConfigMacros.h"
#import "ulib/UMMutex.h"
#import "UMSS7ConfigSS7FilterRuleSet.h"
#import "UMSS7ConfigSS7FilterRule.h"
#import "UMSS7ConfigSS7FilterActionList.h"
#import "UMSS7ConfigSS7FilterAction.h"

@implementation UMSS7ConfigSS7FilterStagingArea

- (UMSS7ConfigSS7FilterStagingArea *)initWithPath:(NSString *)path
{
    self = [super init];
    if(self)
    {
        _path = path;
        _filter_rule_set_dict = [[UMSynchronizedDictionary alloc]init];
        _filter_engines_dict = [[UMSynchronizedDictionary alloc]init];
        _filter_action_list_dict = [[UMSynchronizedDictionary alloc]init];
        _lock = [[UMMutex alloc]initWithName:@"mutex staging area"];
    }
    return self;
}


+ (NSString *)type
{
    return @"ss7-filter-staging-area";
}
- (NSString *)type
{
    return [UMSS7ConfigSS7FilterStagingArea type];
}

- (UMSS7ConfigSS7FilterStagingArea *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_DATE(s,@"created-timestamp",_createdTimestamp );
    APPEND_CONFIG_DATE(s,@"modified-timestamp",_modifiedTimestamp);
    APPEND_CONFIG_STRING(s,@"path",_path);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];
    APPEND_DICT_DATE(dict,@"created-timestamp",_createdTimestamp);
    APPEND_DICT_DATE(dict,@"modified-timestamp",_modifiedTimestamp);
    APPEND_DICT_STRING(dict,@"path",_path);

    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_DATE(dict,@"created-timestamp",_createdTimestamp);
    SET_DICT_DATE(dict,@"modified-timestamp",_modifiedTimestamp);
    SET_DICT_STRING(dict,@"path",_path);
}

- (UMSS7ConfigSS7FilterStagingArea *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    UMSS7ConfigSS7FilterStagingArea *c =  [[UMSS7ConfigSS7FilterStagingArea allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
    c.filter_rule_set_dict = [_filter_rule_set_dict copy];
    c.filter_engines_dict = [_filter_engines_dict copy];
    c.filter_action_list_dict = [_filter_action_list_dict copy];
    return c;
}




- (void)writeConfig
{
    [_lock lock];
    
    // Save self properties
    UMSynchronizedSortedDictionary *dict = self.config;
    
    // Rule-Sets with rules
    NSArray *keys = [_filter_rule_set_dict allKeys];
    for(NSString *key in keys)
    {
        UMSS7ConfigSS7FilterRuleSet *entry = _filter_rule_set_dict[key];
        UMSynchronizedSortedDictionary *rs = entry.config;
        rs[@"rules"] = entry.subConfigs;
        dict[key] = rs;
    }
    
    // Action-Lists with actions
    NSArray *actkeys  = [_filter_action_list_dict allKeys];
    for(NSString *k in actkeys)
    {
        UMSS7ConfigSS7FilterActionList *ls = _filter_action_list_dict[k];
        UMSynchronizedSortedDictionary *al = ls.config;
        al[@"actions"] = ls.subConfigs;
        dict[k] = al;
    }
    
    // Engines
    NSArray *engkeys  = [_filter_engines_dict allKeys];
    for(NSString *it in engkeys)
    {
        UMSS7ConfigSS7FilterActionList *l = _filter_action_list_dict[it];
        UMSynchronizedSortedDictionary *eng = l.config;
        dict[it] = eng;
    }
    
	NSError *err = NULL;
    NSString *jsonString = [dict jsonString];
    BOOL written = [jsonString writeToFile:_path atomically:YES encoding:NSUTF8StringEncoding error:&err];
    if (written) 
	{
		NSLog(@"Successfully written to path %@", _path);
	} 
	else 
	{
        NSLog(@"Error while writing staging-area name %@ with error %@",_path,[err localizedDescription]);
    }

    _dirty = NO;
    [_lock unlock];
}

- (void)deleteConfig:(NSString *)filePath
{
    [_lock lock];
    
    NSError *error;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL success = [fileManager removeItemAtPath:filePath error:&error];
    if (success)
    {
        NSLog(@"Successfully deleted file-path %@", filePath);
    }
    else
    {
        NSLog(@"Could not delete file -:%@ when file-path -:%@",[error localizedDescription], filePath);
    }
    
    [_lock unlock];
}

- (void)flushIfDirty
{
    if(_dirty==YES)
    {
        [self writeConfig];
    }
    _dirty=NO;
}

@end

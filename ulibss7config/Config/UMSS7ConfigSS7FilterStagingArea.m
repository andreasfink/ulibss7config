//
//  UMSS7ConfigStagingArea.m
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
        _name = [[path lastPathComponent] urldecode];
        _filter_rule_set_dict = [[UMSynchronizedDictionary alloc]init];
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

- (UMSS7ConfigSS7FilterStagingArea *)initWithConfig:(NSDictionary *)dict directory:(NSString *)dir
{
    self = [super initWithConfig:dict];
    if(self)
    {
        [self setConfig:dict];
        UMAssert(_name.length > 0,@"Name must exist for staging area");
        _path = [NSString stringWithFormat:@"%@/%@",dir,_name.urlencode];
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

- (void)copyFromStagingArea:(UMSS7ConfigSS7FilterStagingArea *)otherArea
{
    _createdTimestamp = otherArea.createdTimestamp;
    _modifiedTimestamp = otherArea.modifiedTimestamp;
}

- (void)writeConfig
{
    [_lock lock];
    
    // Save self properties
    UMSynchronizedSortedDictionary *dict = self.config;
    
    // Rule-Sets with rules
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    NSArray *keys = [_filter_rule_set_dict allKeys];
    for(NSString *key in keys)
    {
        UMSS7ConfigSS7FilterRuleSet *entry = _filter_rule_set_dict[key];
        UMSynchronizedSortedDictionary *rs = entry.config;
        rs[@"rules"] = entry.subConfigs;
        [arr addObject:rs];
    }
    dict[@"rulesets"] = arr;


    // Action-Lists with actions
    arr = [[NSMutableArray alloc]init];
    NSArray *actkeys  = [_filter_action_list_dict allKeys];
    for(NSString *k in actkeys)
    {
        UMSS7ConfigSS7FilterActionList *ls = _filter_action_list_dict[k];
        UMSynchronizedSortedDictionary *al = ls.config;
        al[@"actions"] = ls.subConfigs;
        [arr addObject:al];
        dict[k] = al;
    }
    dict[@"actionlists"] = arr;

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

- (void)loadFromFile
{
    NSString *filePath = _path;
    NSError *err = NULL;
#ifdef __APPLE__
    NSData *jsonData = [[NSData alloc]initWithContentsOfFile:filePath options:0 error:&err];
#else
    NSData *jsonData = [[NSData alloc]initWithContentsOfFile:filePath];
#endif
    if(err)
    {
        NSLog(@"Error while reading statistics %@ to %@: %@",_name,_path,err);
    }
    else
    {
        UMJsonParser *parser = [[UMJsonParser alloc]init];
        id obj = [parser objectWithData:jsonData];
        if([obj isKindOfClass:[NSDictionary class]])
        {
            NSDictionary *dict = (NSDictionary *)obj;
            [self setConfig:dict];
            id a = dict[@"rule-sets"];
            if([a isKindOfClass:[NSArray class]])
            {
                _filter_rule_set_dict = [[UMSynchronizedDictionary alloc]init];
                NSArray *arr = (NSArray *)a;
                for(id c in arr)
                {
                    if([c isKindOfClass:[NSDictionary class]])
                    {
                        NSDictionary *c_dict = (NSDictionary *)c;
                        UMSS7ConfigSS7FilterRuleSet *rs = [[UMSS7ConfigSS7FilterRuleSet alloc]initWithConfig:c_dict];
                        if(rs.name.length > 0)
                        {
                            _filter_rule_set_dict[rs.name] = rs;
                        }
                    }
                }
            }
            id b = dict[@"action-lists"];
            if([b isKindOfClass:[NSArray class]])
            {
                _filter_action_list_dict = [[UMSynchronizedDictionary alloc]init];
                NSArray *arr = (NSArray *)b;
                for(id c in arr)
                {
                    if([c isKindOfClass:[NSDictionary class]])
                    {
                        NSDictionary *c_dict = (NSDictionary *)c;
                        UMSS7ConfigSS7FilterActionList *list = [[UMSS7ConfigSS7FilterActionList alloc]initWithConfig:c_dict];
                        if(list.name.length > 0)
                        {
                            _filter_action_list_dict[list.name] = list;
                        }
                    }
                }
            }
        }
    }
}


@end

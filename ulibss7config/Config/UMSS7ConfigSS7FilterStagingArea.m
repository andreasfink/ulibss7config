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
            [self initWithConfig:dict];
            
            NSArray *keys = [dict allKeys];
            for(NSString *key in keys)
            {
                id obj2 = dict[key];
                if([obj2 isKindOfClass:[NSDictionary class]])
                {
                    NSDictionary *dict2 = (NSDictionary *)obj2;
                    NSArray *ks = [dict2 allKeys];
                    for(NSString *k in ks)
                    {
                    
                        if([k isEqualToString:@"group"])
                        {
                            
                            if([dict2[k] isEqualToString:@"ss7-filter-action-list"])
                            {
                                UMSS7ConfigSS7FilterActionList *list = [[UMSS7ConfigSS7FilterActionList alloc]initWithConfig:dict2];
                                NSArray *actkeys  = dict2[@"actions"];
                                for(NSDictionary *js_actions in actkeys)
                                {
                                    if([js_actions isKindOfClass:[NSDictionary class]])
                                    {
                                        // Create action
                                        UMSS7ConfigSS7FilterAction *action = [[UMSS7ConfigSS7FilterAction alloc]initWithConfig:js_actions];
                                        [list appendAction:action];
                                    }
                                }
                                
                                // Attach list-actions to staging area
                                self.filter_action_list_dict[dict2[@"name"]] = list;
                                
                                // end of reading
                                break;
                                
                            }
                            else if ([dict2[k] isEqualToString:@"ss7-filter-ruleset"])
                            {
                                UMSS7ConfigSS7FilterRuleSet *ls = [[UMSS7ConfigSS7FilterRuleSet alloc]initWithConfig:dict2];
                                NSArray *actRules  = dict2[@"rules"];
                                for(NSDictionary *js_rules in actRules)
                                {
                                    if([js_rules isKindOfClass:[NSDictionary class]])
                                    {
                                        // Create action
                                        UMSS7ConfigSS7FilterRule *rule = [[UMSS7ConfigSS7FilterRule alloc]initWithConfig:js_rules];
                                        [ls appendRule:rule];
                                    }
                                }

                                // Attach Rule-Sets to staging area
                                self.filter_rule_set_dict[dict2[@"name"]] = ls;
                                
                                // end of reading
                                break;
                                
                            }
                            else if ([dict2[k] isEqualToString:@"ss7-filter-engine"])
                            {
                                // TODO : Save engine
                                NSLog(@" Error : Not Implemented Save of Engine -: %@", dict2[k]);
                            }
                            else
                            {
                                NSLog(@" Error : Unkown group -: %@", dict2[k]);
                                
                            }

                            
                        }
                        else
                        {
                            NSLog(@" Info -: key[%@] - Val[%@]", k, dict2[k]);
                        }
                        
                        
                    
                    }
                }
            }
        }
    }
}


@end

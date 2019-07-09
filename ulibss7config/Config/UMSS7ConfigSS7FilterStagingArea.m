//
//  UMSS7ConfigStagingAreaStorage.m
//  ulibss7config
//
//  Created by Andreas Fink on 19.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSS7FilterStagingArea.h"
#import "UMSS7ConfigMacros.h"

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
        _dirtyTimer = [[UMTimer alloc]initWithTarget:self
                                            selector:@selector(dirtyCheck)
                                              object:NULL
                                             seconds:10.0
                                                name:@"dirty-config-timer"
                                             repeats:YES
                                     runInForeground:NO];

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


- (void)startDirtyTimer
{
    [_dirtyTimer start];
}

- (void)stopDirtyTimer
{
    [_dirtyTimer stop];
}


- (void)dirtyCheck
{
    if(_dirty==YES)
    {
        [self writeConfig];
    }
    _dirty=NO;
}

- (void)writeConfig
{
    /* FIXME */
}


@end

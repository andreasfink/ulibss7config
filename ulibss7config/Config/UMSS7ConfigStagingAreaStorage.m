//
//  UMSS7ConfigStagingAreaStorage.m
//  ulibss7config
//
//  Created by Andreas Fink on 19.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigStagingAreaStorage.h"

@implementation UMSS7ConfigStagingAreaStorage

- (UMSS7ConfigStagingAreaStorage *)initWithPath:(NSString *)path
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


- (UMSS7ConfigStagingAreaStorage *)copyWithZone:(NSZone *)zone
{
    UMSS7ConfigStagingAreaStorage *c = [[UMSS7ConfigStagingAreaStorage allocWithZone:zone]initWithPath:_path];
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
}
@end

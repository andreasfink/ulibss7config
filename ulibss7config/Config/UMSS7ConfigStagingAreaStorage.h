//
//  UMSS7ConfigStagingAreaStorage.h
//  ulibss7config
//
//  Created by Andreas Fink on 19.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import <ulib/ulib.h>

@class  UMSS7ConfigSS7FilterRuleset;
@class  UMSS7ConfigSS7FilterRule;
@class  UMSS7ConfigFilterEngine;
@class  UMSS7ConfigFilterActionList;
@class  UMSS7ConfigFilterLog;


@interface UMSS7ConfigStagingAreaStorage : UMObject
{
    NSString                 *_name;
    NSString                 *_path;
    UMSynchronizedDictionary *_filter_rule_set_dict;
    UMSynchronizedDictionary *_filter_engines_dict;
    UMSynchronizedDictionary *_filter_action_list_dict;
    BOOL                    _dirty;
    UMTimer                 *_dirtyTimer;
}

@property(readwrite,strong,atomic)  NSString                 *name;
@property(readwrite,strong,atomic)  NSString                 *path;
@property(readwrite,strong,atomic)  UMSynchronizedDictionary *filter_rule_set_dict;
@property(readwrite,strong,atomic)  UMSynchronizedDictionary *filter_engines_dict;
@property(readwrite,strong,atomic)  UMSynchronizedDictionary *filter_action_list_dict;

@property(readwrite,assign,atomic)  BOOL dirty;

- (void)startDirtyTimer;
- (void)stopDirtyTimer;

- (UMSS7ConfigStagingAreaStorage *)copyWithZone:(NSZone *)zone;
- (UMSS7ConfigStagingAreaStorage *)initWithPath:(NSString *)path;


@end


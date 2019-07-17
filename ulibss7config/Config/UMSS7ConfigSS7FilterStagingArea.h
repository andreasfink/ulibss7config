//
//  UMSS7ConfigStagingArea.h
//  ulibss7config
//
//  Created by Andreas Fink on 19.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import <ulib/ulib.h>
#import "UMSS7ConfigObject.h"

@class  UMSS7ConfigSS7FilterRuleSet;
@class  UMSS7ConfigSS7FilterRule;
@class  UMSS7ConfigFilterEngine;
@class  UMSS7ConfigFilterActionList;
@class  UMSS7ConfigFilterLog;
@class UMMutex;


@interface UMSS7ConfigSS7FilterStagingArea : UMSS7ConfigObject
{
    BOOL                    _isActive;
    NSString                 *_path;
    UMSynchronizedDictionary *_filter_rule_set_dict;
    UMSynchronizedDictionary *_filter_engines_dict;
    UMSynchronizedDictionary *_filter_action_list_dict;
    NSDate                   *_createdTimestamp;
    NSDate                   *_modifiedTimestamp;
    
    UMMutex *_lock;
}


@property(readwrite,assign,atomic)  BOOL                     isActive;
@property(readwrite,strong,atomic)  NSString                 *path;
@property(readwrite,strong,atomic)  NSDate                   *createdTimestamp;
@property(readwrite,strong,atomic)  NSDate                   *modifiedTimestamp;
@property(readwrite,strong,atomic)  UMSynchronizedDictionary *filter_rule_set_dict;
@property(readwrite,strong,atomic)  UMSynchronizedDictionary *filter_engines_dict;
@property(readwrite,strong,atomic)  UMSynchronizedDictionary *filter_action_list_dict;

- (UMSS7ConfigSS7FilterStagingArea *)copyWithZone:(NSZone *)zone;
- (UMSS7ConfigSS7FilterStagingArea *)initWithPath:(NSString *)path;

- (void)flushIfDirty;
- (void)writeConfig;
- (void)deleteConfig:(NSString *)filePath;
- (void)loadFromFile;

@end


//
//  UMSS7ConfigObject.h
//  estp
//
//  Created by Andreas Fink on 01.02.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import <ulib/ulib.h>

@interface UMSS7ConfigObject : UMObject
{
    BOOL            _dirty;
    NSString         *_name;
    NSString         *_oldName;
    NSNumber         *_enabled;
    NSNumber         *_logLevel;
    NSString         *_logFile;
    NSArray          *_comments;
    NSString         *_objectDescription;
    NSMutableArray<UMSS7ConfigObject *> *_subEntries;
    BOOL            _nameChanged;
    NSNumber        *_concurrentTasks;
}

@property(readwrite,strong,atomic)  NSString        *name;
@property(readwrite,strong,atomic)  NSNumber        *enabled;
@property(readwrite,strong,atomic)  NSNumber        *logLevel;
@property(readwrite,strong,atomic)  NSArray         *comments;
@property(readwrite,strong,atomic)  NSString        *objectDescription; /*we have to name this differently due to [NSObject description] */
@property(readwrite,strong,atomic)  NSMutableArray<UMSS7ConfigObject *> *subEntries;
@property(readwrite,assign,atomic)  BOOL            nameChanged;
@property(readwrite,strong,atomic)  NSNumber        *concurrentTasks;

- (BOOL) isDirty;
- (void) setDirty:(BOOL)d;

- (UMSS7ConfigObject *)initWithConfig:(NSDictionary *)dict;

- (NSString *)configString;
- (NSString *)type;

- (void)appendConfigToString:(NSMutableString *)s;
- (void)appendConfigToString:(NSMutableString *)s withoutName:(BOOL)withoutName;

- (UMSynchronizedSortedDictionary *)config;
- (UMSynchronizedSortedDictionary *)configWithoutName:(BOOL)withoutName;

- (void)setConfig:(NSDictionary *)config;
- (void)setSuperConfig:(NSDictionary *)config;

+ (NSString *)filterName:(NSString *)str;
- (UMSS7ConfigObject *)copyWithZone:(NSZone *)zone;
- (void)addSubEntry:(UMSS7ConfigObject *)obj;

- (NSArray<NSDictionary *> *)subConfigs;

@end

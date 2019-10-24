//
//  SS7CDRWriter.h
//  ulibss7config
//
//  Created by Andreas Fink on 24.10.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import <ulib/ulib.h>
#import <ulibdb/ulibdb.h>
#import <ulibss7config/ulibss7config.h>


@interface SS7CDRWriter : UMLayer
{
    NSString            *_name;
    UMDbPool            *_dbPool;
    UMDbTable           *_dbTable;
    NSDateFormatter     *_cdrDateFormatter;
    NSMutableArray      *_pendingRecords;
    UMAtomicDate        *_lastInsert;
    UMMutex             *_lock;
    UMTimer             *_timer;
    BOOL                _useBatchInsert;
    NSInteger           _activeMultiTasks;
    NSInteger           _activeSingleTasks;
    UMThroughputCounter *_speedometerTasks;
    UMThroughputCounter *_speedometerRecords;
    NSArray<NSString *> *_fieldNames;
    NSDictionary<NSString *,NSString *> *_nameMapping;
    NSString            *_writerFileNamePrefix;
    NSString            *_writerCurrentFileName;
    int                 _writerFile;
    NSTimeInterval      _reopenTime;
    NSDate              *_writerOpenTime;
    NSInteger           _writerQueueLimit;
    int                 _sliceSize;
}

@property(readonly,strong)          NSString *name;
@property(readonly,strong)          NSDateFormatter *writerDateFormatter;
@property(readwrite,atomic,assign)  NSInteger activeMultiTasks;
@property(readwrite,atomic,assign)  NSInteger activeSingleTasks;
@property(readwrite,atomic,assign)  int sliceSize;
@property(readwrite,atomic,strong)  NSArray<NSString *> *fieldNames;
@property(readwrite,atomic,strong)  NSDictionary<NSString *,NSString *> *nameMapping;


- (void)openNewWriterFile;

- (SS7CDRWriter *)initWithTaskQueueMulti:(UMTaskQueueMulti *)tq usingBatchInsert:(BOOL)bi;
- (void) setConfig:(NSDictionary *)cfg applicationContext:(SS7AppDelegate *)appContext;
- (void) writeRecord:(NSDictionary *)fields;
- (NSString *)webStats;
- (NSDictionary *)apiJsonStat;
- (NSUInteger)pendingRecordsCount;
- (void)writeMappedDictionary:(NSDictionary *)dict;

@end


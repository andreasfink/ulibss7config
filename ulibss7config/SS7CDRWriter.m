//
//  SS7CDRWriter.m
//  ulibss7config
//
//  Created by Andreas Fink on 24.10.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "SS7CDRWriter.h"
#import <ulibdb/ulibdb.h>
#import <ulibss7config/ulibss7config.h>
#import "SS7CDRWriterTask.h"
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

@implementation SS7CDRWriter


- (SS7CDRWriter *)initWithTaskQueueMulti:(UMTaskQueueMulti *)tq usingBatchInsert:(BOOL)bi
{
    self = [super initWithTaskQueueMulti:tq name:@"writer"];
    if (self)
    {
        _writerFile = -1;
        _reopenTime = 5 * 60; /* reopen every 5 minutes */
        _writerQueueLimit = 0;
        _writerOpenTime = [NSDate new];
        _sliceSize = 500;
        _fieldNames =  @[];
        _nameMapping = @{};
        _lastInsert = [[UMAtomicDate alloc]init];
        _lock = [[UMMutex alloc]initWithName:@"writer-lock"];
        _pendingRecords = [[NSMutableArray alloc]init];
        _useBatchInsert = bi;
        _speedometerTasks   = [[UMThroughputCounter alloc]initWithResolutionInSeconds:   1.0 maxDuration: 1260.0];
        _speedometerRecords = [[UMThroughputCounter alloc]initWithResolutionInSeconds: 1.0 maxDuration: 1260.0];
        if(_useBatchInsert)
        {
            _timer =   [[UMTimer alloc]initWithTarget:self
                                             selector:@selector(writeTimer)
                                               object:NULL
                                             seconds:1.0
                                                 name:@"writer"
                                              repeats:YES];
            [_timer start];
        }
    }
    return self;
}

- (void)openNewWriterFile
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [dateFormatter setDateFormat:@"yyyyMMdd_HHmmss"];

    if(_writerFile >=0)
    {
        close(_writerFile);
        _writerFile = -1;
    }
    _writerCurrentFileName = [NSString stringWithFormat:@"%@-%@", _writerFileNamePrefix, [dateFormatter stringFromDate:[NSDate date]]];
    mode_t mode = 0640;
    _writerFile = open(_writerCurrentFileName.UTF8String,O_CREAT | O_SYNC | O_WRONLY | O_APPEND,mode);
    if(_writerFile < 0)
    {
        fprintf(stderr,"Error %d: %s",errno,strerror(errno));
        fprintf(stderr,"Can not open/create file '%s'",_writerCurrentFileName.UTF8String);
        exit(-1);
    }
    _writerOpenTime = [NSDate new];
}

-(void) setConfig:(NSDictionary *)cfg withDbPools:(UMSynchronizedDictionary *)pools
{
    NSString *poolName = cfg[@"pool-name"];
    NSString *tableName = cfg[@"table-name"];
    _name = cfg[@"name"];

    NSDictionary *tableConfig = @{@"enable": @"YES",
                                  @"table-name" : tableName,
                                  @"auto-create" : @"NO",
                                  @"pool-name" : poolName
                                };

    if(cfg[@"reopen-time"])
    {
        _reopenTime = [cfg[@"reopen-time"] doubleValue];
    }
    _writerFileNamePrefix = cfg[@"cdr-file-prefix"];


    if(cfg[@"cdr-queue-limit"])
    {
        _writerQueueLimit = [cfg[@"cdr-queue-limit"] intValue];
    }
    if(_writerFileNamePrefix.length > 0)
    {
        NSUInteger n = _writerFileNamePrefix.length;
        NSInteger lastSlash = -1;
        for(NSUInteger i=0;i<n;i++)
        {
            if([_writerFileNamePrefix characterAtIndex:i]=='/')
            {
                lastSlash=i;
            }
        }
        if(lastSlash >=0)
        {
            NSString *path = [_writerFileNamePrefix substringToIndex:lastSlash+1];
            int r = mkdir(path.UTF8String,0755);
            if(r<0)
            {
                if (errno!=EEXIST)
                {
                    fprintf(stderr,"Error %d %s: Can not write to path %s",errno,strerror(errno),path.UTF8String);
                    exit(-1);
                }
            }
        }
        [self openNewWriterFile];
    }
    else
    {
        _dbPool = pools[poolName];
        _dbTable = [[UMDbTable alloc] initWithConfig:tableConfig andPools:pools];
    }
    NSString *timeZone = cfg[@"time-zone"];
    if(timeZone.length < 1)
    {
        timeZone = @"UTC";
    }

    NSString *dateFormat = cfg[@"date-format"];
    if(dateFormat.length <1)
    {
        dateFormat = @"yyyy-MM-dd HH:mm:ss.SSS";
    }

    NSString *locale = cfg[@"locale"];
    if(locale.length <1)
    {
        locale = @"en_US";
    }

    NSTimeZone *tz = [NSTimeZone timeZoneWithName:timeZone];
    NSLocale *theLocale = [[NSLocale alloc] initWithLocaleIdentifier:locale];
    _writerDateFormatter = [[NSDateFormatter alloc] init];
    [_writerDateFormatter setTimeZone:tz];
    [_writerDateFormatter setLocale:theLocale];
    [_writerDateFormatter setDateFormat:dateFormat];
}

-(void) setConfig:(NSDictionary *)cfg applicationContext:(SS7AppDelegate *)appContext
{
    NSString *poolName = cfg[@"pool-name"];
    NSString *tableName = cfg[@"table-name"];
    _name = cfg[@"name"];

    NSDictionary *tableConfig = @{@"enable": @"YES",
                                  @"table-name" : tableName,
                                  @"auto-create" : @"NO",
                                  @"pool-name" : poolName
                                };

    if(cfg[@"reopen-time"])
    {
        _reopenTime = [cfg[@"reopen-time"] doubleValue];
    }
    _writerFileNamePrefix = cfg[@"cdr-file-prefix"];


    if(cfg[@"cdr-queue-limit"])
    {
        _writerQueueLimit = [cfg[@"cdr-queue-limit"] intValue];
    }
    if(_writerFileNamePrefix.length > 0)
    {
        NSUInteger n = _writerFileNamePrefix.length;
        NSInteger lastSlash = -1;
        for(NSUInteger i=0;i<n;i++)
        {
            if([_writerFileNamePrefix characterAtIndex:i]=='/')
            {
                lastSlash=i;
            }
        }
        if(lastSlash >=0)
        {
            NSString *path = [_writerFileNamePrefix substringToIndex:lastSlash+1];
            int r = mkdir(path.UTF8String,0755);
            if(r<0)
            {
                if (errno!=EEXIST)
                {
                    fprintf(stderr,"Error %d %s: Can not write to path %s",errno,strerror(errno),path.UTF8String);
                    exit(-1);
                }
            }
        }
        [self openNewWriterFile];
    }
    else
    {
        _dbPool = [appContext getDbPool:poolName];
        _dbTable = [[UMDbTable alloc] initWithConfig:tableConfig andPools:appContext.dbPools];
    }
    NSString *timeZone = cfg[@"time-zone"];
    if(timeZone.length < 1)
    {
        timeZone = @"UTC";
    }

    NSString *dateFormat = cfg[@"date-format"];
    if(dateFormat.length <1)
    {
        dateFormat = @"yyyy-MM-dd HH:mm:ss.SSS";
    }

    NSString *locale = cfg[@"locale"];
    if(locale.length <1)
    {
        locale = @"en_US";
    }

    NSTimeZone *tz = [NSTimeZone timeZoneWithName:timeZone];
    NSLocale *theLocale = [[NSLocale alloc] initWithLocaleIdentifier:locale];
    _writerDateFormatter = [[NSDateFormatter alloc] init];
    [_writerDateFormatter setTimeZone:tz];
    [_writerDateFormatter setLocale:theLocale];
    [_writerDateFormatter setDateFormat:dateFormat];
}

- (NSUInteger)pendingRecordsCount
{
    NSUInteger cnt;
    [_lock lock];
    cnt = _pendingRecords.count;
    [_lock unlock];
    return cnt;
}


- (void) writeRecord:(NSDictionary *)fields
{
    if(fields==NULL)
    {
        return;
    }
    [_speedometerRecords increase];
    if(_useBatchInsert)
    {
        [_lock lock];
        if((_writerQueueLimit == 0) || (_pendingRecords.count < _writerQueueLimit))
        {
            [_pendingRecords addObject:fields];
        }
        [_lock unlock];
        [_timer startIfNotRunning];
    }
    else
    {
        [_speedometerTasks increase];
        SS7CDRWriterTask *task = [[SS7CDRWriterTask alloc]initWithRecord:fields table:_dbTable writer:self];
        [task main];
//        [self.taskQueue queueTask:task toQueueNumber:0];
    }
}

- (void) writeRecordsToFile:(NSArray *)records
{
    if(_writerFile>=0)
    {
        if([[NSDate date]timeIntervalSinceDate:_writerOpenTime] > _reopenTime)
        {
            [self openNewWriterFile];
        }
    }
    if(records.count >0)
    {
        [_speedometerTasks increase];
        for(NSDictionary *d in records)
        {
            NSString *jsonString = [d jsonCompactString];
            NSData *d = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
            ssize_t cnt = write(_writerFile,d.bytes,d.length);
            if(cnt != d.length)
            {
                fprintf(stderr,"Error %d: %s",errno,strerror(errno));
                fprintf(stderr,"Can not write file '%s'",_writerCurrentFileName.UTF8String);
                exit(-1);
            }
            write(_writerFile,"\n",1);
        }
    }
}

- (void) writeRecordsToDbTasks:(NSArray *)records
{
    if(records.count >0)
    {
        [_speedometerTasks increase];
        SS7CDRWriterTask *task = [[SS7CDRWriterTask alloc]initWithRecords:records
                                                                table:_dbTable
                                                               writer:self
                                                           fieldNames:_fieldNames];
        [self.taskQueue queueTask:task toQueueNumber:0];
    }
}


- (void)writeTimer
{
    [_lock lock];
    NSMutableArray *writeRecords = _pendingRecords;
    _pendingRecords = [[NSMutableArray alloc]init];
    [_lock unlock];

    if(_writerFile>=0)
    {
        /* if we are in File write mode, we write the whole blob */
        [self writeRecordsToFile:writeRecords];
    }
    else
    {
        /* if we are in DB mode, we split it into tasks of _sliceSize each */
        /* and we queue DB write Tasks for it */

        while(writeRecords.count > 0)
        {
            NSMutableArray *taskRecords;
            if(writeRecords.count <= _sliceSize)
            {
                taskRecords = writeRecords;
                writeRecords = [[NSMutableArray alloc]init];
            }
            else
            {
                NSRange range = NSMakeRange(0,_sliceSize);
                taskRecords = [[writeRecords subarrayWithRange:range] mutableCopy];
                [writeRecords removeObjectsInRange:range];
            }
            [self writeRecordsToDbTasks:taskRecords];
        }
    }
}

- (NSDictionary *)apiJsonStat
{
    NSMutableDictionary *d = [[NSMutableDictionary alloc]init];

    d[@"cdr-in-queue"] = @(_pendingRecords.count);
    d[@"records-per-second"] = [_speedometerRecords getSpeedTripleJson];
    d[@"inserts-per-second"] = [_speedometerTasks getSpeedTripleJson];
    if(_writerCurrentFileName)
    {
        d[@"writer-method"] = @"file";
    }
    else
    {
        d[@"writer-method"] = @"database";
    }
    d[@"writer-queue-limit"] = @(_writerQueueLimit);
    return d;
}

- (NSString *)webStats
{
    NSMutableString *s = [[NSMutableString alloc]init];

    [s appendString:@"<table class=\"object_table\">\n"];
    [s appendString:@"  <tr>\r\n"];

    [s appendString:@"      <td class=\"object_title\">Records in queue</td>\r\n"];
    [s appendFormat:@"      <td class=\"object_value\">%lu</td>\r\n",_pendingRecords.count];
    [s appendString:@"  </tr>\r\n"];
    [s appendString:@"  <tr>\r\n"];
    [s appendString:@"      <td class=\"object_title\">Records per second</td>\r\n"];
    [s appendFormat:@"      <td class=\"object_value\">%@</td>\r\n",[_speedometerRecords getSpeedStringTriple]];
    [s appendString:@"  </tr>\r\n"];
    [s appendString:@"  <tr>\r\n"];
    [s appendString:@"      <td class=\"object_title\">INSERTs per second</td>\r\n"];
    [s appendFormat:@"      <td class=\"object_value\">%@</td>\r\n",[_speedometerTasks getSpeedStringTriple]];
    [s appendString:@"  </tr>\r\n"];
    [s appendString:@"  <tr>\r\n"];
    [s appendString:@"      <td class=\"object_title\">CDR method</td>\r\n"];
    if(_writerCurrentFileName)
    {
        [s appendString:@"      <td class=\"object_value\">file</td>\r\n"];
    }
    else
    {
        [s appendString:@"      <td class=\"object_value\">database</td>\r\n"];
    }
    [s appendString:@"  </tr>\r\n"];
    [s appendString:@"  <tr>\r\n"];
    [s appendString:@"      <td class=\"object_title\">Writer queue limit</td>\r\n"];
    [s appendFormat:@"      <td class=\"object_value\">%lu</td>\r\n",_writerQueueLimit];
    [s appendString:@"  </tr>\r\n"];
    [s appendString:@"</table>\r\n"];
    return s;
}


- (void)writeMappedDictionary:(UMSynchronizedSortedDictionary *)dict
{
    /* standardize array */

    NSDictionary *outputDict = [dict dictionaryCopy];

    /*[[NSMutableDictionary alloc]init];

    NSArray *allKeys = [dict allKeys];
    for(NSString *key in allKeys)
    {
        NSString *keyName = _nameMapping[key];
        if(keyName==NULL)
        {
            keyName = key;
        }
        if(NSNotFound == [_fieldNames indexOfObjectIdenticalTo:keyName])
        {
            continue;
        }
        outputDict[keyName] = dict[key];
    }*/

    [self writeRecord:outputDict];
}


@end

//
//  SS7CDRWriterTask.m
//  ulibss7config
//
//  Created by Andreas Fink on 24.10.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import <ulibdb/ulibdb.h>
#import "SS7CDRWriterTask.h"
#import "SS7CDRWriter.h"

@implementation SS7CDRWriterTask

- (SS7CDRWriterTask *)initWithRecord:(NSDictionary *)fields
                               table:(UMDbTable *)dbTable
                              writer:(SS7CDRWriter *)writer
{
    self = [super init];
    if(self)
    {
        _dbTable = dbTable;
        _fields = fields;
        _records = NULL;
        _writer = writer;
        _fieldNames = writer.fieldNames;
    }
    return self;
}

- (SS7CDRWriterTask *)initWithRecords:(NSArray *)records
                                table:(UMDbTable *)dbTable
                               writer:(SS7CDRWriter *)writer
                           fieldNames:(NSArray *)fieldNames
{
    self = [super init];
    if(self)
    {
        _dbTable = dbTable;
        _fields = NULL;
        _records = records;
        _writer = writer;
        if(fieldNames==NULL)
        {
            _fieldNames = writer.fieldNames;
        }
        else
        {
            _fieldNames = fieldNames;
        }
    }
    return self;
}


- (void)main
{
    @autoreleasepool
    {
        @try
        {
            if(_fields)
            {
                _writer.activeSingleTasks++;
                UMDbQuery *query = [UMDbQuery queryForFile:__FILE__ line: __LINE__];
                NSArray *fieldNames;
                if(_fieldNames)
                {
                    fieldNames = _fieldNames;
                }
                else
                {
                    fieldNames = [_fields allKeys];
                }
                [query setType:UMDBQUERYTYPE_INSERT];
                [query setTable:_dbTable];
                NSMutableArray *fieldNames2 = [[NSMutableArray alloc]init];
                NSMutableArray *values = [[NSMutableArray alloc]init];
                for(NSString *fieldName in fieldNames)
                {
                    if(_fields[fieldName])
                    {
                        [fieldNames2 addObject:fieldName];
                        [values addObject:_fields[fieldName]];
                    }
                }
                [query setFields:fieldNames2];

                UMDbSession *session = [_dbTable.pool grabSession:__FILE__ line:__LINE__ func:__func__];
                [session cachedQueryWithNoResult:query parameters:values allowFail:NO];
                [_dbTable.pool returnSession:session file:__FILE__ line:__LINE__ func:__func__];
                _writer.activeSingleTasks--;
            }
            else if(_records.count > 0)
            {
                _writer.activeMultiTasks++;
                UMDbQuery *query = [UMDbQuery queryForFile:__FILE__ line: __LINE__];
                [query setType:UMDBQUERYTYPE_INSERT];
                [query setTable:_dbTable];
                [query setFields:_fieldNames];
                NSMutableArray *values = [[NSMutableArray alloc]init];
                for (NSDictionary *record_fields in _records)
                {
                    for(NSString *record_fieldName in _fieldNames)
                    {
                        id value = record_fields[record_fieldName];
                        if(value == NULL)
                        {
                            [values addObject:[NSNull null]];
                        }
                        else
                        {
                            [values addObject:value];
                        }
                    }
                }
                UMDbSession *session = [_dbTable.pool grabSession:__FILE__ line:__LINE__ func:__func__];
                [session cachedQueryWithNoResult:query parameters:values allowFail:NO];
                [_dbTable.pool returnSession:session file:__FILE__ line:__LINE__ func:__func__];
                _writer.activeMultiTasks--;
            }
        }
        @catch(NSException *ex)
        {
            NSLog(@"%@",ex);
        }
    }
}
@end

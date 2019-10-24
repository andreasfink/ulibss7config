//
//  SS7CDRWriterTask.h
//  ulibss7config
//
//  Created by Andreas Fink on 24.10.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//


#import <ulib/ulib.h>
#import <ulibdb/ulibdb.h>
@class SS7CDRWriter;

@interface SS7CDRWriterTask : UMLayerTask
{
    NSArray         *_fieldNames;
    NSDictionary    *_fields;
    NSArray         *_records;
    UMDbTable       *_dbTable;
    SS7CDRWriter    *_writer;
}

@property(readwrite,strong)    SS7CDRWriter *writer;

- (SS7CDRWriterTask *)initWithRecord:(NSDictionary *)fields
                               table:(UMDbTable *)dbTable
                              writer:(SS7CDRWriter *)writer;

- (SS7CDRWriterTask *)initWithRecords:(NSArray *)records
                                table:(UMDbTable *)dbTable
                               writer:(SS7CDRWriter *)writer
                           fieldNames:(NSArray *)fieldNames;
@end

//
//  UMSS7Config_macroAppendDict.m
//  ulibss7config
//
//  Created by Andreas Fink on 13.01.2025.
//  Copyright © 2025 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

void appendDict_BOOLEAN(UMSynchronizedSortedDictionary *dict,char *name,NSNumber *value,const char *dbname,int tag,const char *options)
{
    if(value!=NULL)
    {
        dict[@(name)] = @(value.boolValue);
    }
}

void appendDict_DOUBLE(UMSynchronizedSortedDictionary *dict,char *name,NSNumber *value,const char *dbname,int tag,const char *options)
{
    if(value!=NULL)
    {
        dict[@(name)] = @(value.doubleValue);
    }
}

void appendDict_INTEGER(UMSynchronizedSortedDictionary *dict,char *name,NSNumber *value,const char *dbname,int tag,const char *options)

{
    if(value!=NULL)
    {
        dict[@(name)] = @(value.intValue);
    }
}

void appendDict_STRING(UMSynchronizedSortedDictionary *dict,const char *name,NSString *value,const char *dbname,int tag,const char *options)
{
    if(value!=NULL)
    {
        dict[@(name)] = value.stringValue;
    }
}

void appendDict_HEXDATA(UMSynchronizedSortedDictionary *dict,const char *name,NSData *value,const char *dbname,int tag,const char *options)
{
    if(value!=NULL)
    {
        dict[@(name)] = value.stringValue.hexString;
    }
}

void appendDict_FILTERED_STRING(UMSynchronizedSortedDictionary *dict,const char *name,NSString *value,const char *dbname,int tag,const char *options)
{
    if(value!=NULL)
    {
        dict[@(name)] = [UMSS7ConfigObject filterName:value];
    }
}

void appendDict_DATE(UMSynchronizedSortedDictionary *dict,const char *name,NSDate *value,const char *dbname,int tag,const char *options)
{
    if(value!=NULL)
    {
        dict[@(name)] = value.stringValue;
    }
}


void appendDict_ARRAY_COMPACT(UMSynchronizedSortedDictionary *dict,const char *name,NSArray *array,const char *dbname,int tag,const char *options)
{
    if(array!=NULL)
    {
        dict[@(name)] = array;
    }
}


void appendDict_ARRAY_VERBOSE(UMSynchronizedSortedDictionary *dict,const char *name,NSArray *array,const char *dbname,int tag,const char *options)
{
    if(array!=NULL)
    {
        dict[@(name)] = array;
    }
}

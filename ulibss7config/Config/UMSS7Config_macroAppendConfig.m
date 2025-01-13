//
//  UMSS7Config_macroAppendConfig.m
//  ulibss7config
//
//  Created by Andreas Fink on 13.01.2025.
//  Copyright © 2025 Andreas Fink. All rights reserved.
//
#import "UMSS7ConfigObject.h"

void appendConfig_BOOLEAN(NSMutableString *str,char *name,NSNumber *value,const char *dbname,int tag,const char *options)
{
    if(value!=NULL)
    {
        [str appendFormat:@"%s=%@\n",name,value.boolValue ? @"YES": @"NO"];
    }
}

void appendConfig_DOUBLE(NSMutableString *str,const char *name,NSNumber *value,const char *dbname,int tag,const char *options)
{
    if(value!=NULL)
    {
        [str appendFormat:@"%s=%lf\n",name,value.doubleValue];
    }
}

void appendConfig_INTEGER(NSMutableString *str,const char *name,NSNumber *value,const char *dbname,int tag,const char *options)
{
    if(value!=NULL)
    {
        [str appendFormat:@"%s=%d\n",name,value.intValue];
    }
}

void appendConfig_STRING(NSMutableString *str,const char *name,NSString *value,const char *dbname,int tag,const char *options)
{
    if(value!=NULL)
    {
        [str appendFormat:@"%s=%@\n",name,value.stringValue];
    }
}

void appendConfig_HEXDATA(NSMutableString *str,const char *name,NSData *value,const char *dbname,int tag,const char *options)
{
    if(value!=NULL)
    {
        [str appendFormat:@"%s=%@\n",name,value.hexString];
    }
}

void appendConfig_FILTERED_STRING(NSMutableString *str,const char *name,NSString *value,const char *dbname,int tag,const char *options)
{
    if(value!=NULL)
    {
        [str appendFormat:@"%s=%@\n",name,[UMSS7ConfigObject filterName:value.stringValue]];
    }
}

void appendConfig_DATE(NSMutableString *str,const char *name,NSDate *value,const char *dbname,int tag,const char *options)
{
    if(value!=NULL)
    {
        [str appendFormat:@"%s=%@\n",name,value.stringValue];
    }
}

void appendConfig_ARRAY_VERBOSE(NSMutableString *str,const char *name,NSArray *array,const char *dbname,int tag,const char *options)
{
    if(array!=NULL)
    {
        NSUInteger n= [array count];
        for(NSUInteger i=0;i<n;i++)
        {
            [str appendFormat:@"%s=%@\n",name,array[i]];
        }
    }
}

void appendConfig_ARRAY_COMPACT(NSMutableString *str,const char *name,NSArray *array,const char *dbname,int tag,const char *options)
{
    if(array!=NULL)
    {
        NSUInteger n = [array count];
        for(NSUInteger i=0;i<n;i++)
        {
            if(i==0)
            {
                [str appendFormat:@"%s=%@",name,array[i]];
            }
            else
            {
                [str appendFormat:@";%@",array[i]];
            }
        }
        [str appendString:@"\n"];
    }
}


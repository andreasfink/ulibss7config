//
//  UMSS7ConfigMacros.m
//  ulibss7config
//
//  Created by Andreas Fink on 14.01.2025.
//  Copyright © 2025 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigMacroHelper.h"

/* -------------------------------------------------------------------------------------------------------------------------------- */
/*  appendConfig functions  */
/* -------------------------------------------------------------------------------------------------------------------------------- */

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
        [str appendFormat:@"%s=%@\n",name,value];
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

/* -------------------------------------------------------------------------------------------------------------------------------- */
/*  appendDict functions  */
/* -------------------------------------------------------------------------------------------------------------------------------- */

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


/* -------------------------------------------------------------------------------------------------------------------------------- */
/*  setDict functions  */
/* -------------------------------------------------------------------------------------------------------------------------------- */


void setConfig_BOOLEAN(NSDictionary *o,char *name,NSNumber **value,const char *dbname,int tag,const char *options)
{
    if(o[@(name)]!=NULL)
    {
        id obj = o[@(name)];
        if([obj isKindOfClass:[NSString class]])
        {
            *value = [NSNumber numberWithBool:[obj boolValue]];
        }
        else if([obj isKindOfClass:[NSArray class]])
        {
            *value = [NSNumber numberWithBool:[obj[0] boolValue]];
        }
        else if([obj isKindOfClass:[NSNumber class]])
        {
            *value = [NSNumber numberWithBool:[obj boolValue]];
        }
    }
}

void setConfig_DOUBLE(NSDictionary *o,char *name,NSNumber **value,const char *dbname,int tag,const char *options)
{
    if(o[@(name)]!=NULL)
    {
        id obj = o[@(name)];
        if([obj isKindOfClass:[NSString class]])
        {
            *value = [NSNumber numberWithDouble:[obj doubleValue]];
        }
        else if([obj isKindOfClass:[NSArray class]])
        {
            *value = [NSNumber numberWithDouble:[obj[0] doubleValue]];
        }
        else if([obj isKindOfClass:[NSNumber class]])
        {
            *value = [NSNumber numberWithDouble:[obj doubleValue]];
        }
    }
}


void setConfig_INTEGER(NSDictionary *o,char *name,NSNumber **value,const char *dbname,int tag,const char *options)
{
    if(o[@(name)]!=NULL)
    {
        id obj = o[@(name)];
        if([obj isKindOfClass:[NSString class]])
        {
            NSString *str = (NSString *)obj;
            *value = @([str intergerValueSupportingHex]);
        }
        else if([obj isKindOfClass:[NSArray class]])
        {
            *value = [NSNumber numberWithInt:[obj[0] intValue]];
        }
        else if([obj isKindOfClass:[NSNumber class]])
        {
            *value = [NSNumber numberWithInt:[obj intValue]];
        }
    }
}

void setConfig_STRING(NSDictionary *o,char *name,NSString **value,const char *dbname,int tag,const char *options)
{
    if(o[@(name)]!=NULL)
    {
        id obj = o[@(name)];
        if([obj isKindOfClass:[NSString class]])
        {
            *value = obj;
        }
        else if([obj isKindOfClass:[NSArray class]])
        {
            *value = [((NSArray *)obj) componentsJoinedByString:@";"];
        }
    }
}

void setConfig_FILTERED_STRING(NSDictionary *o,char *name,NSString **value,const char *dbname,int tag,const char *options)
{

    if(o[@(name)]!=NULL)
    {
        id o0 = o[@(name)];
        if([o0 isKindOfClass:[NSString class]])
        {
            *value = [UMSS7ConfigObject filterName:o0];
        }
        else if([o0 isKindOfClass:[NSArray class]])
        {
            NSMutableArray *a2 = [[NSMutableArray alloc]init];
            id o1;
            NSArray *arr = (NSArray *)o0;
            for(o1 in o0)
            {
                if([o1 isKindOfClass:[NSString class]])
                {
                    NSString *s = (NSString *)o1;
                    [a2 addObject: [UMSS7ConfigObject filterName:s]];
                }
                else if([o1 isKindOfClass:[NSNumber class]])
                {
                    NSNumber *n = (NSNumber *)o1;
                    [a2 addObject: n.stringValue];
                }
            }
            *value = [((NSArray *)a2) componentsJoinedByString:@";"];
        }
    }
}

void setConfig_DATE(NSDictionary *o,char *name,NSDate **value,const char *dbname,int tag,const char *options)
{
    if(o[@(name)]!=NULL)
    {
        id obj = o[@(name)];
        if([obj isKindOfClass:[NSString class]])
        {
            *value = [obj dateValue];
        }
        else if([obj isKindOfClass:[NSDate class]])
        {
            *value = obj;
        }
        else if([obj isKindOfClass:[NSNumber class]])
        {
            *value = [[NSDate alloc]initWithTimeIntervalSinceReferenceDate:[obj doubleValue]]; \
        }
    }
}


void setConfig_ARRAY_COMPACT(NSDictionary *o,char *name,NSArray **value,const char *dbname,int tag,const char *options)
{
    if(o[@(name)]!=NULL)
    {
        id obj = o[@(name)];
        if([obj isKindOfClass:[NSString class]])
        {
            *value = [((NSString *)obj) componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" \r\n\t;"]];
        }
        else if([obj isKindOfClass:[NSArray class]])
        {
            *value = obj;
        }
    }
}
void setConfig_ARRAY_VERBOSE(NSDictionary *o,char *name,NSArray **value,const char *dbname,int tag,const char *options)

{
    if(o[@(name)]!=NULL)
    {
        id obj = o[@(name)];
        if([obj isKindOfClass:[NSString class]])
        {
            *value = [((NSString *)obj) componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" \r\n\t;"]];
        }
        else if([obj isKindOfClass:[NSArray class]])
        {
            *value = obj;
        }
    }
}

void setConfig_HEXDATA(NSDictionary *o,char *name,NSData **value,const char *dbname,int tag,const char *options)
{
    if(o[@(name)]!=NULL)
    {
        id obj = o[@(name)];
        if([obj isKindOfClass:[NSString class]])
        {
            NSString *s = (NSString *)obj;
            *value = [s unhexedData];
        }
    }
}



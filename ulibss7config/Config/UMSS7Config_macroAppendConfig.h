//
//  UMSS7Config_appendConfigMacro.h
//  ulibss7config
//
//  Created by Andreas Fink on 12.01.2025.
//  Copyright © 2025 Andreas Fink. All rights reserved.
//

#define BOOLEAN(str,name,value,dbname,tag,options) \
if(value!=NULL) \
{ \
    [str appendFormat:@"%s=%@\n",name,value.boolValue ? @"YES": @"NO"]; \
}

#define DOUBLE(str,name,value,dbname,tag,options) \
if(value!=NULL) \
{ \
    [str appendFormat:@"%s=%lf\n",name,value.doubleValue]; \
}

#define INTEGER(str,name,value,dbname,tag,options) \
if(value!=NULL) \
{ \
    [str appendFormat:@"%s=%d\n",name,value.intValue]; \
}

#define STRING(str,name,value,dbname,tag,options) \
if(value!=NULL) \
{ \
    [str appendFormat:@"%s=%@\n",name,value.stringValue]; \
}

#define FILTERED_STRING(str,name,value,dbname,tag,options) \
if(value!=NULL) \
{ \
    [str appendFormat:@"%s=%@\n",name,[UMSS7ConfigObject filterName:value.stringValue]]; \
}

#define DATE(str,name,value,dbname,tag,options) \
if(value!=NULL) \
{ \
    [str appendFormat:@"%s=%@\n",name,value.stringValue]; \
}

#define ARRAY(str,name,array,dbname,tag,options) \
if(array!=NULL) \
{ \
    NSUInteger n= [array count]; \
    for(NSUInteger i=0;i<n;i++) \
    { \
        [str appendFormat:@"%s=%@\n",name,array[i]]; \
    } \
}

#define ARRAY_VERBOSE(str,name,array,dbname,tag,options) \
if(array!=NULL) \
{ \
    NSUInteger n= [array count]; \
    for(NSUInteger i=0;i<n;i++) \
    { \
        [str appendFormat:@"%s=%@\n",name,array[i]]; \
    } \
}

#define ARRAY_COMPACT(o,name,array,dbname,tag,options) \
if(array!=NULL) \
{ \
    NSUInteger n= [array count]; \
    for(NSUInteger i=0;i<n;i++) \
    { \
        if(i==0) \
        { \
            [o appendFormat:@"%@=%@",name,array[i]]; \
        } \
        else \
        { \
            [o appendFormat:@";%@",array[i]]; \
        } \
    } \
    [o appendString:@"\n"]; \
}


//
//  UMSS7ConfigMacros.h
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//


#define APPEND_CONFIG_BOOLEAN(str,name,value) \
if(value!=NULL) \
{ \
    [str appendFormat:@"%@=%@\n",name,value.boolValue ? @"YES": @"NO"]; \
}

#define APPEND_CONFIG_DOUBLE(str,name,value) \
if(value!=NULL) \
{ \
    [str appendFormat:@"%@=%lf\n",name,value.doubleValue]; \
}

#define APPEND_CONFIG_INTEGER(str,name,value) \
if(value!=NULL) \
{ \
    [str appendFormat:@"%@=%d\n",name,value.intValue]; \
}

#define APPEND_CONFIG_STRING(str,name,value) \
if(value!=NULL) \
{ \
    [str appendFormat:@"%@=%@\n",name,value.stringValue]; \
}

#define APPEND_CONFIG_DATE(str,name,value) \
if(value!=NULL) \
{ \
    [str appendFormat:@"%@=%@\n",name,value.stringValue]; \
}

#define APPEND_CONFIG_ARRAY_COMPACT(str,name,array) \
if(array!=NULL) \
{ \
    NSUInteger n= [array count]; \
    for(NSUInteger i=0;i<n;i++) \
    { \
        if(i==0) \
        { \
            [str appendFormat:@"%@=%@",name,array[i]]; \
        } \
        else \
        { \
            [str appendFormat:@";%@",array[i]]; \
        } \
    } \
    [str appendString:@"\n"]; \
}

#define APPEND_CONFIG_ARRAY_VERBOSE(str,name,array) \
if(array!=NULL) \
{ \
    NSUInteger n= [array count]; \
    for(NSUInteger i=0;i<n;i++) \
    { \
        [str appendFormat:@"%@=%@\n",name,array[i]]; \
    } \
}

#define APPEND_CONFIG_ARRAY_OF_CONFIG_OBJECTS(str,name,array) \
if(array!=NULL) \
{ \
    NSUInteger n= [array count]; \
    for(NSUInteger i=0;i<n;i++) \
    { \
        UMSS7ConfigObject *o = array[i]; \
        if(i==0) \
        { \
            [str appendFormat:@"%@=%@",name,o.name]; \
        } \
        else \
        { \
            [str appendFormat:@" %@",o.name]; \
        } \
    } \
    [str appendString:@"\n"]; \
}
/**************************************/
#define APPEND_DICT_BOOLEAN(dict,name,value) \
if(value!=NULL) \
{ \
    dict[name] = @(value.boolValue); \
}

#define APPEND_DICT_DOUBLE(dict,name,value) \
if(value!=NULL) \
{ \
    dict[name] = @(value.doubleValue); \
}

#define APPEND_DICT_INTEGER(dict,name,value) \
if(value!=NULL) \
{ \
    dict[name] = @(value.intValue); \
}

#define APPEND_DICT_STRING(dict,name,value) \
if(value!=NULL) \
{ \
    dict[name] = value.stringValue; \
}

#define APPEND_DICT_DATE(dict,name,value) \
if(value!=NULL) \
{ \
    dict[name] = value.stringValue; \
}

#define APPEND_DICT_ARRAY(dict,name,array) \
if(array!=NULL) \
{ \
    dict[name] = array; \
}

#define SET_DICT_BOOLEAN(dict,name,value) \
if(dict[name]!=NULL) \
{ \
    id o = dict[name]; \
    if([o isKindOfClass:[NSString class]]) \
    { \
        value = [NSNumber numberWithBool:[o boolValue]]; \
    } \
    else if([o isKindOfClass:[NSArray class]]) \
    { \
        value = [NSNumber numberWithBool:[o[0] boolValue]]; \
    } \
    else if([o isKindOfClass:[NSNumber class]]) \
    { \
        value = [NSNumber numberWithBool:[o boolValue]]; \
    } \
}

#define SET_DICT_DOUBLE(dict,name,value) \
if(dict[name]!=NULL) \
{ \
    id o = dict[name]; \
    if([o isKindOfClass:[NSString class]]) \
    { \
        value = [NSNumber numberWithDouble:[o doubleValue]]; \
    } \
    else if([o isKindOfClass:[NSArray class]]) \
    { \
        value = [NSNumber numberWithDouble:[o[0] doubleValue]]; \
    } \
    else if([o isKindOfClass:[NSNumber class]]) \
    { \
        value = [NSNumber numberWithDouble:[o doubleValue]]; \
    } \
}


#define SET_DICT_INTEGER(dict,name,value) \
if(dict[name]!=NULL) \
{ \
    id o = dict[name]; \
    if([o isKindOfClass:[NSString class]]) \
    { \
        value = [NSNumber numberWithInt:[o intValue]]; \
    } \
    else if([o isKindOfClass:[NSArray class]]) \
    { \
        value = [NSNumber numberWithInt:[o[0] intValue]]; \
    } \
    else if([o isKindOfClass:[NSNumber class]]) \
    { \
        value = [NSNumber numberWithInt:[o intValue]]; \
    } \
}

#define SET_DICT_STRING(dict,name,value) \
if(dict[name]!=NULL) \
{ \
    id o = dict[name]; \
    if([o isKindOfClass:[NSString class]]) \
    { \
        value = o; \
    } \
    else if([o isKindOfClass:[NSArray class]]) \
    { \
         value = [((NSArray *)o) componentsJoinedByString:@";"]; \
    } \
}

#define SET_DICT_DATE(dict,name,value) \
if(dict[name]!=NULL) \
{ \
    id o = dict[name]; \
    if([o isKindOfClass:[NSString class]]) \
    { \
        value = [o dateValue]; \
    } \
    else if([o isKindOfClass:[NSDate class]]) \
    { \
        value = o; \
    } \
    else if([o isKindOfClass:[NSNumber class]]) \
    { \
        value = [[NSDate alloc]initWithTimeIntervalSinceReferenceDate:[o doubleValue]]; \
    } \
}

/* same as SET_DICT_STRING but passes string objects through filterName: */
/* use this if the passed string is a name of another object so its also filtered the same way */

#define SET_DICT_FILTERED_STRING(dict,name,value) \
if(dict[name]!=NULL) \
{ \
    id o = dict[name]; \
    if([o isKindOfClass:[NSString class]]) \
    { \
        value = [UMSS7ConfigObject filterName:o]; \
    } \
    else if([o isKindOfClass:[NSArray class]]) \
    { \
        NSMutableArray *o2 = [(NSArray *)o mutableCopy]; \
        NSUInteger n = o2.count; \
        for(NSUInteger i=0;i<n;i++) \
        { \
            o2[i] = [UMSS7ConfigObject filterName:o2[i] ];\
        } \
        value = [o2 componentsJoinedByString:@";"]; \
    } \
}


#define SET_DICT_ARRAY(dict,name,value) \
if(dict[name]!=NULL) \
{ \
    id o = dict[name]; \
    if([o isKindOfClass:[NSString class]]) \
    { \
        value = [((NSString *)o) componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" \t;"]]; \
    } \
    else if([o isKindOfClass:[NSArray class]]) \
    { \
        value = o; \
    } \
}





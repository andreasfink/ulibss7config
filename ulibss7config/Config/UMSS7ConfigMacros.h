//
//  UMSS7ConfigMacros.h
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//


#define APPEND_CONFIG_BOOLEAN(o,name,value) \
if(value!=NULL) \
{ \
    [o appendFormat:@"%@=%@\n",name,value.boolValue ? @"YES": @"NO"]; \
}

#define APPEND_CONFIG_DOUBLE(o,name,value) \
if(value!=NULL) \
{ \
    [o appendFormat:@"%@=%lf\n",name,value.doubleValue]; \
}

#define APPEND_CONFIG_INTEGER(o,name,value) \
if(value!=NULL) \
{ \
    [o appendFormat:@"%@=%d\n",name,value.intValue]; \
}

#define APPEND_CONFIG_STRING(o,name,value) \
if(value!=NULL) \
{ \
    [o appendFormat:@"%@=%@\n",name,value.stringValue]; \
}

#define APPEND_CONFIG_DATE(o,name,value) \
if(value!=NULL) \
{ \
    [o appendFormat:@"%@=%@\n",name,value.stringValue]; \
}

#define APPEND_CONFIG_ARRAY_COMPACT(o,name,array) \
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

#define APPEND_CONFIG_ARRAY_VERBOSE(o,name,array) \
if(array!=NULL) \
{ \
    NSUInteger n= [array count]; \
    for(NSUInteger i=0;i<n;i++) \
    { \
        [o appendFormat:@"%@=%@\n",name,array[i]]; \
    } \
}

#define APPEND_CONFIG_ARRAY_OF_CONFIG_OBJECTS(o,name,array) \
if(array!=NULL) \
{ \
    NSUInteger n = [array count]; \
    for(NSUInteger i=0;i<n;i++) \
    { \
        UMSS7ConfigObject *obj = array[i]; \
        if(i==0) \
        { \
            [o appendFormat:@"%@=%@",name,obj.name]; \
        } \
        else \
        { \
            [o appendFormat:@" %@",obj.name]; \
        } \
    } \
    [o appendString:@"\n"]; \
}
/**************************************/
#define APPEND_DICT_BOOLEAN(o,name,value) \
if(value!=NULL) \
{ \
    o[name] = @(value.boolValue); \
}

#define APPEND_DICT_DOUBLE(o,name,value) \
if(value!=NULL) \
{ \
    o[name] = @(value.doubleValue); \
}

#define APPEND_DICT_INTEGER(o,name,value) \
if(value!=NULL) \
{ \
    o[name] = @(value.intValue); \
}

#define APPEND_DICT_STRING(o,name,value) \
if(value!=NULL) \
{ \
    o[name] = value.stringValue; \
}

#define APPEND_DICT_DATE(o,name,value) \
if(value!=NULL) \
{ \
    o[name] = value.stringValue; \
}

#define APPEND_DICT_ARRAY(o,name,array) \
if(array!=NULL) \
{ \
    o[name] = array; \
}

#define SET_DICT_BOOLEAN(o,name,value) \
if(o[name]!=NULL) \
{ \
    id obj = o[name]; \
    if([obj isKindOfClass:[NSString class]]) \
    { \
        value = [NSNumber numberWithBool:[obj boolValue]]; \
    } \
    else if([obj isKindOfClass:[NSArray class]]) \
    { \
        value = [NSNumber numberWithBool:[obj[0] boolValue]]; \
    } \
    else if([obj isKindOfClass:[NSNumber class]]) \
    { \
        value = [NSNumber numberWithBool:[obj boolValue]]; \
    } \
}

#define SET_DICT_DOUBLE(o,name,value) \
if(o[name]!=NULL) \
{ \
    id obj = o[name]; \
    if([obj isKindOfClass:[NSString class]]) \
    { \
        value = [NSNumber numberWithDouble:[obj doubleValue]]; \
    } \
    else if([obj isKindOfClass:[NSArray class]]) \
    { \
        value = [NSNumber numberWithDouble:[obj[0] doubleValue]]; \
    } \
    else if([obj isKindOfClass:[NSNumber class]]) \
    { \
        value = [NSNumber numberWithDouble:[obj doubleValue]]; \
    } \
}


#define SET_DICT_INTEGER(o,name,value) \
if(o[name]!=NULL) \
{ \
    id obj = o[name]; \
    if([obj isKindOfClass:[NSString class]]) \
    { \
        NSString *s = (NSString *)obj; \
        value = @([s intergerValueSupportingHex]); \
    } \
    else if([obj isKindOfClass:[NSArray class]]) \
    { \
        value = [NSNumber numberWithInt:[obj[0] intValue]]; \
    } \
    else if([obj isKindOfClass:[NSNumber class]]) \
    { \
        value = [NSNumber numberWithInt:[obj intValue]]; \
    } \
}

#define SET_DICT_STRING(o,name,value) \
if(o[name]!=NULL) \
{ \
    id obj = o[name]; \
    if([obj isKindOfClass:[NSString class]]) \
    { \
        value = obj; \
    } \
    else if([obj isKindOfClass:[NSArray class]]) \
    { \
         value = [((NSArray *)obj) componentsJoinedByString:@";"]; \
    } \
}

#define SET_DICT_DATE(o,name,value) \
if(o[name]!=NULL) \
{ \
    id obj = o[name]; \
    if([obj isKindOfClass:[NSString class]]) \
    { \
        value = [obj dateValue]; \
    } \
    else if([obj isKindOfClass:[NSDate class]]) \
    { \
        value = obj; \
    } \
    else if([obj isKindOfClass:[NSNumber class]]) \
    { \
        value = [[NSDate alloc]initWithTimeIntervalSinceReferenceDate:[obj doubleValue]]; \
    } \
}

/* same as SET_DICT_STRING but passes string objects through filterName: */
/* use this if the passed string is a name of another object so its also filtered the same way */

#define SET_DICT_FILTERED_STRING(o,name,value) \
if(o[name]!=NULL) \
{ \
    id obj = o[name]; \
    if([obj isKindOfClass:[NSString class]]) \
    { \
        value = [UMSS7ConfigObject filterName:obj]; \
    } \
    else if([obj isKindOfClass:[NSArray class]]) \
    { \
        NSMutableArray *o2 = [(NSArray *)obj mutableCopy]; \
        NSUInteger n = o2.count; \
        for(NSUInteger i=0;i<n;i++) \
        { \
            o2[i] = [UMSS7ConfigObject filterName:o2[i]];\
        } \
        value = [o2 componentsJoinedByString:@";"]; \
    } \
}


#define SET_DICT_ARRAY(o,name,value) \
if(o[name]!=NULL) \
{ \
    id obj = o[name]; \
    if([obj isKindOfClass:[NSString class]]) \
    { \
        value = [((NSString *)obj) componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" \t;"]]; \
    } \
    else if([obj isKindOfClass:[NSArray class]]) \
    { \
        value = obj; \
    } \
}





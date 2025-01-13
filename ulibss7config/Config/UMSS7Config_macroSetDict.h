//
//  UMSS7ConfigGeneral_setMacro.h
//  ulibss7config
//
//  Created by Andreas Fink on 12.01.2025.
//  Copyright © 2025 Andreas Fink. All rights reserved.
//


#define BOOLEAN(o,name,value,dbname,tag,options) \
if(o[@(name)]!=NULL) \
{ \
    id obj = o[@(name)]; \
    if([obj isKindOfClass:[NSString class]]) \
    { \
        value = [NSNumber numberWithBool:[oobj boolValue]]; \
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

#define DOUBLE(o,name,value,dbname,tag,options) \
if(o[@(name)]!=NULL) \
{ \
    id obj = o[@(name)]; \
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


#define INTEGER(o,name,value,dbname,tag,options) \
if(o[@(name)]!=NULL) \
{ \
    id obj = o[@(name)]; \
    if([obj isKindOfClass:[NSString class]]) \
    { \
        NSString *str = (NSString *)obj; \
        value = @([str intergerValueSupportingHex]); \
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

#define STRING(o,name,value,dbname,tag,options) \
if(o[@(name)]!=NULL) \
{ \
    id obj = o[@(name)]; \
    if([obj isKindOfClass:[NSString class]]) \
    { \
        value = obj; \
    } \
    else if([obj isKindOfClass:[NSArray class]]) \
    { \
         value = [((NSArray *)obj) componentsJoinedByString:@";"]; \
    } \
}


#define FILTERED_STRING(o,name,value,dbname,tag,options) \
if(o[@(name)]!=NULL) \
{ \
    id o0 = o[@(name)]; \
    if([o0 isKindOfClass:[NSString class]]) \
    { \
        value = [UMSS7ConfigObject filterName:o0]; \
    } \
    else if([o0 isKindOfClass:[NSArray class]]) \
    { \
        NSMutableArray *a2 = [[NSMutableArray alloc]init];\
        id o1; \
        NSArray *arr = (NSArray *)o0;\
        for(o1 in o0) \
        { \
            if([o1 isKindOfClass:[NSString class]]) \
            { \
                NSString *s = (NSString *)o1; \
                [a2 appendObject: [UMSS7ConfigObject filterName:s]];\
            } \
            else if([o1 isKindOfClass:[NSNumber class]]) \
            { \
                NSNumber *n = (NSNumber *)o1; \
                [a2 appendObject: n.stringValue]];\
            } \
        } \
        value = [((NSArray *)a2) componentsJoinedByString:@";"]; \
    } \
}

#define DATE(o,name,value,dbname,tag,options) \
if(dict[@(name)]!=NULL) \
{ \
    id obj = o[@(name)]; \
    if([obj isKindOfClass:[NSString class]]) \
    { \
        value = [obj dateValue]; \
    } \
    else if([obj isKindOfClass:[NSDate class]]) \
    { \
        value = o; \
    } \
    else if([obj isKindOfClass:[NSNumber class]]) \
    { \
        value = [[NSDate alloc]initWithTimeIntervalSinceReferenceDate:[obj doubleValue]]; \
    } \
}


#define ARRAY_COMPACT(o,name,value,dbname,tag,options) \
if(o[@(name)]!=NULL) \
{ \
    id obj = dict[@(name)]; \
    if([obj isKindOfClass:[NSString class]]) \
    { \
        value = [((NSString *)obj) componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" \t;"]]; \
    } \
    else if([obj isKindOfClass:[NSArray class]]) \
    { \
        value = obj; \
    } \
}

#define ARRAY_VERBOSE(o,name,value,dbname,tag,options) ARRAY_COMPACT(o,name,value,dbname,tag,options)





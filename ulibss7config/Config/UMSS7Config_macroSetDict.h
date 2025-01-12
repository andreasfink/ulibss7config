//
//  UMSS7ConfigGeneral_setMacro.h
//  ulibss7config
//
//  Created by Andreas Fink on 12.01.2025.
//  Copyright © 2025 Andreas Fink. All rights reserved.
//


#define BOOLEAN(dict,name,value) \
if(dict[@(name)]!=NULL) \
{ \
    id o = dict[@(name)]; \
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

#define DOUBLE(dict,name,value) \
if(dict[@(name)]!=NULL) \
{ \
    id o = dict[@(name)]; \
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


#define INTEGER(dict,name,value) \
if(dict[@(name)]!=NULL) \
{ \
    id o = dict[@(name)]; \
    if([o isKindOfClass:[NSString class]]) \
    { \
    NSString *str = (NSString *)o; \
        value = @([str intergerValueSupportingHex]); \
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

#define STRING(dict,name,value) \
if(dict[@(name)]!=NULL) \
{ \
    id o = dict[@(name)]; \
    if([o isKindOfClass:[NSString class]]) \
    { \
        value = o; \
    } \
    else if([o isKindOfClass:[NSArray class]]) \
    { \
         value = [((NSArray *)o) componentsJoinedByString:@";"]; \
    } \
}


#define FILTERED_STRING(dict,name,value) \
if(dict[@(name)]!=NULL) \
{ \
    id o0 = dict[@(name)]; \
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

#define DATE(dict,name,value) \
if(dict[@(name)]!=NULL) \
{ \
    id o = dict[@(name)]; \
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


#define ARRAY_COMPACT(dict,name,value) \
if(dict[@(name)]!=NULL) \
{ \
    id o = dict[@(name)]; \
    if([o isKindOfClass:[NSString class]]) \
    { \
        value = [((NSString *)o) componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" \t;"]]; \
    } \
    else if([o isKindOfClass:[NSArray class]]) \
    { \
        value = o; \
    } \
}

#define ARRAY_VERBOSE(dict,name,value) ARRAY_COMPACT(dict,name,value)





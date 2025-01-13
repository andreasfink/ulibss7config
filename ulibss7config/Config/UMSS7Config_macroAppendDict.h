//
//  UMSS7ConfigGeneral_appendDictMacro.h
//  ulibss7config
//
//  Created by Andreas Fink on 12.01.2025.
//  Copyright © 2025 Andreas Fink. All rights reserved.
//

#define BOOLEAN(dict,name,value,dbname,tag,options) \
if(value!=NULL) \
{ \
    dict[@(name)] = @(value.boolValue); \
}

#define DOUBLE(dict,name,value,dbname,tag,options) \
if(value!=NULL) \
{ \
    dict[@(name)] = @(value.doubleValue); \
}

#define INTEGER(dict,name,value,dbname,tag,options) \
if(value!=NULL) \
{ \
    dict[@(name)] = @(value.intValue); \
}

#define STRING(dict,name,value,dbname,tag,options) \
if(value!=NULL) \
{ \
    dict[@(name)] = value.stringValue; \
}

#define FILTERED_STRING(dict,name,value,dbname,tag,options) \
if(value!=NULL) \
{ \
    dict[@(name)] = [UMSS7ConfigObject filterName:value.stringValue]]; \
}

#define DATE(dict,name,value,dbname,tag,options) \
if(value!=NULL) \
{ \
    dict[@(name)] = value.stringValue; \
}

#define ARRAY_COMPACT(dict,name,array,dbname,tag,options) \
if(array!=NULL) \
{ \
    dict[@(name)] = array; \
}

#define ARRAY_VERBOSE(dict,name,value,dbname,tag,options) ARRAY_COMPACT(dict,name,value,dbname,tag,options)

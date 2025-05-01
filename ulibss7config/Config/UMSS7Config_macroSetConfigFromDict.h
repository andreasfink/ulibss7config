//
//  UMSS7ConfigGeneral_macroSetConfigFromDict.h
//  ulibss7config
//
//  Created by Andreas Fink on 12.01.2025.
//  Copyright © 2025 Andreas Fink. All rights reserved.
//


#define BOOLEAN(o,name,value,dbname,tag,options)            { NSNumber *v = setConfigFromDict_BOOLEAN(o,name,dbname,tag,options);         if(v) { value=v;}}
#define REAL(o,name,value,dbname,tag,options)             { NSNumber *v = setConfigFromDict_DOUBLE(o,name,dbname,tag,options);          if(v) { value=v;}}
#define INTEGER(o,name,value,dbname,tag,options)            { NSNumber *v = setConfigFromDict_INTEGER(o,name,dbname,tag,options);         if(v) { value=v;}}
#define STRING(o,name,value,dbname,tag,options)             { NSString *v = setConfigFromDict_STRING(o,name,dbname,tag,options);          if(v) { value=v;}}
#define FILTERED_STRING(o,name,value,dbname,tag,options)    { NSString *v = setConfigFromDict_FILTERED_STRING(o,name,dbname,tag,options); if(v) { value=v;}}
#define DATE(o,name,value,dbname,tag,options)               { NSDate   *v = setConfigFromDict_DATE(o,name,dbname,tag,options);            if(v) { value=v;}}
#define ARRAY_COMPACT(o,name,value,dbname,tag,options)      { NSArray  *v = setConfigFromDict_ARRAY_COMPACT(o,name,dbname,tag,options);   if(v) { value=v;}}
#define ARRAY_VERBOSE(o,name,value,dbname,tag,options)      { NSArray  *v = setConfigFromDict_ARRAY_VERBOSE(o,name,dbname,tag,options);   if(v) { value=v;}}
#define HEXDATA(o,name,value,dbname,tag,options)            { NSData   *v = setConfigFromDict_HEXDATA(o,name,dbname,tag,options);         if(v) { value=v;}}


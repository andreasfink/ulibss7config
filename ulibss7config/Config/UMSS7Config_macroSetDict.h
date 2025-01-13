//
//  UMSS7ConfigGeneral_setMacro.h
//  ulibss7config
//
//  Created by Andreas Fink on 12.01.2025.
//  Copyright © 2025 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

void setConfig_BOOLEAN(NSDictionary *o,char *name,NSNumber **value,const char *dbname,int tag,const char *options);
void setConfig_DOUBLE(NSDictionary *o,char *name,NSNumber **value,const char *dbname,int tag,const char *options);
void setConfig_INTEGER(NSDictionary *o,char *name,NSNumber **value,const char *dbname,int tag,const char *options);
void setConfig_STRING(NSDictionary *o,char *name,NSString **value,const char *dbname,int tag,const char *options);
void setConfig_FILTERED_STRING(NSDictionary *o,char *name,NSString **value,const char *dbname,int tag,const char *options);
void setConfig_DATE(NSDictionary *o,char *name,NSDate **value,const char *dbname,int tag,const char *options);
void setConfig_ARRAY_COMPACT(NSDictionary *o,char *name,NSArray **value,const char *dbname,int tag,const char *options);
void setConfig_ARRAY_VERBOSE(NSDictionary *o,char *name,NSArray **value,const char *dbname,int tag,const char *options);
void setConfig_HEXDATA(NSDictionary *o,char *name,NSArray **value,const char *dbname,int tag,const char *options);

#define BOOLEAN(o,name,value,dbname,tag,options)            setConfig_BOOLEAN(o,name,&value,dbname,tag,options);
#define DOUBLE(o,name,value,dbname,tag,options)             setConfig_DOUBLE(o,name,&value,dbname,tag,options);
#define INTEGER(o,name,value,dbname,tag,options)            setConfig_INTEGER(o,name,&value,dbname,tag,options);
#define STRING(o,name,value,dbname,tag,options)             setConfig_STRING(o,name,&value,dbname,tag,options);
#define FILTERED_STRING(o,name,value,dbname,tag,options)    setConfig_FILTERED_STRING(o,name,&value,dbname,tag,options);
#define DATE(o,name,value,dbname,tag,options)               setConfig_DATE(o,name,&value,dbname,tag,options);
#define ARRAY_COMPACT(o,name,value,dbname,tag,options)      setConfig_ARRAY_COMPACT(o,name,&value,dbname,tag,options);
#define ARRAY_VERBOSE(o,name,value,dbname,tag,options)      setConfig_ARRAY_VERBOSE(o,name,&value,dbname,tag,options);
#define HEXDATA(o,name,value,dbname,tag,options)            setConfig_HEXDATA(o,name,&value,dbname,tag,options);






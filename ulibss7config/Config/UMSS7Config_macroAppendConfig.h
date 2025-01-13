//
//  UMSS7Config_appendConfigMacro.h
//  ulibss7config
//
//  Created by Andreas Fink on 12.01.2025.
//  Copyright © 2025 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

#define BOOLEAN(str,name,value,dbname,tag,options)          appendConfig_BOOLEAN(str,name,value,dbname,tag,options);
#define DOUBLE(str,name,value,dbname,tag,options)           appendConfig_DOUBLE(str,name,value,dbname,tag,options);
#define INTEGER(str,name,value,dbname,tag,options)          appendConfig_INTEGER(str,name,value,dbname,tag,options);
#define STRING(str,name,value,dbname,tag,options)           appendConfig_STRING(str,name,value,dbname,tag,options);
#define HEXDATA(str,name,value,dbname,tag,options)          appendConfig_HEXDATA(str,name,value,dbname,tag,options);
#define FILTERED_STRING(str,name,value,dbname,tag,options)  appendConfig_FILTERED_STRING(str,name,value,dbname,tag,options);
#define DATE(str,name,value,dbname,tag,options)             appendConfig_DATE(str,name,value,dbname,tag,options);
#define ARRAY_VERBOSE(str,name,array,dbname,tag,options)    appendConfig_ARRAY_VERBOSE(str,name,value,dbname,tag,options);
#define ARRAY_COMPACT(o,name,array,dbname,tag,options)      appendConfig_ARRAY_COMPACT(str,name,value,dbname,tag,options);

void appendConfig_BOOLEAN(NSMutableString *str,char *name,NSNumber *value,const char *dbname,int tag,const char *options);
void appendConfig_DOUBLE(NSMutableString *str,const char *name,NSNumber *value,const char *dbname,int tag,const char *options);
void appendConfig_INTEGER(NSMutableString *str,const char *name,NSNumber *value,const char *dbname,int tag,const char *options);
void appendConfig_STRING(NSMutableString *str,const char *name,NSString *value,const char *dbname,int tag,const char *options);
void appendConfig_HEXDATA(NSMutableString *str,const char *name,NSData *value,const char *dbname,int tag,const char *options);
void appendConfig_FILTERED_STRING(NSMutableString *str,const char *name,NSString *value,const char *dbname,int tag,const char *options);
void appendConfig_DATE(NSMutableString *str,const char *name,NSDate *value,const char *dbname,int tag,const char *options);
void appendConfig_ARRAY_VERBOSE(NSMutableString *str,const char *name,NSArray *array,const char *dbname,int tag,const char *options);
void appendConfig_ARRAY_COMPACT(NSMutableString *str,const char *name,NSArray *array,const char *dbname,int tag,const char *options);

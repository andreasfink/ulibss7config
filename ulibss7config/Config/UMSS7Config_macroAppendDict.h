//
//  UMSS7ConfigGeneral_appendDictMacro.h
//  ulibss7config
//
//  Created by Andreas Fink on 12.01.2025.
//  Copyright © 2025 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

#define BOOLEAN(str,name,value,dbname,tag,options)          appendDict_BOOLEAN(str,name,value,dbname,tag,options);
#define DOUBLE(str,name,value,dbname,tag,options)           appendDict_DOUBLE(str,name,value,dbname,tag,options);
#define INTEGER(str,name,value,dbname,tag,options)          appendDict_INTEGER(str,name,value,dbname,tag,options);
#define STRING(str,name,value,dbname,tag,options)           appendDict_STRING(str,name,value,dbname,tag,options);
#define HEXDATA(str,name,value,dbname,tag,options)          appendDict_HEXDATA(str,name,value,dbname,tag,options);
#define FILTERED_STRING(str,name,value,dbname,tag,options)  appendDict_FILTERED_STRING(str,name,value,dbname,tag,options);
#define DATE(str,name,value,dbname,tag,options)             appendDict_DATE(str,name,value,dbname,tag,options);
#define ARRAY_VERBOSE(str,name,array,dbname,tag,options)    appendDict_ARRAY_VERBOSE(str,name,value,dbname,tag,options);
#define ARRAY_COMPACT(o,name,array,dbname,tag,options)      appendDict_ARRAY_COMPACT(str,name,value,dbname,tag,options);

void appendDict_BOOLEAN(UMSynchronizedSortedDictionary *str,char *name,NSNumber *value,const char *dbname,int tag,const char *options);
void appendDict_DOUBLE(UMSynchronizedSortedDictionary *str,const char *name,NSNumber *value,const char *dbname,int tag,const char *options);
void appendDict_INTEGER(UMSynchronizedSortedDictionary *str,const char *name,NSNumber *value,const char *dbname,int tag,const char *options);
void appendDict_STRING(UMSynchronizedSortedDictionary *str,const char *name,NSString *value,const char *dbname,int tag,const char *options);
void appendDict_HEXDATA(UMSynchronizedSortedDictionary *str,const char *name,NSData *value,const char *dbname,int tag,const char *options);
void appendDict_FILTERED_STRING(UMSynchronizedSortedDictionary *str,const char *name,NSString *value,const char *dbname,int tag,const char *options);
void appendDict_DATE(UMSynchronizedSortedDictionary *str,const char *name,NSDate *value,const char *dbname,int tag,const char *options);
void appendDict_ARRAY_VERBOSE(UMSynchronizedSortedDictionary *str,const char *name,NSArray *array,const char *dbname,int tag,const char *options);
void appendDict_ARRAY_COMPACT(UMSynchronizedSortedDictionary *str,const char *name,NSArray *array,const char *dbname,int tag,const char *options);

//
//  UMSS7ConfigMacroHelper.h
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

void appendConfig_BOOLEAN(NSMutableString *str,char *name,NSNumber *value,const char *dbname,int tag,const char *options);
void appendConfig_DOUBLE(NSMutableString *str,const char *name,NSNumber *value,const char *dbname,int tag,const char *options);
void appendConfig_INTEGER(NSMutableString *str,const char *name,NSNumber *value,const char *dbname,int tag,const char *options);
void appendConfig_STRING(NSMutableString *str,const char *name,NSString *value,const char *dbname,int tag,const char *options);
void appendConfig_HEXDATA(NSMutableString *str,const char *name,NSData *value,const char *dbname,int tag,const char *options);
void appendConfig_FILTERED_STRING(NSMutableString *str,const char *name,NSString *value,const char *dbname,int tag,const char *options);
void appendConfig_DATE(NSMutableString *str,const char *name,NSDate *value,const char *dbname,int tag,const char *options);
void appendConfig_ARRAY_VERBOSE(NSMutableString *str,const char *name,NSArray *array,const char *dbname,int tag,const char *options);
void appendConfig_ARRAY_COMPACT(NSMutableString *str,const char *name,NSArray *array,const char *dbname,int tag,const char *options);

void appendDict_BOOLEAN(UMSynchronizedSortedDictionary *dict,char *name,NSNumber *value,const char *dbname,int tag,const char *options);
void appendDict_DOUBLE(UMSynchronizedSortedDictionary *dict,char *name,NSNumber *value,const char *dbname,int tag,const char *options);
void appendDict_INTEGER(UMSynchronizedSortedDictionary *dict,char *name,NSNumber *value,const char *dbname,int tag,const char *options);
void appendDict_STRING(UMSynchronizedSortedDictionary *dict,const char *name,NSString *value,const char *dbname,int tag,const char *options);
void appendDict_HEXDATA(UMSynchronizedSortedDictionary *dict,const char *name,NSData *value,const char *dbname,int tag,const char *options);
void appendDict_FILTERED_STRING(UMSynchronizedSortedDictionary *dict,const char *name,NSString *value,const char *dbname,int tag,const char *options);
void appendDict_DATE(UMSynchronizedSortedDictionary *dict,const char *name,NSDate *value,const char *dbname,int tag,const char *options);
void appendDict_ARRAY_VERBOSE(UMSynchronizedSortedDictionary *dict,const char *name,NSArray *array,const char *dbname,int tag,const char *options);
void appendDict_ARRAY_COMPACT(UMSynchronizedSortedDictionary *dict,const char *name,NSArray *array,const char *dbname,int tag,const char *options);

void setConfig_BOOLEAN(NSDictionary *o,char *name,NSNumber **value,const char *dbname,int tag,const char *options);
void setConfig_DOUBLE(NSDictionary *o,char *name,NSNumber **value,const char *dbname,int tag,const char *options);
void setConfig_INTEGER(NSDictionary *o,char *name,NSNumber **value,const char *dbname,int tag,const char *options);
void setConfig_STRING(NSDictionary *o,char *name,NSString **value,const char *dbname,int tag,const char *options);
void setConfig_HEXDATA(NSDictionary *o,char *name,NSData **value,const char *dbname,int tag,const char *options);
void setConfig_FILTERED_STRING(NSDictionary *o,char *name,NSString **value,const char *dbname,int tag,const char *options);
void setConfig_DATE(NSDictionary *o,char *name,NSDate **value,const char *dbname,int tag,const char *options);
void setConfig_ARRAY_COMPACT(NSDictionary *o,char *name,NSArray **value,const char *dbname,int tag,const char *options);
void setConfig_ARRAY_VERBOSE(NSDictionary *o,char *name,NSArray **value,const char *dbname,int tag,const char *options);

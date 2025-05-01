//
//  start.m
//  ulibss7config
//
//  Created by Andreas Fink on 16.01.2025.
//  Copyright © 2025 Andreas Fink. All rights reserved.
//


o = [[NSMutableDictionary alloc]init];

#define BOOLEAN(o,name,value,dbname,tag,options)            check(o,name,tag,"boolean",s);
#define REAL(o,name,value,dbname,tag,options)             check(o,name,tag,"double",s);
#define INTEGER(o,name,value,dbname,tag,options)            check(o,name,tag,"integer",s);
#define STRING(o,name,value,dbname,tag,options)             check(o,name,tag,"string",s);
#define FILTERED_STRING(o,name,value,dbname,tag,options)    check(o,name,tag,"filtered_string",s);
#define DATE(o,name,value,dbname,tag,options)               check(o,name,tag,"date",s);
#define ARRAY_VERBOSE(o,name,value,dbname,tag,options)      check(o,name,tag,"array_verbose",s);
#define ARRAY_COMPACT(o,name,value,dbname,tag,options)      check(o,name,tag,"array_compact",s);
#define HEXDATA(o,name,value,dbname,tag,options)            check(o,name,tag,"hexdata",s);



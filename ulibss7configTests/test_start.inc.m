
o = [[NSMutableDictionary alloc]init];

#define BOOLEAN(o,name,value,dbname,tag,options)            check(o,name,value,dbname,tag,options,"boolean",s);
#define DOUBLE(o,name,value,dbname,tag,options)             check(o,name,value,dbname,tag,options,"double",s);
#define INTEGER(o,name,value,dbname,tag,options)            check(o,name,value,dbname,tag,options,"integer",s);
#define STRING(o,name,value,dbname,tag,options)             check(o,name,value,dbname,tag,options,"string",s);
#define FILTERED_STRING(o,name,value,dbname,tag,options)    check(o,name,value,dbname,tag,options,"filtered_string",s);
#define DATE(o,name,value,dbname,tag,options)               check(o,name,value,dbname,tag,options,"date",s);
#define ARRAY_VERBOSE(o,name,value,dbname,tag,options)      check(o,name,value,dbname,tag,options,"array_verbose",s);
#define ARRAY_COMPACT(o,name,value,dbname,tag,options)      check(o,name,value,dbname,tag,options,"array_compact",s);
#define HEXDATA(o,name,value,dbname,tag,options)            check(o,name,value,dbname,tag,options,"hexdata",s);



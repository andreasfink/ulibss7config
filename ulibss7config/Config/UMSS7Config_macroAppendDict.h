//
//  UMSS7ConfigGeneral_macroAppendDict.h
//  ulibss7config
//
//  Created by Andreas Fink on 12.01.2025.
//  Copyright © 2025 Andreas Fink. All rights reserved.
//

#define BOOLEAN(str,name,value,dbname,tag,options)          appendDict_BOOLEAN(str,name,value,dbname,tag,options);
#define REAL(str,name,value,dbname,tag,options)           appendDict_DOUBLE(str,name,value,dbname,tag,options);
#define INTEGER(str,name,value,dbname,tag,options)          appendDict_INTEGER(str,name,value,dbname,tag,options);
#define STRING(str,name,value,dbname,tag,options)           appendDict_STRING(str,name,value,dbname,tag,options);
#define FILTERED_STRING(str,name,value,dbname,tag,options)  appendDict_FILTERED_STRING(str,name,value,dbname,tag,options);
#define DATE(str,name,value,dbname,tag,options)             appendDict_DATE(str,name,value,dbname,tag,options);
#define ARRAY_VERBOSE(str,name,value,dbname,tag,options)    appendDict_ARRAY_VERBOSE(str,name,value,dbname,tag,options);
#define ARRAY_COMPACT(o,name,value,dbname,tag,options)      appendDict_ARRAY_COMPACT(str,name,value,dbname,tag,options);
#define HEXDATA(str,name,value,dbname,tag,options)          appendConfig_HEXDATA(str,name,value,dbname,tag,options);

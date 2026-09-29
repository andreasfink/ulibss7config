//
//  UMSS7Config_macroAppendConfig.h
//  ulibss7config
//
//  Created by Andreas Fink on 12.01.2025.
//  Copyright © 2025 Andreas Fink. All rights reserved.
//

#define BOOLEAN(str,name,value,dbname,tag,options)          appendConfig_BOOLEAN(str,name,value,dbname,tag,options);
#define REAL(str,name,value,dbname,tag,options)             appendConfig_REAL(str,name,value,dbname,tag,options);
#define INTEGER(str,name,value,dbname,tag,options)          appendConfig_INTEGER(str,name,value,dbname,tag,options);
#define STRING(str,name,value,dbname,tag,options)           appendConfig_STRING(str,name,value,dbname,tag,options);
#define FILTERED_STRING(str,name,value,dbname,tag,options)  appendConfig_FILTERED_STRING(str,name,value,dbname,tag,options);
#define DATE(str,name,value,dbname,tag,options)             appendConfig_DATE(str,name,value,dbname,tag,options);
#define ARRAY_VERBOSE(str,name,value,dbname,tag,options)    appendConfig_ARRAY_VERBOSE(str,name,value,dbname,tag,options);
#define ARRAY_COMPACT(o,name,value,dbname,tag,options)      appendConfig_ARRAY_COMPACT(str,name,value,dbname,tag,options);
#define HEXDATA(str,name,value,dbname,tag,options)          appendConfig_HEXDATA(str,name,value,dbname,tag,options);


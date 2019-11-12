//
//  UMSS7ApiTaskMacros.h
//  ulibss7config
//
//  Created by Andreas Fink on 12.11.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#define SET_DICT_STRING_OR_EMPTY(dict,key,str)  { if(str.length>0) { dict[key]=str; } else { dict[key] = @""; } }
#define SET_DICT_NUMBER_OR_ZERO(dict,key,nr)  { if(nr!=NULL) { dict[key]=nr; } else { dict[key] = @(0);} }

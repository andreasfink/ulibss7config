//
//  WebMacros.h
//  ulibss7config
//
//  Created by Andreas Fink on 20.11.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//


#define SOURCE_POS_DICT @{ @"file": @(__FILE__) , @"line":@(__LINE__) , @"func":@(__func__) }
#define SET_MANDATORY_PARAMETER(p,var,name) \
{\
    var = [p[name]urldecode]; \
    if((var.length <= 0) || ([var isEqualToString:@"default"]))\
    { \
        @throw([NSException exceptionWithName:@"PARAMETER_MISSING"\
                                       reason:[NSString stringWithFormat:@"%@ is mandatory",name]\
                                     userInfo:@{ @"location" :SOURCE_POS_DICT} ]);\
    } \
}
#define SET_MANDATORY_CLEAN_PARAMETER(p,var,name) \
{\
    var = [p[name]urldecode]; \
    if((var.length <= 0) || ([var isEqualToString:@"default"]))\
    { \
        @throw([NSException exceptionWithName:@"PARAMETER_MISSING"\
                                       reason:[NSString stringWithFormat:@"%@ is mandatory",name]\
                                     userInfo:@{ @"location" :SOURCE_POS_DICT} ]);\
    } \
    var = [var stringByTrimmingCharactersInSet:[UMObject whitespaceAndNewlineCharacterSet]];\
}


#define REQUIRE_MANDATORY_PARAMETER(p,name) \
{\
    NSString *tmp = [p[name]urldecode];\
    if((tmp.length <= 0) || ([tmp isEqualToString:@"default"]))\
    { \
        @throw([NSException exceptionWithName:@"PARAMETER_MISSING"\
        reason:[NSString stringWithFormat:@"%@ is mandatory",name]\
        userInfo:@{ @"location" :SOURCE_POS_DICT} ]);\
    } \
}

#define SET_OPTIONAL_PARAMETER(p,var,name)   \
{\
    var = [p[name]urldecode];\
    if([var isEqualToString:@"default" ])\
    {\
        var = NULL;\
    } \
}

#define SET_OPTIONAL_CLEAN_PARAMETER(p,var,name)   \
{\
	var = [p[name]urldecode];\
	var = [var stringByTrimmingCharactersInSet:[UMObject whitespaceAndNewlineCharacterSet]];\
	if([var isEqualToString:@"default" ])\
	{\
		var = NULL;\
	} \
}

#define SET_OPTIONAL_CLEAN_PARAMETERS(p,var,name)   \
{\
    NSString *vars = [p[name]urldecode];\
    vars = [vars stringByTrimmingCharactersInSet:[UMObject whitespaceAndNewlineCharacterSet]];\
    if([vars isEqualToString:@"default" ])\
    {\
        var = NULL;\
    } \
    else \
    { \
        var = [vars componentsSeparatedByString:@","];\
    } \
}

#define  SET_TIMEOUT(t,p,deft) \
{ \
    t.timeoutValue = deft; \
    NSString *to = [p[@"timeout"]urldecode];\
    if(to.length > 0) \
    { \
        t.timeoutValue = [to doubleValue];\
    }\
    t.timeoutTime = [NSDate dateWithTimeInterval:t.timeoutValue sinceDate:[NSDate date]];\
}

#define VERIFY_EITHER_OR(imsi,msisdn) \
{\
    if ((imsi.length==0) && (msisdn.length==0))\
    {\
        @throw([NSException exceptionWithName:@"PARAMETER_ERROR"\
                                       reason:@"one of ##imsi or ##msisdn is required"\
                                     userInfo:@{    @"backtrace":   UMBacktrace(NULL,0) }]);\
    }\
    if ((imsi.length > 0) && (msisdn.length > 0))\
    {\
        @throw([NSException exceptionWithName:@"PARAMETER_ERROR"\
                                       reason:@"either ##imsi or ##msisdn is required but not both"\
                                     userInfo:@{    @"backtrace":   UMBacktrace(NULL,0) }]);\
    }\
}


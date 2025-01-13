//
//  UMSS7ConfigM2PA.m
//  estp
//
//  Created by Andreas Fink on 01.02.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigM2PA.h"
#import "UMSS7ConfigMacros.h"
@implementation UMSS7ConfigM2PA

+ (NSString *)type
{
    return @"m2pa";
}

- (NSString *)type
{
    return [UMSS7ConfigM2PA type];
}


- (UMSS7ConfigM2PA *)initWithConfig:(NSDictionary *)dict
{
    self = [super initWithConfig:dict];
    if(self)
    {
        [self setConfig:dict];
    }
    return self;
}

- (void)appendConfigToString:(NSMutableString *)o
{
    [super appendConfigToString:o];
    APPEND_CONFIG_STRING(o,@"attach-to",_attachTo);
    APPEND_CONFIG_INTEGER(o,@"window-size",_windowSize);
    APPEND_CONFIG_DOUBLE(o,@"t1",_t1);
    APPEND_CONFIG_DOUBLE(o,@"t2",_t2);
    APPEND_CONFIG_DOUBLE(o,@"t3",_t3);
    APPEND_CONFIG_DOUBLE(o,@"t4e",_t4e);
    APPEND_CONFIG_DOUBLE(o,@"t4n",_t4n);
    APPEND_CONFIG_DOUBLE(o,@"t5",_t5);
    APPEND_CONFIG_DOUBLE(o,@"t6",_t6);
    APPEND_CONFIG_DOUBLE(o,@"t7",_t7);
    APPEND_CONFIG_DOUBLE(o,@"t16",_t16);
    APPEND_CONFIG_DOUBLE(o,@"t17",_t17);
    APPEND_CONFIG_DOUBLE(o,@"t18",_t18);
    APPEND_CONFIG_DOUBLE(o,@"ack-timer",_ackTimer);
    APPEND_CONFIG_STRING(o,@"state-machine-log",_stateMachineLog);

}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
    APPEND_DICT_STRING(o,@"attach-to",_attachTo);
    APPEND_DICT_INTEGER(o,@"window-size",_windowSize);
    APPEND_DICT_DOUBLE(o,@"t1",_t1);
    APPEND_DICT_DOUBLE(o,@"t2",_t2);
    APPEND_DICT_DOUBLE(o,@"t3",_t3);
    APPEND_DICT_DOUBLE(o,@"t4e",_t4e);
    APPEND_DICT_DOUBLE(o,@"t4n",_t4n);
    APPEND_DICT_DOUBLE(o,@"t5",_t5);
    APPEND_DICT_DOUBLE(o,@"t6",_t6);
    APPEND_DICT_DOUBLE(o,@"t7",_t7);
    APPEND_DICT_DOUBLE(o,@"t16",_t16);
    APPEND_DICT_DOUBLE(o,@"t17",_t17);
    APPEND_DICT_DOUBLE(o,@"t18",_t18);
    APPEND_DICT_DOUBLE(o,@"ack-timer",_ackTimer);
    APPEND_DICT_STRING(o,@"state-machine-log",_stateMachineLog);

    return dict;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
    SET_DICT_STRING(o,@"attach-to",_attachTo);
    SET_DICT_INTEGER(o,@"window-size",_windowSize);
    SET_DICT_DOUBLE(o,@"t1",_t1);
    SET_DICT_DOUBLE(o,@"t2",_t2);
    SET_DICT_DOUBLE(o,@"t3",_t3);
    SET_DICT_DOUBLE(o,@"t4e",_t4e);
    SET_DICT_DOUBLE(o,@"t4n",_t4n);
    SET_DICT_DOUBLE(o,@"t5",_t5);
    SET_DICT_DOUBLE(o,@"t6",_t6);
    SET_DICT_DOUBLE(o,@"t7",_t7);
    SET_DICT_DOUBLE(o,@"t16",_t16);
    SET_DICT_DOUBLE(o,@"t17",_t17);
    SET_DICT_DOUBLE(o,@"t18",_t18);
    SET_DICT_DOUBLE(o,@"ack-timer",_ackTimer);
    SET_DICT_STRING(o,@"state-machine-log",_stateMachineLog);
}

- (UMSS7ConfigM2PA *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigM2PA allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end


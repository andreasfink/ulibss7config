//
//  UMSS7ConfigM3UAASP.m
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigM3UAASP.h"
#import "UMSS7ConfigMacros.h"
@implementation UMSS7ConfigM3UAASP

+ (NSString *)type
{
    return @"m3ua-asp";
}

- (NSString *)type
{
    return [UMSS7ConfigM3UAASP type];
}


- (UMSS7ConfigM3UAASP *)initWithConfig:(NSDictionary *)dict
{
    self = [super initWithConfig:dict];
    if(self)
    {
        [self setConfig:dict];
    }
    return self;
}

- (void)appendConfigToString:(NSMutableString *)s
{
    [super appendConfigToString:s];
    APPEND_CONFIG_STRING(s,@"m3ua-as",_m3ua_as);
    APPEND_CONFIG_STRING(s,@"attach-to",_attachTo);
    APPEND_CONFIG_DOUBLE(s,@"reopen-timer1",_reopenTimer1);
    APPEND_CONFIG_DOUBLE(s,@"reopen-timer2",_reopenTimer1);
    APPEND_CONFIG_DOUBLE(s,@"linktest-timer",_linktestTimer);
    APPEND_CONFIG_DOUBLE(s,@"beat-timer",_beatTimer);
    APPEND_CONFIG_INTEGER(s,@"beat-max-outstanding",_beatMaxOutstanding);
    APPEND_CONFIG_ARRAY_VERBOSE(s,@"inbound-filter",_inbond_filter_rulesets);
    APPEND_CONFIG_ARRAY_VERBOSE(s,@"outbound-filter",_outbound_filter_rulesets);
}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];

    APPEND_DICT_STRING(dict,@"m3ua-as",_m3ua_as);
    APPEND_DICT_STRING(dict,@"attach-to",_attachTo);
    APPEND_DICT_DOUBLE(dict,@"reopen-timer1",_reopenTimer1);
    APPEND_DICT_DOUBLE(dict,@"reopen-timer2",_reopenTimer1);
    APPEND_DICT_DOUBLE(dict,@"linktest-timer",_linktestTimer);
    APPEND_DICT_DOUBLE(dict,@"beat-timer",_beatTimer);
    APPEND_DICT_INTEGER(dict,@"beat-max-outstanding",_beatMaxOutstanding);
    APPEND_DICT_ARRAY(dict,@"inbound-filter",_inbond_filter_rulesets);
    APPEND_DICT_ARRAY(dict,@"outbound-filter",_outbound_filter_rulesets);
    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_STRING(dict,@"m3ua-as",_m3ua_as);
    SET_DICT_STRING(dict,@"attach-to",_attachTo);
    SET_DICT_DOUBLE(dict,@"reopen-timer1",_reopenTimer1);
    SET_DICT_DOUBLE(dict,@"reopen-timer2",_reopenTimer1);
    SET_DICT_DOUBLE(dict,@"linktest-timer",_linktestTimer);
    SET_DICT_DOUBLE(dict,@"beat-timer",_beatTimer);
    SET_DICT_INTEGER(dict,@"beat-max-outstanding",_beatMaxOutstanding);
    SET_DICT_ARRAY(dict,@"inbound-filter",_inbond_filter_rulesets);
    SET_DICT_ARRAY(dict,@"outbound-filter",_outbound_filter_rulesets);
}

- (UMSS7ConfigM3UAASP *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigM3UAASP allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end


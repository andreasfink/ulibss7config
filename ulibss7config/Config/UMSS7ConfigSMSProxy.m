//
//  UMSS7ConfigSMSProxy.m
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSMSProxy.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigSMSProxy


+ (NSString *)type
{
    return @"smsproxy";
}

- (NSString *)type
{
    return [UMSS7ConfigSMSProxy type];
}


- (UMSS7ConfigSMSProxy *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(s,@"number",_number);
    APPEND_CONFIG_STRING(s,@"sccp",_sccp);
    APPEND_CONFIG_STRING(s,@"license-directory",_licenseDirectory);
    APPEND_CONFIG_STRING(s,@"attach-as-hlr",_attachAsHlr);
    APPEND_CONFIG_STRING(s,@"attach-as-msc",_attachAsMsc);
    APPEND_CONFIG_STRING(s,@"attach-as-smsc",_attachAsSmsc);
    APPEND_CONFIG_STRING(s,@"named-list-directory",_namedListsDirectory);
    APPEND_CONFIG_STRING(s,@"filter-directory",_filterDirectory);
    APPEND_CONFIG_STRING(s,@"filter-srism",_filterSriSm);
    APPEND_CONFIG_STRING(s,@"filter-srism-resp",_filterSirSmResp);
    APPEND_CONFIG_STRING(s,@"filter-forwardsm",_filterForwardSm);
    APPEND_CONFIG_STRING(s,@"filter-forwardsm-resp",_filterForwardSmResp);
    APPEND_CONFIG_DOUBLE(s,@"timeout",_timeout);
    APPEND_CONFIG_DOUBLE(s,@"imsi-timer",_imsiTimer);
    APPEND_CONFIG_STRING(s,@"imsi-prefix",_imsiPrefix);
    APPEND_CONFIG_STRING(s,@"cdr-writer",_cdrWriter);
    APPEND_CONFIG_INTEGER(s,@"smsc-translation-type",_smscTranslationType);
    APPEND_CONFIG_INTEGER(s,@"srism-translation-type",_srismTranslationType);
    APPEND_CONFIG_INTEGER(s,@"forwardsm-translation-type",_forwardsmTranslationType);


}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];

    APPEND_DICT_STRING(dict,@"number",_number);
    APPEND_DICT_STRING(dict,@"sccp",_sccp);
    APPEND_DICT_STRING(dict,@"license-directory",_licenseDirectory);
    APPEND_DICT_STRING(dict,@"attach-as-hlr",_attachAsHlr);
    APPEND_DICT_STRING(dict,@"attach-as-msc",_attachAsMsc);
    APPEND_DICT_STRING(dict,@"attach-as-smsc",_attachAsSmsc);
    APPEND_DICT_STRING(dict,@"named-list-directory",_namedListsDirectory);
    APPEND_DICT_STRING(dict,@"filter-directory",_filterDirectory);
    APPEND_DICT_STRING(dict,@"filter-srism",_filterSriSm);
    APPEND_DICT_STRING(dict,@"filter-srism-resp",_filterSirSmResp);
    APPEND_DICT_STRING(dict,@"filter-forwardsm",_filterForwardSm);
    APPEND_DICT_STRING(dict,@"filter-forwardsm-resp",_filterForwardSmResp);
    APPEND_DICT_DOUBLE(dict,@"timeout",_timeout);
    APPEND_DICT_DOUBLE(dict,@"imsi-timer",_imsiTimer);
    APPEND_DICT_STRING(dict,@"imsi-prefix",_imsiPrefix);
    APPEND_DICT_STRING(dict,@"cdr-writer",_cdrWriter);
    APPEND_DICT_INTEGER(dict,@"smsc-translation-type",_smscTranslationType);
    APPEND_DICT_INTEGER(dict,@"srism-translation-type",_srismTranslationType);
    APPEND_DICT_INTEGER(dict,@"forwardsm-translation-type",_forwardsmTranslationType);


    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_STRING(dict,@"number",_number);
    SET_DICT_STRING(dict,@"sccp",_sccp);
    SET_DICT_STRING(dict,@"license-directory",_licenseDirectory);
    SET_DICT_STRING(dict,@"attach-as-hlr",_attachAsHlr);
    SET_DICT_STRING(dict,@"attach-as-msc",_attachAsMsc);
    SET_DICT_STRING(dict,@"attach-as-smsc",_attachAsSmsc);
    SET_DICT_STRING(dict,@"named-list-directory",_namedListsDirectory);
    SET_DICT_STRING(dict,@"filter-directory",_filterDirectory);
    SET_DICT_STRING(dict,@"filter-srism",_filterSriSm);
    SET_DICT_STRING(dict,@"filter-srism-resp",_filterSirSmResp);
    SET_DICT_STRING(dict,@"filter-forwardsm",_filterForwardSm);
    SET_DICT_STRING(dict,@"filter-forwardsm-resp",_filterForwardSmResp);
    SET_DICT_DOUBLE(dict,@"timeout",_timeout);
    SET_DICT_DOUBLE(dict,@"imsi-timer",_imsiTimer);
    SET_DICT_STRING(dict,@"imsi-prefix",_imsiPrefix);
    SET_DICT_STRING(dict,@"cdr-writer",_cdrWriter);
    SET_DICT_INTEGER(dict,@"smsc-translation-type",_smscTranslationType);
    SET_DICT_INTEGER(dict,@"srism-translation-type",_srismTranslationType);
    SET_DICT_INTEGER(dict,@"forwardsm-translation-type",_forwardsmTranslationType);

}


- (UMSS7ConfigSMSProxy *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSMSProxy allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}
@end




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


- (void)appendConfigToString:(NSMutableString *)o
{
    [super appendConfigToString:o];
    APPEND_CONFIG_STRING(o,@"number",_number);
    APPEND_CONFIG_STRING(o,@"sccp",_sccp);
    APPEND_CONFIG_STRING(o,@"license-directory",_licenseDirectory);
    APPEND_CONFIG_STRING(o,@"attach-as-hlr",_attachAsHlr);
    APPEND_CONFIG_STRING(o,@"attach-as-msc",_attachAsMsc);
    APPEND_CONFIG_STRING(o,@"attach-as-smsc",_attachAsSmsc);
    APPEND_CONFIG_STRING(o,@"named-lists-directory",_namedListsDirectory);
    APPEND_CONFIG_STRING(o,@"filter-directory",_filterDirectory);
    APPEND_CONFIG_STRING(o,@"filter-srism",_filterSriSm);
    APPEND_CONFIG_STRING(o,@"filter-srism-resp",_filterSirSmResp);
    APPEND_CONFIG_STRING(o,@"filter-forwardsm",_filterForwardSm);
    APPEND_CONFIG_STRING(o,@"filter-forwardsm-resp",_filterForwardSmResp);
	APPEND_CONFIG_STRING(o,@"filter-mo-submit",_filterMoForwardSmSubmit);
	APPEND_CONFIG_STRING(o,@"filter-mo-submit-resp",_filterMoForwardSmSubmitResp);
    APPEND_CONFIG_DOUBLE(o,@"timeout",_timeout);
    APPEND_CONFIG_DOUBLE(o,@"imsi-timer",_imsiTimer);
    APPEND_CONFIG_STRING(o,@"imsi-prefix",_imsiPrefix);
    APPEND_CONFIG_STRING(o,@"cdr-writer",_cdrWriter);
    APPEND_CONFIG_INTEGER(o,@"smsc-translation-type",_smscTranslationType);
    APPEND_CONFIG_INTEGER(o,@"srism-translation-type",_srismTranslationType);
	APPEND_CONFIG_INTEGER(o,@"forwardsm-translation-type",_forwardsmTranslationType);
	APPEND_CONFIG_INTEGER(o,@"moforwardsm-submit-translation-type",_moForwardsmSubmitTranslationType);
	APPEND_CONFIG_INTEGER(o,@"moforwardsm-submit-hlr-check",_moForwardSmSubmitHlrCheck);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];

    APPEND_DICT_STRING(o,@"number",_number);
    APPEND_DICT_STRING(o,@"sccp",_sccp);
    APPEND_DICT_STRING(o,@"license-directory",_licenseDirectory);
    APPEND_DICT_STRING(o,@"attach-as-hlr",_attachAsHlr);
    APPEND_DICT_STRING(o,@"attach-as-msc",_attachAsMsc);
    APPEND_DICT_STRING(o,@"attach-as-smsc",_attachAsSmsc);
    APPEND_DICT_STRING(o,@"named-lists-directory",_namedListsDirectory);
    APPEND_DICT_STRING(o,@"filter-directory",_filterDirectory);
    APPEND_DICT_STRING(o,@"filter-srism",_filterSriSm);
    APPEND_DICT_STRING(o,@"filter-srism-resp",_filterSirSmResp);
    APPEND_DICT_STRING(o,@"filter-forwardsm",_filterForwardSm);
    APPEND_DICT_STRING(o,@"filter-forwardsm-resp",_filterForwardSmResp);
	APPEND_DICT_STRING(o,@"filter-mo-submit",_filterMoForwardSmSubmit);
	APPEND_DICT_STRING(o,@"filter-mo-submit-resp",_filterMoForwardSmSubmitResp);
    APPEND_DICT_DOUBLE(o,@"timeout",_timeout);
    APPEND_DICT_DOUBLE(o,@"imsi-timer",_imsiTimer);
    APPEND_DICT_STRING(o,@"imsi-prefix",_imsiPrefix);
    APPEND_DICT_STRING(o,@"cdr-writer",_cdrWriter);
    APPEND_DICT_INTEGER(o,@"smsc-translation-type",_smscTranslationType);
    APPEND_DICT_INTEGER(o,@"srism-translation-type",_srismTranslationType);
    APPEND_DICT_INTEGER(o,@"forwardsm-translation-type",_forwardsmTranslationType);
	APPEND_DICT_INTEGER(o,@"moforwardsm-submit-translation-type",_moForwardsmSubmitTranslationType);
	APPEND_DICT_INTEGER(o,@"moforwardsm-submit-hlr-check",_moForwardSmSubmitHlrCheck);
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
    SET_DICT_STRING(o,@"number",_number);
    SET_DICT_STRING(o,@"sccp",_sccp);
    SET_DICT_STRING(o,@"license-directory",_licenseDirectory);
    SET_DICT_STRING(o,@"attach-as-hlr",_attachAsHlr);
    SET_DICT_STRING(o,@"attach-as-msc",_attachAsMsc);
    SET_DICT_STRING(o,@"attach-as-smsc",_attachAsSmsc);
    SET_DICT_STRING(o,@"named-lists-directory",_namedListsDirectory);
    SET_DICT_STRING(o,@"filter-directory",_filterDirectory);
    SET_DICT_STRING(o,@"filter-srism",_filterSriSm);
    SET_DICT_STRING(o,@"filter-srism-resp",_filterSirSmResp);
    SET_DICT_STRING(o,@"filter-forwardsm",_filterForwardSm);
    SET_DICT_STRING(o,@"filter-forwardsm-resp",_filterForwardSmResp);
	SET_DICT_STRING(o,@"filter-mo-submit",_filterMoForwardSmSubmit);
	SET_DICT_STRING(o,@"filter-mo-submit-resp",_filterMoForwardSmSubmitResp);
    SET_DICT_DOUBLE(o,@"timeout",_timeout);
    SET_DICT_DOUBLE(o,@"imsi-timer",_imsiTimer);
    SET_DICT_STRING(o,@"imsi-prefix",_imsiPrefix);
    SET_DICT_STRING(o,@"cdr-writer",_cdrWriter);
    SET_DICT_INTEGER(o,@"smsc-translation-type",_smscTranslationType);
    SET_DICT_INTEGER(o,@"srism-translation-type",_srismTranslationType);
    SET_DICT_INTEGER(o,@"forwardsm-translation-type",_forwardsmTranslationType);
	SET_DICT_INTEGER(o,@"moforwardsm-submit-translation-type",_moForwardsmSubmitTranslationType);
	SET_DICT_INTEGER(o,@"moforwardsm-submit-hlr-check",_moForwardSmSubmitHlrCheck);
}


- (UMSS7ConfigSMSProxy *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSMSProxy allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}
@end




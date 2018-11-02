//
//  UMSS7ConfigSMSCUserProfile.m
//  ulibss7config
//
//  Created by Andreas Fink on 08.05.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSMSCUserProfile.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigSMSCUserProfile

+ (NSString *)type
{
    return @"user-profile";
}
- (NSString *)type
{
    return [UMSS7ConfigSMSCUserProfile type];
}

- (UMSS7ConfigSMSCUserProfile *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(s,@"instance",_instance);
    APPEND_CONFIG_STRING(s,@"delivery-method",_deliveryMethod);
    APPEND_CONFIG_STRING(s,@"sri-sm-opc",_sriSmOpc);
    APPEND_CONFIG_STRING(s,@"sri-sm-dpc",_sriSmDpc);
    APPEND_CONFIG_STRING(s,@"sri-sm-sccp-calling-address",_sriSmSccpCallingAddress);
    APPEND_CONFIG_STRING(s,@"sri-sm-sccp-called-address-prefix",_sriSmSccpCalledAddressPrefix);
    APPEND_CONFIG_STRING(s,@"sri-sm-sccp-called-address-replacement",_sriSmSccpCalledAddressReplacement);
    APPEND_CONFIG_INTEGER(s,@"sri-sm-sccp-called-translation-table",_sriSmSccpCalledTranslationTable);
    APPEND_CONFIG_STRING(s,@"sri-sm-gsm-map-smsc-address",_sriSmGsmMapSmscAddress);

    APPEND_CONFIG_STRING(s,@"forward-sm-opc",_forwardSmOpc);
    APPEND_CONFIG_STRING(s,@"forward-sm-dpc",_forwardSmDpc);
    APPEND_CONFIG_STRING(s,@"forward-sm-sccp-calling-address",_forwardSmSccpCallingAddress);
    APPEND_CONFIG_STRING(s,@"forward-sm-sccp-called-address-prefix",_forwardSmSccpCalledAddressPrefix);
    APPEND_CONFIG_STRING(s,@"forward-sm-sccp-called-address-replacement",_forwardSmSccpCalledAddressReplacement);
    APPEND_CONFIG_INTEGER(s,@"forward-sm-sccp-called-translation-table",_forwardSmSccpCalledTranslationTable);
    APPEND_CONFIG_STRING(s,@"forward-sm-gsm-map-smsc-address",_forwardSmGsmMapSmscAddress);

    APPEND_CONFIG_STRING(s,@"replace-sender-id",_fixedSenderId);
    APPEND_CONFIG_STRING(s,@"msc-from",_mscFrom);
    APPEND_CONFIG_INTEGER(s,@"priority",_priority);
    APPEND_CONFIG_STRING(s,@"timezone",_timezone);
    APPEND_CONFIG_STRING(s,@"ts",_ts);
    APPEND_CONFIG_DOUBLE(s,@"max-submission-speed",_maxSubmissionSpeed);
    APPEND_CONFIG_INTEGER(s,@"max-attempts",_maxAttempts);
    APPEND_CONFIG_INTEGER(s,@"max-attempts-for-delivery-reports",_maxAttemptsDlr);
    APPEND_CONFIG_STRING(s,@"retry-pattern",_retryPattern);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];
    APPEND_DICT_STRING(dict,@"instance",_instance);
    APPEND_DICT_STRING(dict,@"delivery-method",_deliveryMethod);
    APPEND_DICT_STRING(dict,@"sri-sm-opc",_sriSmOpc);
    APPEND_DICT_STRING(dict,@"sri-sm-dpc",_sriSmDpc);
    APPEND_DICT_STRING(dict,@"sri-sm-sccp-calling-address",_sriSmSccpCallingAddress);
    APPEND_DICT_STRING(dict,@"sri-sm-sccp-called-address-prefix",_sriSmSccpCalledAddressPrefix);
    APPEND_DICT_STRING(dict,@"sri-sm-sccp-called-address-replacement",_sriSmSccpCalledAddressReplacement);
    APPEND_DICT_INTEGER(dict,@"sri-sm-sccp-called-translation-table",_sriSmSccpCalledTranslationTable);
    APPEND_DICT_STRING(dict,@"sri-sm-gsm-map-smsc-address",_sriSmGsmMapSmscAddress);

    APPEND_DICT_STRING(dict,@"forward-sm-opc",_forwardSmOpc);
    APPEND_DICT_STRING(dict,@"forward-sm-dpc",_forwardSmDpc);
    APPEND_DICT_STRING(dict,@"forward-sm-sccp-calling-address",_forwardSmSccpCallingAddress);
    APPEND_DICT_STRING(dict,@"forward-sm-sccp-called-address-prefix",_forwardSmSccpCalledAddressPrefix);
    APPEND_DICT_STRING(dict,@"forward-sm-sccp-called-address-replacement",_forwardSmSccpCalledAddressReplacement);
    APPEND_DICT_INTEGER(dict,@"forward-sm-sccp-called-translation-table",_forwardSmSccpCalledTranslationTable);
    APPEND_DICT_STRING(dict,@"forward-sm-gsm-map-smsc-address",_forwardSmGsmMapSmscAddress);

    APPEND_DICT_STRING(dict,@"replace-sender-id",_fixedSenderId);
    APPEND_DICT_STRING(dict,@"msc-from",_mscFrom);
    APPEND_DICT_INTEGER(dict,@"priority",_priority);
    APPEND_DICT_STRING(dict,@"timezone",_timezone);
    APPEND_DICT_STRING(dict,@"ts",_ts);
    APPEND_DICT_DOUBLE(dict,@"max-submission-speed",_maxSubmissionSpeed);
    APPEND_DICT_INTEGER(dict,@"max-attempts",_maxAttempts);
    APPEND_DICT_INTEGER(dict,@"max-attempts-for-delivery-reports",_maxAttemptsDlr);
    APPEND_DICT_STRING(dict,@"retry-pattern",_retryPattern);
    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    SET_DICT_STRING(dict,@"instance",_instance);
    SET_DICT_STRING(dict,@"delivery-method",_deliveryMethod);
    SET_DICT_STRING(dict,@"sri-sm-opc",_sriSmOpc);
    SET_DICT_STRING(dict,@"sri-sm-dpc",_sriSmDpc);
    SET_DICT_STRING(dict,@"sri-sm-sccp-calling-address",_sriSmSccpCallingAddress);
    SET_DICT_STRING(dict,@"sri-sm-sccp-called-address-prefix",_sriSmSccpCalledAddressPrefix);
    SET_DICT_STRING(dict,@"sri-sm-sccp-called-address-replacement",_sriSmSccpCalledAddressReplacement);
    SET_DICT_INTEGER(dict,@"sri-sm-sccp-called-translation-table",_sriSmSccpCalledTranslationTable);
    SET_DICT_STRING(dict,@"sri-sm-gsm-map-smsc-address",_sriSmGsmMapSmscAddress);

    SET_DICT_STRING(dict,@"forward-sm-opc",_forwardSmOpc);
    SET_DICT_STRING(dict,@"forward-sm-dpc",_forwardSmDpc);
    SET_DICT_STRING(dict,@"forward-sm-sccp-calling-address",_forwardSmSccpCallingAddress);
    SET_DICT_STRING(dict,@"forward-sm-sccp-called-address-prefix",_forwardSmSccpCalledAddressPrefix);
    SET_DICT_STRING(dict,@"forward-sm-sccp-called-address-replacement",_forwardSmSccpCalledAddressReplacement);
    SET_DICT_INTEGER(dict,@"forward-sm-sccp-called-translation-table",_forwardSmSccpCalledTranslationTable);
    SET_DICT_STRING(dict,@"forward-sm-gsm-map-smsc-address",_forwardSmGsmMapSmscAddress);

    SET_DICT_STRING(dict,@"replace-sender-id",_fixedSenderId);
    SET_DICT_STRING(dict,@"msc-from",_mscFrom);
    SET_DICT_INTEGER(dict,@"priority",_priority);
    SET_DICT_STRING(dict,@"timezone",_timezone);
    SET_DICT_STRING(dict,@"ts",_ts);
    SET_DICT_DOUBLE(dict,@"max-submission-speed",_maxSubmissionSpeed);
    SET_DICT_INTEGER(dict,@"max-attempts",_maxAttempts);
    SET_DICT_INTEGER(dict,@"max-attempts-for-delivery-reports",_maxAttemptsDlr);
    SET_DICT_STRING(dict,@"retry-pattern",_retryPattern);
}

- (UMSS7ConfigSMSCUserProfile *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSMSCUserProfile allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end

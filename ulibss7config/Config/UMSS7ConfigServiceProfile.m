//
//  UMSS7ConfigServiceUserProfile.m
//  ulibss7config
//
//  Created by Andreas Fink on 08.05.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigServiceProfile.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigServiceProfile

+ (NSString *)type
{
    return @"service-profile";
}
- (NSString *)type
{
    return [UMSS7ConfigServiceProfile type];
}

- (UMSS7ConfigServiceProfile *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(o,@"instance",_instance);
    APPEND_CONFIG_STRING(o,@"delivery-method",_deliveryMethod);
    APPEND_CONFIG_STRING(o,@"sri-sm-opc",_sriSmOpc);
    APPEND_CONFIG_STRING(o,@"sri-sm-dpc",_sriSmDpc);
    APPEND_CONFIG_STRING(o,@"sri-sm-sccp-calling-address",_sriSmSccpCallingAddress);
    APPEND_CONFIG_STRING(o,@"sri-sm-sccp-called-address-prefix",_sriSmSccpCalledAddressPrefix);
    APPEND_CONFIG_STRING(o,@"sri-sm-sccp-called-address-replacement",_sriSmSccpCalledAddressReplacement);
    APPEND_CONFIG_INTEGER(o,@"sri-sm-sccp-called-translation-table",_sriSmSccpCalledTranslationTable);
    APPEND_CONFIG_STRING(o,@"sri-sm-gsm-map-smsc-address",_sriSmGsmMapSmscAddress);

    APPEND_CONFIG_STRING(o,@"forward-sm-opc",_forwardSmOpc);
    APPEND_CONFIG_STRING(o,@"forward-sm-dpc",_forwardSmDpc);
    APPEND_CONFIG_STRING(o,@"forward-sm-sccp-calling-address",_forwardSmSccpCallingAddress);
    APPEND_CONFIG_STRING(o,@"forward-sm-sccp-called-address-prefix",_forwardSmSccpCalledAddressPrefix);
    APPEND_CONFIG_STRING(o,@"forward-sm-sccp-called-address-replacement",_forwardSmSccpCalledAddressReplacement);
    APPEND_CONFIG_INTEGER(o,@"forward-sm-sccp-called-translation-table",_forwardSmSccpCalledTranslationTable);
    APPEND_CONFIG_STRING(o,@"forward-sm-gsm-map-smsc-address",_forwardSmGsmMapSmscAddress);

    APPEND_CONFIG_STRING(o,@"replace-sender-id",_fixedSenderId);
    APPEND_CONFIG_STRING(o,@"msc-from",_mscFrom);
    APPEND_CONFIG_INTEGER(o,@"priority",_priority);
    APPEND_CONFIG_STRING(o,@"timezone",_timezone);
    APPEND_CONFIG_STRING(o,@"ts",_ts);
    APPEND_CONFIG_DOUBLE(o,@"max-submission-speed",_maxSubmissionSpeed);
    APPEND_CONFIG_INTEGER(o,@"max-attempts",_maxAttempts);
    APPEND_CONFIG_INTEGER(o,@"max-attempts-for-delivery-reports",_maxAttemptsDlr);
    APPEND_CONFIG_STRING(o,@"retry-pattern",_retryPattern);


    APPEND_CONFIG_BOOLEAN(o,@"config-api-access",_apiAccess);
    APPEND_CONFIG_BOOLEAN(o,@"web-access",_webSubmissionAccess);
    APPEND_CONFIG_BOOLEAN(o,@"web-admin-access",_webAdminAccess);
    APPEND_CONFIG_BOOLEAN(o,@"smpp-access",_smppAccess);
    APPEND_CONFIG_BOOLEAN(o,@"emiucp-access",_emiucpAccess);

    
    APPEND_CONFIG_STRING(o,@"categorizer",_categorizer);
    APPEND_CONFIG_STRING(o,@"pre-routing-filter",_preRoutingFilter);
    APPEND_CONFIG_STRING(o,@"pre-billing-filter",_preBillingFilter);
    APPEND_CONFIG_STRING(o,@"routing-engine",_routingEngine);
    APPEND_CONFIG_STRING(o,@"post-routing-filter",_postRoutingFilter);
    APPEND_CONFIG_STRING(o,@"post-billing-filter",_postBillingFilter);
    APPEND_CONFIG_STRING(o,@"delivery-report-filter",_deliveryReportFilter);
    APPEND_CONFIG_STRING(o,@"cdr-writer-plugin",_cdrWriter);
    APPEND_CONFIG_STRING(o,@"storage-engine",_storageEngine);
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
    APPEND_DICT_STRING(o,@"instance",_instance);
    APPEND_DICT_STRING(o,@"delivery-method",_deliveryMethod);
    APPEND_DICT_STRING(o,@"sri-sm-opc",_sriSmOpc);
    APPEND_DICT_STRING(o,@"sri-sm-dpc",_sriSmDpc);
    APPEND_DICT_STRING(o,@"sri-sm-sccp-calling-address",_sriSmSccpCallingAddress);
    APPEND_DICT_STRING(o,@"sri-sm-sccp-called-address-prefix",_sriSmSccpCalledAddressPrefix);
    APPEND_DICT_STRING(o,@"sri-sm-sccp-called-address-replacement",_sriSmSccpCalledAddressReplacement);
    APPEND_DICT_INTEGER(o,@"sri-sm-sccp-called-translation-table",_sriSmSccpCalledTranslationTable);
    APPEND_DICT_STRING(o,@"sri-sm-gsm-map-smsc-address",_sriSmGsmMapSmscAddress);

    APPEND_DICT_STRING(o,@"forward-sm-opc",_forwardSmOpc);
    APPEND_DICT_STRING(o,@"forward-sm-dpc",_forwardSmDpc);
    APPEND_DICT_STRING(o,@"forward-sm-sccp-calling-address",_forwardSmSccpCallingAddress);
    APPEND_DICT_STRING(o,@"forward-sm-sccp-called-address-prefix",_forwardSmSccpCalledAddressPrefix);
    APPEND_DICT_STRING(o,@"forward-sm-sccp-called-address-replacement",_forwardSmSccpCalledAddressReplacement);
    APPEND_DICT_INTEGER(o,@"forward-sm-sccp-called-translation-table",_forwardSmSccpCalledTranslationTable);
    APPEND_DICT_STRING(o,@"forward-sm-gsm-map-smsc-address",_forwardSmGsmMapSmscAddress);

    APPEND_DICT_STRING(o,@"replace-sender-id",_fixedSenderId);
    APPEND_DICT_STRING(o,@"msc-from",_mscFrom);
    APPEND_DICT_INTEGER(o,@"priority",_priority);
    APPEND_DICT_STRING(o,@"timezone",_timezone);
    APPEND_DICT_STRING(o,@"ts",_ts);
    APPEND_DICT_DOUBLE(o,@"max-submission-speed",_maxSubmissionSpeed);
    APPEND_DICT_INTEGER(o,@"max-attempts",_maxAttempts);
    APPEND_DICT_INTEGER(o,@"max-attempts-for-delivery-reports",_maxAttemptsDlr);
    APPEND_DICT_STRING(o,@"retry-pattern",_retryPattern);

    APPEND_DICT_BOOLEAN(o,@"config-api-access",_apiAccess);
    APPEND_DICT_BOOLEAN(o,@"web-access",_webSubmissionAccess);
    APPEND_DICT_BOOLEAN(o,@"web-admin-access",_webAdminAccess);
    APPEND_DICT_BOOLEAN(o,@"smpp-access",_smppAccess);
    APPEND_DICT_BOOLEAN(o,@"emiucp-access",_emiucpAccess);

    APPEND_DICT_STRING(o,@"categorizer",_categorizer);
    APPEND_DICT_STRING(o,@"pre-routing-filter",_preRoutingFilter);
    APPEND_DICT_STRING(o,@"pre-billing-filter",_preBillingFilter);
    APPEND_DICT_STRING(o,@"routing-engine",_routingEngine);
    APPEND_DICT_STRING(o,@"post-routing-filter",_postRoutingFilter);
    APPEND_DICT_STRING(o,@"post-billing-filter",_postBillingFilter);
    APPEND_DICT_STRING(o,@"delivery-report-filter",_deliveryReportFilter);
    APPEND_DICT_STRING(o,@"cdr-writer-plugin",_cdrWriter);
    APPEND_DICT_STRING(o,@"storage-engine",_storageEngine);

    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    SET_DICT_STRING(o,@"instance",_instance);
    SET_DICT_STRING(o,@"delivery-method",_deliveryMethod);
    SET_DICT_STRING(o,@"sri-sm-opc",_sriSmOpc);
    SET_DICT_STRING(o,@"sri-sm-dpc",_sriSmDpc);
    SET_DICT_STRING(o,@"sri-sm-sccp-calling-address",_sriSmSccpCallingAddress);
    SET_DICT_STRING(o,@"sri-sm-sccp-called-address-prefix",_sriSmSccpCalledAddressPrefix);
    SET_DICT_STRING(o,@"sri-sm-sccp-called-address-replacement",_sriSmSccpCalledAddressReplacement);
    SET_DICT_INTEGER(o,@"sri-sm-sccp-called-translation-table",_sriSmSccpCalledTranslationTable);
    SET_DICT_STRING(o,@"sri-sm-gsm-map-smsc-address",_sriSmGsmMapSmscAddress);

    SET_DICT_STRING(o,@"forward-sm-opc",_forwardSmOpc);
    SET_DICT_STRING(o,@"forward-sm-dpc",_forwardSmDpc);
    SET_DICT_STRING(o,@"forward-sm-sccp-calling-address",_forwardSmSccpCallingAddress);
    SET_DICT_STRING(o,@"forward-sm-sccp-called-address-prefix",_forwardSmSccpCalledAddressPrefix);
    SET_DICT_STRING(o,@"forward-sm-sccp-called-address-replacement",_forwardSmSccpCalledAddressReplacement);
    SET_DICT_INTEGER(o,@"forward-sm-sccp-called-translation-table",_forwardSmSccpCalledTranslationTable);
    SET_DICT_STRING(o,@"forward-sm-gsm-map-smsc-address",_forwardSmGsmMapSmscAddress);

    SET_DICT_STRING(o,@"replace-sender-id",_fixedSenderId);
    SET_DICT_STRING(o,@"msc-from",_mscFrom);
    SET_DICT_INTEGER(o,@"priority",_priority);
    SET_DICT_STRING(o,@"timezone",_timezone);
    SET_DICT_STRING(o,@"ts",_ts);
    SET_DICT_DOUBLE(o,@"max-submission-speed",_maxSubmissionSpeed);
    SET_DICT_INTEGER(o,@"max-attempts",_maxAttempts);
    SET_DICT_INTEGER(o,@"max-attempts-for-delivery-reports",_maxAttemptsDlr);
    SET_DICT_STRING(o,@"retry-pattern",_retryPattern);

    SET_DICT_BOOLEAN(o,@"config-api-access",_apiAccess);
    SET_DICT_BOOLEAN(o,@"web-access",_webSubmissionAccess);
    SET_DICT_BOOLEAN(o,@"web-admin-access",_webAdminAccess);
    SET_DICT_BOOLEAN(o,@"smpp-access",_smppAccess);
    SET_DICT_BOOLEAN(o,@"emiucp-access",_emiucpAccess);

    SET_DICT_STRING(o,@"categorizer",_categorizer);
    SET_DICT_STRING(o,@"pre-routing-filter",_preRoutingFilter);
    SET_DICT_STRING(o,@"pre-billing-filter",_preBillingFilter);
    SET_DICT_STRING(o,@"routing-engine",_routingEngine);
    SET_DICT_STRING(o,@"post-routing-filter",_postRoutingFilter);
    SET_DICT_STRING(o,@"post-billing-filter",_postBillingFilter);
    SET_DICT_STRING(o,@"delivery-report-filter",_deliveryReportFilter);
    SET_DICT_STRING(o,@"cdr-writer-plugin",_cdrWriter);
    SET_DICT_STRING(o,@"storage-engine",_storageEngine);
}

- (UMSS7ConfigServiceProfile *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigServiceProfile allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end

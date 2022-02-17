//
//  UMSS7ConfigServiceUserProfile.h
//  ulibss7config
//
//  Created by Andreas Fink on 08.05.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigServiceProfile : UMSS7ConfigObject
{
    NSString *_instance;
    NSString *_deliveryMethod;

    NSString *_sriSmOpc;
    NSString *_sriSmDpc;
    NSString *_sriSmSccpCallingAddress;
    NSString *_sriSmSccpCalledAddressPrefix;
    NSString *_sriSmSccpCalledAddressReplacement;
    NSNumber *_sriSmSccpCalledTranslationTable;
    NSString *_sriSmGsmMapSmscAddress;
    NSString *_forwardSmOpc;
    NSString *_forwardSmDpc;
    NSString *_forwardSmSccpCallingAddress;
    NSString *_forwardSmSccpCalledAddressPrefix;
    NSString *_forwardSmSccpCalledAddressReplacement;
    NSNumber *_forwardSmSccpCalledTranslationTable;
    NSString *_forwardSmGsmMapSmscAddress;
    NSString *_fixedSenderId;
    NSString *_mscFrom;
    NSNumber *_priority;
    NSString *_timezone;
    NSString *_ts;
    NSNumber *_maxSubmissionSpeed;
    NSNumber *_maxAttempts;
    NSNumber *_maxAttemptsDlr;
    NSString *_retryPattern;

    NSNumber *_apiAccess;
    NSNumber *_webSubmissionAccess;
    NSNumber *_webAdminAccess;
    NSNumber *_smppAccess;
    NSNumber *_emiucpAccess;
 
    NSString    *_categorizer;
    NSString    *_preRoutingFilter;
    NSString    *_preBillingFilter;
    NSString    *_routingEngine;
    NSString    *_postRoutingFilter;
    NSString    *_postBillingFilter;
    NSString    *_deliveryReportFilter;
    NSString    *_cdrWriter;
    NSString    *_storageEngine;
}

@property(readwrite,strong,atomic)      NSString *groupProfile;

+ (NSString *)type;
- (NSString *)type;
- (UMSS7ConfigServiceProfile *)initWithConfig:(NSDictionary *)dict;

@end

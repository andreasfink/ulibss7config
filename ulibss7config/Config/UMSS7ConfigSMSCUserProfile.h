//
//  UMSS7ConfigSMSCUserProfile.h
//  ulibss7config
//
//  Created by Andreas Fink on 08.05.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigSMSCUserProfile : UMSS7ConfigObject
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
}

@property(readwrite,strong,atomic)      NSString *groupProfile;

+ (NSString *)type;
- (NSString *)type;
- (UMSS7ConfigSMSCUserProfile *)initWithConfig:(NSDictionary *)dict;

@end

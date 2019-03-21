//
//  UMSS7ConfigMSC.h
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigMSC : UMSS7ConfigObject
{
    NSString *_attachTo;
    NSNumber *_timeout;
    NSString *_number;
    NSString *_smsForwardUrl;
    NSNumber *_answerTranslationType;
    NSString *_imsiPool;
}

@property(readwrite,strong,atomic)   NSString *attachTo;
@property(readwrite,strong,atomic)   NSNumber *timeout;
@property(readwrite,strong,atomic)   NSString *number;
@property(readwrite,strong,atomic)   NSString *smsForwardUrl;
@property(readwrite,strong,atomic)   NSNumber *answerTranslationType;
@property(readwrite,strong,atomic)   NSString *imsiPool;


+ (NSString *)type;
- (NSString *)type;
- (UMSS7ConfigMSC *)initWithConfig:(NSDictionary *)dict;
@end



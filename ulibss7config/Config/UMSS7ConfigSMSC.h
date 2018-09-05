//
//  UMSS7ConfigSMSC.h
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigSMSC : UMSS7ConfigObject
{
    NSString *_attachTo;
    NSNumber *_timeout;
    NSString *_number;
    NSString *_timeoutTraceDirectory;
    NSString *_fullTraceDirectory;

    NSNumber *_smscTranslationType;
    NSNumber *_srismTranslationType;
    NSNumber *_forwardsmTranslationType;

}

@property(readwrite,strong,atomic)   NSString *attachTo;
@property(readwrite,strong,atomic)   NSNumber *timeout;
@property(readwrite,strong,atomic)   NSString *number;
@property(readwrite,strong,atomic)   NSString *timeoutTraceDirectory;
@property(readwrite,strong,atomic)   NSString *fullTraceDirectory;
@property(readwrite,strong,atomic)   NSNumber *smscTranslationType;
@property(readwrite,strong,atomic)   NSNumber *srismTranslationType;
@property(readwrite,strong,atomic)   NSNumber *forwardsmTranslationType;


+ (NSString *)type;
- (NSString *)type;
- (UMSS7ConfigSMSC *)initWithConfig:(NSDictionary *)dict;

@end


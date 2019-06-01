//
//  UMSS7ConfigGSMSCF.h
//  ulibss7config
//
//  Created by Andreas Fink on 19.04.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigGSMSCF : UMSS7ConfigObject
{
    NSString *_attachTo;
    NSNumber *_timeout;
    NSString *_number;
    NSString *_timeoutTraceDirectory;
    NSString *_fullTraceDirectory;
}

@property(readwrite,strong,atomic)   NSString *attachTo;
@property(readwrite,strong,atomic)   NSNumber *timeout;
@property(readwrite,strong,atomic)   NSString *number;
@property(readwrite,strong,atomic)   NSString *timeoutTraceDirectory;
@property(readwrite,strong,atomic)   NSString *fullTraceDirectory;


+ (NSString *)type;
- (NSString *)type;
- (UMSS7ConfigGSMSCF *)initWithConfig:(NSDictionary *)dict;

@end

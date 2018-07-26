//
//  UMSS7ConfigSMSProxy.h
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigSMSProxy : UMSS7ConfigObject
{
    NSString *_number;
    NSString *_sccp;
    NSString *_licenseDirectory;
    NSString *_attachAsHlr;
    NSString *_attachAsMsc;
    NSString *_attachAsSmsc;
    NSString *_namedListsDirectory;
    NSString *_filterDirectory;
    NSString *_filterSriSm;
    NSString *_filterSirSmResp;
    NSString *_filterForwardSm;
    NSString *_filterForwardSmResp;
    NSNumber *_timeout;
    NSNumber *_imsiTimer;
    NSString *_imsiPrefix;
    NSString *_cdrWriter;

}

@property(readwrite,strong,atomic)   NSString *number;
@property(readwrite,strong,atomic)   NSString *sccp;
@property(readwrite,strong,atomic)   NSString *licenseDirectory;
@property(readwrite,strong,atomic)   NSString *attachAsHlr;
@property(readwrite,strong,atomic)   NSString *attachAsMsc;
@property(readwrite,strong,atomic)   NSString *attachAsSmsc;
@property(readwrite,strong,atomic)   NSString *namedListsDirectory;
@property(readwrite,strong,atomic)   NSString *filterDirectory;
@property(readwrite,strong,atomic)   NSString *filterSriSm;
@property(readwrite,strong,atomic)   NSString *filterSirSmResp;
@property(readwrite,strong,atomic)   NSString *filterForwardSm;
@property(readwrite,strong,atomic)   NSString *filterForwardSmResp;
@property(readwrite,strong,atomic)   NSNumber *timeout;
@property(readwrite,strong,atomic)   NSNumber *imsiTimer;
@property(readwrite,strong,atomic)   NSString *imsiPrefix;
@property(readwrite,strong,atomic)   NSString *cdrWriter;



+ (NSString *)type;
- (NSString *)type;

- (UMSS7ConfigSMSProxy *)initWithConfig:(NSDictionary *)dict;
@end


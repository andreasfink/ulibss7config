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
	NSString *_filterMoForwardSmSubmit;
	NSString *_filterMoForwardSmSubmitResp;

    NSNumber *_timeout;
    NSNumber *_imsiTimer;
    NSString *_imsiPrefix;
    NSString *_cdrWriter;

    NSNumber *_smscTranslationType;
    NSNumber *_srismTranslationType;
	NSNumber *_forwardsmTranslationType;
	NSNumber *_moForwardsmSubmitTranslationType;
	NSNumber *_moForwardSmSubmitHlrCheck;
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
@property(readwrite,strong,atomic)   NSString *filterMoForwardSmSubmit;
@property(readwrite,strong,atomic)   NSString *filterMoForwardSmSubmitResp;
@property(readwrite,strong,atomic)   NSNumber *timeout;
@property(readwrite,strong,atomic)   NSNumber *imsiTimer;
@property(readwrite,strong,atomic)   NSString *imsiPrefix;
@property(readwrite,strong,atomic)   NSString *cdrWriter;

@property(readwrite,strong,atomic)   NSNumber *smscTranslationType;
@property(readwrite,strong,atomic)   NSNumber *srismTranslationType;
@property(readwrite,strong,atomic)   NSNumber *forwardsmTranslationType;
@property(readwrite,strong,atomic)   NSNumber *moForwardsmSubmitTranslationType;
@property(readwrite,strong,atomic)   NSNumber *moForwardSmSubmitHlrCheck;

+ (NSString *)type;
- (NSString *)type;

- (UMSS7ConfigSMSProxy *)initWithConfig:(NSDictionary *)dict;
@end


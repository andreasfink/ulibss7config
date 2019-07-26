//
//  UMSS7ConfigM3UAASP.h
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigM3UAASP : UMSS7ConfigObject

{
    NSString *_m3ua_as;
    NSString *_attachTo;
    NSNumber *_reopenTimer1;
    NSNumber *_reopenTimer2;
    NSNumber *_linktestTimer;
    NSNumber *_beatTimer;
    NSNumber *_beatMaxOutstanding;
}

+ (NSString *)type;
- (NSString *)type;
- (UMSS7ConfigM3UAASP *)initWithConfig:(NSDictionary *)dict;

@property(readwrite,strong,atomic)  NSString *m3ua_as;
@property(readwrite,strong,atomic)  NSString *attachTo;
@property(readwrite,strong,atomic)  NSNumber *reopenTimer1;
@property(readwrite,strong,atomic)  NSNumber *reopenTimer2;
@property(readwrite,strong,atomic)  NSNumber *linktestTimer;
@property(readwrite,strong,atomic)  NSNumber *beatTimer;
@property(readwrite,strong,atomic)  NSNumber *beatMaxOutstanding;


@end

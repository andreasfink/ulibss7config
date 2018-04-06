//
//  UMSS7ConfigMTP3FilterEntry.h
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigMTP3FilterEntry : UMSS7ConfigObject
{
    NSString *_filter;
    NSString *_result;
    NSString *_opc;
    NSString *_dpc;
    NSNumber *_si;
}


@property(readwrite,strong,atomic)      NSString *filter;
@property(readwrite,strong,atomic)      NSString *result;
@property(readwrite,strong,atomic)      NSString *opc;
@property(readwrite,strong,atomic)      NSString *dpc;
@property(readwrite,strong,atomic)      NSNumber *si;


+ (NSString *)type;
- (NSString *)type;
- (UMSS7ConfigMTP3FilterEntry *)initWithConfig:(NSDictionary *)dict;

@end

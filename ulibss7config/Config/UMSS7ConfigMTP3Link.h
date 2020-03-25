//
//  UMSS7ConfigMtp3Link.h
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigMTP3LinkSet.h"

@interface UMSS7ConfigMTP3Link : UMSS7ConfigObject
{
    NSString *_mtp3LinkSet;
    NSString *_m2pa;
    NSNumber *_slc;
    NSNumber *_linkTestTime;
    NSNumber *_linkTestMax;
    NSNumber *_reopenTimer1;
    NSNumber *_reopenTimer2;
}

+ (NSString *)type;
- (NSString *)type;
- (UMSS7ConfigMTP3Link *)initWithConfig:(NSDictionary *)dict;

@property(readwrite,strong,atomic)  NSString *mtp3LinkSet;
@property(readwrite,strong,atomic)  NSString *m2pa;
@property(readwrite,strong,atomic)  NSNumber *slc;
@property(readwrite,strong,atomic)  NSNumber *linkTestTime;
@property(readwrite,strong,atomic)  NSNumber *linkTestMax;
@property(readwrite,strong,atomic)  NSNumber *reopenTimer1;
@property(readwrite,strong,atomic)  NSNumber *reopenTimer2;

@end

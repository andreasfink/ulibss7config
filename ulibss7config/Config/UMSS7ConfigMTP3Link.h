//
//  UMSS7ConfigMtp3Link.h
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigMTP3Linkset.h"

@interface UMSS7ConfigMTP3Link : UMSS7ConfigObject
{
    NSString *_mtp3Linkset;
    NSString *_m2pa;
    NSNumber *_slc;
}

+ (NSString *)type;
- (NSString *)type;
- (UMSS7ConfigMTP3Link *)initWithConfig:(NSDictionary *)dict;

@property(readwrite,strong,atomic)  NSString *mtp3Linkset;
@property(readwrite,strong,atomic)  NSString *m2pa;
@property(readwrite,strong,atomic)  NSNumber *slc;

@end

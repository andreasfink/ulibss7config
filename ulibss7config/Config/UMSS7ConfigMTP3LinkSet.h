//
//  UMSS7ConfigMTP3LinkSet.h
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigMTP3LinkSet : UMSS7ConfigObject
{
    NSString *_mtp3;
    NSString *_apc;
    NSString *_opc;
    NSNumber *_speed;
    NSString *_overrideNetworkIndicator;
    NSString *_ttmap_in;
    NSString *_ttmap_out;
}

+ (NSString *)type;
- (NSString *)type;
- (UMSS7ConfigMTP3LinkSet *)initWithConfig:(NSDictionary *)dict;

@property(readwrite,strong,atomic)  NSString *mtp3;
@property(readwrite,strong,atomic)  NSString *apc;
@property(readwrite,strong,atomic)  NSString *opc;
@property(readwrite,strong,atomic)  NSNumber *speed;
@property(readwrite,strong,atomic)  NSString *overrideNetworkIndicator;
@property(readwrite,strong,atomic)  NSString *ttmap_in;
@property(readwrite,strong,atomic)  NSString *ttmap_out;

@end

//
//  UMSS7ConfigM3UAAS.h
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigM3UAAS : UMSS7ConfigObject
{
    NSString *_mtp3;
    NSNumber *_routingKey;
    NSString *_apc;
    NSString *_trafficMode;
    NSString *_overrideNetworkIndicator;
}

+ (NSString *)type;
- (NSString *)type;
- (UMSS7ConfigM3UAAS *)initWithConfig:(NSDictionary *)dict;

@property(readwrite,strong,atomic)  NSString *mtp3;
@property(readwrite,strong,atomic)  NSNumber *routingKey;
@property(readwrite,strong,atomic)  NSString *apc;
@property(readwrite,strong,atomic)  NSString *trafficMode;
@property(readwrite,strong,atomic)  NSNumber *overrideNetworkIndicator;

@end

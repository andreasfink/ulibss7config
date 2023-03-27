//
//  UMSS7ConfigMtp3Route.h
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigMTP3Route : UMSS7ConfigObject
{
    NSString *_mtp3;
    NSString *_dpc;
    NSString *_as;
    NSString *_ls;
    NSNumber *_priority;
    NSNumber *_weight;
    NSNumber *_localPreference;
}

+ (NSString *)type;
- (NSString *)type;
- (UMSS7ConfigMTP3Route *)initWithConfig:(NSDictionary *)dict;

@property(readwrite,strong,atomic)  NSString *mtp3;
@property(readwrite,strong,atomic)  NSString *dpc;
@property(readwrite,strong,atomic)  NSString *as;
@property(readwrite,strong,atomic)  NSString *ls;
@property(readwrite,strong,atomic)  NSNumber *priority;
@property(readwrite,strong,atomic)  NSNumber *weight;
@property(readwrite,strong,atomic)  NSNumber *localPreference;

@end

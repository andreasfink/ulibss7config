//
//  UMSS7ConfigSSCCPDestinationGroupEntry.h
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigSCCPDestinationEntry : UMSS7ConfigObject
{
    NSString *_destination;
    NSString *_nextSccpInstance;
    NSString *_dpc;
    NSString *_applicationServer;
    NSNumber *_cost;
    NSNumber *_weight;
    NSNumber *_subsystem;
    NSNumber *_ntt;
    NSString *_addPrefix;
}

+ (NSString *)type;
- (NSString *)type;
- (UMSS7ConfigSCCPDestinationEntry *)initWithConfig:(NSDictionary *)dict;

@property(readwrite,strong,atomic)  NSString *destination;
@property(readwrite,strong,atomic)  NSString *nextSccpInstance;
@property(readwrite,strong,atomic)  NSString *dpc;
@property(readwrite,strong,atomic)  NSString *applicationServer;
@property(readwrite,strong,atomic)  NSNumber *cost;
@property(readwrite,strong,atomic)  NSNumber *weigth;
@property(readwrite,strong,atomic)  NSNumber *subsystem;
@property(readwrite,strong,atomic)  NSNumber *ntt;
@property(readwrite,strong,atomic)  NSString *addPrefix;

@end

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
    NSNumber *_overrideCalledTT;
    NSNumber *_overrideCallingTT;
    NSString *_addPrefix;
    NSString *_addPostfix;
    NSString *_mtp3Instance;
    NSNumber *_setGti;
    NSNumber *_setNai;
    NSNumber *_setNpi;
    NSNumber *_setEncoding;
    NSNumber *_setNational;
    NSNumber *_removeDigits;
    NSNumber *_limitDigitLength;
    NSNumber *_ansiToItu;
    NSNumber *_ituToAnsi;
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
@property(readwrite,strong,atomic)  NSNumber *overrideCalledTT;
@property(readwrite,strong,atomic)  NSNumber *overrideCallingTT;
@property(readwrite,strong,atomic)  NSString *addPrefix;
@property(readwrite,strong,atomic)  NSString *addPostfix;
@property(readwrite,strong,atomic)  NSString *mtp3Instance;
@property(readwrite,strong,atomic)  NSNumber *setGti;
@property(readwrite,strong,atomic)  NSNumber *setNai;
@property(readwrite,strong,atomic)  NSNumber *setNpi;
@property(readwrite,strong,atomic)  NSNumber *setEncoding;
@property(readwrite,strong,atomic)  NSNumber *setNational;
@property(readwrite,strong,atomic)  NSNumber *removeDigits;
@property(readwrite,strong,atomic)  NSNumber *limitDigitLength;
@property(readwrite,strong,atomic)  NSNumber *ansiToItu;
@property(readwrite,strong,atomic)  NSNumber *ituToAnsi;

@end

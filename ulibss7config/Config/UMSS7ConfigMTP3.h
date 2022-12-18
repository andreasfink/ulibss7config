//
//  UMSS7ConfigMTP3.h
//  estp
//
//  Created by Andreas Fink on 01.02.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import <ulib/ulib.h>
#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigMTP3 : UMSS7ConfigObject
{
    NSString *_variant;
    NSString *_opc;
    NSString *_networkIndicator;
    NSString *_problematicPacketDumper;
    NSString *_routingUpdateLog;
    NSString *_mode; /* either "stp" or "ssp". defaults to "stp" */
    NSString *_statisticDbPool;
    NSString *_statisticDbTable;
    NSString *_statisticDbInstance;
    NSNumber *_statisticDbAutocreate;
}

+ (NSString *)type;
- (NSString *)type;
- (UMSS7ConfigMTP3 *)initWithConfig:(NSDictionary *)dict;

@property(readwrite,strong,atomic)  NSString *variant;
@property(readwrite,strong,atomic)  NSString *opc;
@property(readwrite,strong,atomic)  NSString *networkIndicator;
@property(readwrite,strong,atomic)  NSString *problematicPacketDumper;
@property(readwrite,strong,atomic)  NSString *routingUpdateLog;
@property(readwrite,strong,atomic)  NSString *mode;
@property(readwrite,strong,atomic)  NSString *statisticDbPool;
@property(readwrite,strong,atomic)  NSString *statisticDbTable;
@property(readwrite,strong,atomic)  NSString *statisticDbInstance;
@property(readwrite,strong,atomic)  NSNumber *statisticDbAutocreate;

@end

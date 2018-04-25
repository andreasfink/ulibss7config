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
    NSString *_mode; /* either "stp" or "ssp". defaults to "stp" */
}

+ (NSString *)type;
- (NSString *)type;
- (UMSS7ConfigMTP3 *)initWithConfig:(NSDictionary *)dict;

@property(readwrite,strong,atomic)  NSString *variant;
@property(readwrite,strong,atomic)  NSString *opc;
@property(readwrite,strong,atomic)  NSString *networkIndicator;
@property(readwrite,strong,atomic)  NSString *problematicPacketDumper;

@end

//
//  UMSS7ConfigSCCPFilter.h
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigSCCPFilter : UMSS7ConfigObject
{
    NSString *_filterFileName;
    NSString *_configFileName;
    NSString *_applicationPoint;
}

@property(readwrite,strong,atomic)          NSString *filterFileName;
@property(readwrite,strong,atomic)          NSString *configFileName;
@property(readwrite,strong,atomic)          NSString *applicationPoint;


+ (NSString *)type;
- (NSString *)type;
- (UMSS7ConfigSCCPFilter *)initWithConfig:(NSDictionary *)dict;

@end

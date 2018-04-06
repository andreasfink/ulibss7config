//
//  UMSS7ConfigSMSFilter.h
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigSMSFilter : UMSS7ConfigObject
{
    NSString *_defaultResult;
}

@property(readwrite,strong,atomic)      NSString *defaultResult;

+ (NSString *)type;
- (NSString *)type;
- (UMSS7ConfigSMSFilter *)initWithConfig:(NSDictionary *)dict;

@end

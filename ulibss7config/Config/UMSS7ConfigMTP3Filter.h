//
//  UMSS7ConfigMTP3Filter.h
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigMTP3Filter : UMSS7ConfigObject
{
    NSString *_defaultResult;
    NSString *_plugIn;
}

@property(readwrite,strong,atomic)      NSString *defaultResult;

+ (NSString *)type;
- (NSString *)type;
- (UMSS7ConfigMTP3Filter *)initWithConfig:(NSDictionary *)dict;

@end

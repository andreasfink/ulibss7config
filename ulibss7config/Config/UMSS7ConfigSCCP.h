//
//  UMSS7ConfigSCCP.h
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigSCCP : UMSS7ConfigObject
{
    NSString *_attachTo;
    NSString *_variant;
}

+ (NSString *)type;
- (NSString *)type;
- (UMSS7ConfigSCCP *)initWithConfig:(NSDictionary *)dict;

@property(readwrite,strong,atomic)  NSString *attachTo;
@property(readwrite,strong,atomic)  NSString *variant;

@end

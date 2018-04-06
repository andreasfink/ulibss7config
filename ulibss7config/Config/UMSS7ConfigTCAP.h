//
//  UMSS7ConfigTCAP.h
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigTCAP : UMSS7ConfigObject
{
    NSString *_attachTo;
    NSString *_variant;
    NSNumber *_subsystem;
}

@property(readwrite,strong,atomic)  NSString *attachTo;
@property(readwrite,strong,atomic)  NSString *variant;
@property(readwrite,strong,atomic)  NSNumber *subsystem;


+ (NSString *)type;
- (NSString *)type;

- (UMSS7ConfigTCAP *)initWithConfig:(NSDictionary *)dict;

@end

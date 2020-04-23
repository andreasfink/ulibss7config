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
    NSString *_subsystem;
    NSNumber *_timeout;
    NSString *_number;
    NSString *_range;
}

@property(readwrite,strong,atomic)  NSString *attachTo;
@property(readwrite,strong,atomic)  NSString *variant;
@property(readwrite,strong,atomic)  NSString *subsystem;
@property(readwrite,strong,atomic)  NSNumber *timeout;
@property(readwrite,strong,atomic)  NSString *number;
@property(readwrite,strong,atomic)  NSString *range;



+ (NSString *)type;
- (NSString *)type;

- (UMSS7ConfigTCAP *)initWithConfig:(NSDictionary *)dict;

@end

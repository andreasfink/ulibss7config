//
//  UMSS7ConfigCdrWriter.h
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigCdrWriter : UMSS7ConfigObject
{
}

@property(readwrite,strong,atomic)  NSString *attachTo;


+ (NSString *)type;
- (NSString *)type;

- (UMSS7ConfigCdrWriter *)initWithConfig:(NSDictionary *)dict;

@end


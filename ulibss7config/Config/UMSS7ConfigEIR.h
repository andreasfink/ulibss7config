//
//  UMSS7ConfigEIR.h
//  ulibss7config
//
//  Created by Andreas Fink on 19.04.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import <ulibss7config/ulibss7config.h>

@interface UMSS7ConfigEIR : UMSS7ConfigObject
{
    NSString *_attachTo;
}

@property(readwrite,strong,atomic)  NSString *attachTo;


+ (NSString *)type;
- (NSString *)type;

- (UMSS7ConfigEIR *)initWithConfig:(NSDictionary *)dict;
@end


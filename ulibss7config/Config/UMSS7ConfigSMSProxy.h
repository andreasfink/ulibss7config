//
//  UMSS7ConfigSMSProxy.h
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigSMSProxy : UMSS7ConfigObject
{
    NSString *_attachTo;
}

@property(readwrite,strong,atomic)  NSString *attachTo;


+ (NSString *)type;
- (NSString *)type;

- (UMSS7ConfigSMSProxy *)initWithConfig:(NSDictionary *)dict;
@end


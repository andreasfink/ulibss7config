//
//  UMSS7ConfigSCCPFilterEntry.h
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigSCCPFilterEntry : UMSS7ConfigObject
{
    NSString *_filter;
    NSString *_result;
}


@property(readwrite,strong,atomic)      NSString *filter;
@property(readwrite,strong,atomic)      NSString *result;


+ (NSString *)type;
- (NSString *)type;
- (UMSS7ConfigSCCPFilterEntry *)initWithConfig:(NSDictionary *)dict;

@end


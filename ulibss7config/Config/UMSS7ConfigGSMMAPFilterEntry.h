//
//  UMSS7ConfigGSMMAPFilterEntry.h
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import <ulibss7config/UMSS7ConfigObject.h>

@interface UMSS7ConfigGSMMAPFilterEntry : UMSS7ConfigObject
{
    NSString *_filter;
    NSString *_result;
}


@property(readwrite,strong,atomic)      NSString *filter;
@property(readwrite,strong,atomic)      NSString *result;


+ (NSString *)type;
- (NSString *)type;
- (UMSS7ConfigGSMMAPFilterEntry *)initWithConfig:(NSDictionary *)dict;

@end

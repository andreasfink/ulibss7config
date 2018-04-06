//
//  UMSS7ConfigMtp3Route.h
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigMTP3Route : UMSS7ConfigObject
{
    NSString *_dpc;
    NSString *_as;
    NSString *_ls;
    NSNumber *_priority;

}

+ (NSString *)type;
- (NSString *)type;
- (UMSS7ConfigMTP3Route *)initWithConfig:(NSDictionary *)dict;

@property(readwrite,strong,atomic)  NSString *dpc;
@property(readwrite,strong,atomic)  NSString *as;
@property(readwrite,strong,atomic)  NSString *ls;
@property(readwrite,strong,atomic)  NSNumber *priority;

@end

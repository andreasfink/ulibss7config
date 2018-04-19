//
//  UMSS7ConfigGSMMAP.h
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigGSMMAP : UMSS7ConfigObject
{
    NSString *_attachTo;
    NSString *_address;
    NSNumber *_nai;
    NSNumber *_npi;
    NSString *_operations;
}

@property(readwrite,strong,atomic)  NSString *attachTo;
@property(readwrite,strong,atomic)  NSString *address;
@property(readwrite,strong,atomic)  NSNumber *nai;
@property(readwrite,strong,atomic)  NSNumber *npi;
@property(readwrite,strong,atomic)  NSString *operations;

+ (NSString *)type;
- (NSString *)type;

- (UMSS7ConfigGSMMAP *)initWithConfig:(NSDictionary *)dict;

@end

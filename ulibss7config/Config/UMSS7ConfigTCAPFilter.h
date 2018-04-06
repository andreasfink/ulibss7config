//
//  UMSS7ConfigTCAPFilter.h
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"
@class UMSS7ConfigTCAPFilterEntry;

@interface UMSS7ConfigTCAPFilter : UMSS7ConfigObject
{
    NSNumber *_bypassTranslationType;
    NSString *_defaultResult;
    NSMutableArray<UMSS7ConfigTCAPFilterEntry *> *_entries;
}

@property(readwrite,strong,atomic)  NSNumber *bypassTranslationType;
@property(readwrite,strong,atomic)  NSString *defaultResult;

+ (NSString *)type;
- (NSString *)type;

- (UMSS7ConfigTCAPFilter *)initWithConfig:(NSDictionary *)dict;

@end

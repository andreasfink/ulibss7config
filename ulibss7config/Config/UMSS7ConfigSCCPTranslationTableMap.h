//
//  UMSS7ConfigSCCPTranslationTableMap.h
//  ulibss7config
//
//  Created by Andreas Fink on 21.12.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import <ulibss7config/ulibss7config.h>

@interface UMSS7ConfigSCCPTranslationTableMap : UMSS7ConfigObject
{
    NSNumber *_map[256];
}

+ (NSString *)type;
- (NSString *)type;

- (UMSS7ConfigSCCPTranslationTableMap *)initWithConfig:(NSDictionary *)dict;

@end


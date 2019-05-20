//
//  UMSS7ConfigSS7FilterRuleSet.h
//  ulibss7config
//
//  Created by Andreas Fink on 17.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@class UMSS7ConfigSS7FilterRule;

@interface UMSS7ConfigSS7FilterRuleSet : UMSS7ConfigObject
{
	NSString                 *_file;
    UMSynchronizedArray      *_entries;
}

@property(readwrite,strong,atomic)  NSString *file;

- (UMSS7ConfigSS7FilterRule *)getRuleAtIndex:(NSInteger)idx;
- (void)setRule:(UMSS7ConfigSS7FilterRule *)rule atIndex:(NSInteger)idx;
- (void)insertRule:(UMSS7ConfigSS7FilterRule *)rule  atIndex:(NSInteger)idx;
- (void)removeRuleAtIndex:(NSInteger)idx;
- (NSArray<UMSS7ConfigSS7FilterRule *> *)getAllRules;


@end


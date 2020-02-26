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
    UMSynchronizedArray     *_entries;
    NSDate                  *_createdTimestamp;
    NSDate                  *_modifiedTimestamp;
    NSString                *_status;
}

@property(readwrite,strong,atomic)  NSDate *createdTimestamp;
@property(readwrite,strong,atomic)  NSDate *modifiedTimestamp;
@property(readwrite,strong,atomic)  NSString *status;

- (UMSS7ConfigSS7FilterRule *)getRuleAtIndex:(NSInteger)idx;
- (void)setRule:(UMSS7ConfigSS7FilterRule *)rule atIndex:(NSInteger)idx;
- (void)insertRule:(UMSS7ConfigSS7FilterRule *)rule  atIndex:(NSInteger)idx;
- (void)appendRule:(UMSS7ConfigSS7FilterRule *)rule;
- (void)removeRuleAtIndex:(NSInteger)idx;
- (NSArray<UMSS7ConfigSS7FilterRule *> *)getAllRules;

@end


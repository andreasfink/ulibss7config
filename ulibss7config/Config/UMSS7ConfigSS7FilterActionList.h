//
//  UMSS7ConfigSS7FilterActionList.h
//  ulibss7config
//
//  Created by Andreas Fink on 17.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@class UMSS7ConfigSS7FilterAction;

@interface UMSS7ConfigSS7FilterActionList : UMSS7ConfigObject
{
    UMSynchronizedArray      *_entries;
}

@property(readwrite,strong,atomic)    UMSynchronizedArray      *entries;

@property(readwrite,strong,atomic)    NSDate *createdTimestamp;
@property(readwrite,strong,atomic)    NSDate *modifiedTimestamp;



- (UMSS7ConfigSS7FilterActionList *)initWithConfig:(NSDictionary *)dict;
- (UMSS7ConfigSS7FilterAction *)getActionAtIndex:(NSInteger)idx;
- (void)setAction:(UMSS7ConfigSS7FilterAction *)action atIndex:(NSInteger)idx;
- (void)insertAction:(UMSS7ConfigSS7FilterAction *)action  atIndex:(NSInteger)idx;
- (void)appendAction:(UMSS7ConfigSS7FilterAction *)action;
- (void)removeActionAtIndex:(NSInteger)idx;
- (NSArray<UMSS7ConfigSS7FilterAction *> *)getAllActions;

@end


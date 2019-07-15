//
//  UMSS7FilterRuleSet.h
//  ulibss7config
//
//  Created by Andreas Fink on 15.07.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import <ulib/ulib.h>
#import "UMSS7ConfigFilterRuleSet.h"
@class UMSS7FilterRule;
@class SS7AppDelegate;

@interface UMSS7FilterRuleSet : UMObject
{
    SS7AppDelegate          *_appDelegate;
    UMSS7ConfigFilterRuleSet *_config;
    NSArray<UMSS7FilterRule *> *_entries;
}

@property(readwrite,strong,atomic)  SS7AppDelegate              *appDelegate;
@property(readwrite,strong,atomic)   UMSS7ConfigFilterRuleSet *config;

- (UMSCCP_FilterResult) filterInbound:(UMSCCP_Packet *)packet;

@end

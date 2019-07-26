//
//  UMSS7FilterRuleSet.h
//  ulibss7config
//
//  Created by Andreas Fink on 15.07.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import <ulibsccp/ulibsccp.h>
#import "UMSS7ConfigSS7FilterRuleSet.h"
#import "UMSS7FilterStatus.h"

@class UMSS7FilterRule;
@class SS7AppDelegate;

@interface UMSS7FilterRuleSet : UMObject
{
    SS7AppDelegate                  *_appDelegate;
    UMSS7ConfigSS7FilterRuleSet     *_config;
    NSArray<UMSS7FilterRule *>      *_entries;
    UMSS7FilterStatus               _filterStatus;

}

@property(readwrite,strong,atomic)  SS7AppDelegate              *appDelegate;
@property(readwrite,strong,atomic)  UMSS7ConfigSS7FilterRuleSet *config;
@property(readwrite,assign,atomic)  UMSS7FilterStatus           filterStatus;

- (NSString *)name;

- (UMSS7FilterRuleSet *)initWithConfig:(UMSS7ConfigSS7FilterRuleSet *)cfg
                           appDelegate:(SS7AppDelegate *)appdel;

- (UMSCCP_FilterResult) filterInbound:(UMSCCP_Packet *)packet;

@end

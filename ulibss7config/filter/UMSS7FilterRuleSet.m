//
//  UMSS7FilterRuleSet.m
//  ulibss7config
//
//  Created by Andreas Fink on 15.07.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7FilterRuleSet.h"
#import "UMSS7FilterRule.h"
#import "UMSS7ConfigSS7FilterRuleSet.h"

@implementation UMSS7FilterRuleSet


- (UMSS7FilterRuleSet *)initWithConfig:(UMSS7ConfigSS7FilterRuleSet *)cfg
                           appDelegate:(SS7AppDelegate *)appdel
{
    self = [super init];
    if(self)
    {
        _config = cfg;
        _appDelegate = appdel;
        if([self convertConfig]==NO)
        {
            return NULL;
        }
    }
    return self;
}

- (BOOL)convertConfig /* returns YES for success */
{

    NSMutableArray<UMSS7FilterRule *> *e = [[NSMutableArray<UMSS7FilterRule *> alloc]init];
    for(UMSS7ConfigSS7FilterRule *rule_config in [_config getAllRules])
    {
        UMSS7FilterRule *rule = [[UMSS7FilterRule alloc]initWithConfig:rule_config appDelegate:_appDelegate];
        [e addObject:rule];
    }

    if([_config.status isEqualToString:@"on"])
    {
        _status = UMSS7FilterRuleSet_status_on;
    }
    else if([_config.status isEqualToString:@"off"])
    {
        _status = UMSS7FilterRuleSet_status_off;
    }
    else if([_config.status isEqualToString:@"monitor"])
    {
        _status = UMSS7FilterRuleSet_status_monitor;
    }
    return YES;
}

- (UMSCCP_FilterResult) filterInbound:(UMSCCP_Packet *)packet;
{
    
    UMSCCP_FilterResult result = UMSCCP_FILTER_RESULT_UNMODIFIED;

    for (UMSS7FilterRule *rule in _entries)
    {
        result = result | [rule filterInbound:packet];
        if(result | UMSCCP_FILTER_RESULT_DROP )
        {
            break;
        }
        if(result | UMSCCP_FILTER_RESULT_STATUS )
        {
            break;
        }
        if(result | UMSCCP_FILTER_RESULT_CAN_NOT_DECODE )
        {
            break;
        }
    }
    return result;
}


@end

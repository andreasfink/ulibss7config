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

- (NSString *)name
{
    return _config.name;
}

- (BOOL)convertConfig /* returns YES for success */
{

    NSMutableArray<UMSS7FilterRule *> *e = [[NSMutableArray<UMSS7FilterRule *> alloc]init];
    for(UMSS7ConfigSS7FilterRule *rule_config in [_config getAllRules])
    {
        UMSS7FilterRule *rule = [[UMSS7FilterRule alloc]initWithConfig:rule_config appDelegate:_appDelegate];
        if(rule)
        {
            [e addObject:rule];
        }
    }
    _entries = e;

    if([_config.status isEqualToString:@"on"])
    {
        _filterStatus = UMSS7FilterStatus_on;
    }
    else if([_config.status isEqualToString:@"off"])
    {
        _filterStatus = UMSS7FilterStatus_off;
    }
    else if([_config.status isEqualToString:@"monitor"])
    {
        _filterStatus = UMSS7FilterStatus_monitor;
    }
    else
    {
        _filterStatus = UMSS7FilterStatus_on;
    }
    return YES;
}

- (UMSCCP_FilterResult) filterPacket:(UMSCCP_Packet *)packet
{
    
    UMSCCP_FilterResult result = UMSCCP_FILTER_RESULT_UNMODIFIED;

    int i=0;
    for (UMSS7FilterRule *rule in _entries)
    {
        if(packet.logLevel <= UMLOG_DEBUG)
        {
            [packet.logFeed debugText:[NSString stringWithFormat:@"calling filterPacket on entry Nr %d",i]];
        }
        result = result | [rule filterPacket:packet];
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
        i++;
    }
    return result;
}


@end

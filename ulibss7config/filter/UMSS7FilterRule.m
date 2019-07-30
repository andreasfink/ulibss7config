//
//  UMSS7FilterRule.m
//  ulibss7config
//
//  Created by Andreas Fink on 15.07.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7FilterRule.h"
#import "UMSS7ConfigSS7FilterRule.h"
#import "UMSS7FilterActionList.h"
#import "UMSS7FilterAction.h"
#import "SS7AppDelegate.h"


static UMSCCP_FilterMatchResult InvertFilterMatchResult(UMSCCP_FilterMatchResult r);

static UMSCCP_FilterMatchResult InvertFilterMatchResult(UMSCCP_FilterMatchResult r)
{
    if(r==UMSCCP_FilterMatchResult_does_match)
    {
        return UMSCCP_FilterMatchResult_does_not_match;
    }
    if(r==UMSCCP_FilterMatchResult_does_not_match)
    {
        return UMSCCP_FilterMatchResult_does_match;
    }
    return r;
}

@implementation UMSS7FilterRule


- (UMSS7FilterRule *)initWithConfig:(UMSS7ConfigSS7FilterRule *)cfg
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

    if(_config.inverseMatch)
    {
        _engineInverseMatch = [_config.inverseMatch boolValue];
    }
    else
    {
        _engineInverseMatch = NO;
    }

    if([_config.tags length]>0)
    {
        _tags = [_config.tags componentsSeparatedByString:@";"];
    }
    if([_config.variables length]>0)
    {
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        NSArray *varVals = [_config.tags componentsSeparatedByString:@";"];
        for(NSString *varVal in varVals)
        {
            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];

            NSArray *a1 = [varVal componentsSeparatedByString:@"!="];
            if(a1.count == 2)
            {
                dict[@"var"] = a1[0];
                dict[@"val"] = a1[1];
                dict[@"condition"] = @"!=";
                [arr addObject:dict];
                continue;
            }
            a1 = [varVal componentsSeparatedByString:@"="];
            if(a1.count == 2)
            {
                dict[@"var"] =a1[0];
                dict[@"val"] =a1[1];
                dict[@"condition"] =@"=";
                [arr addObject:dict];
                continue;
            }

            a1 = [varVal componentsSeparatedByString:@">="];
            if(a1.count == 2)
            {
                dict[@"var"] = a1[0];
                dict[@"val"] = a1[1];
                dict[@"condition"] = @">";
                [arr addObject:dict];
                continue;
            }
            a1 = [varVal componentsSeparatedByString:@"<="];
            if(a1.count == 2)
            {
                dict[@"var"] = a1[0];
                dict[@"val"] = a1[1];
                dict[@"condition"] = @"<";
                [arr addObject:dict];
                continue;
            }
            a1 = [varVal componentsSeparatedByString:@">"];
            if(a1.count == 2)
            {
                dict[@"var"] = a1[0];
                dict[@"val"] = a1[1];
                dict[@"condition"] = @">";
                [arr addObject:dict];
                continue;
            }
            a1 = [varVal componentsSeparatedByString:@"<"];
            if(a1.count == 2)
            {
                dict[@"var"] = a1[0];
                dict[@"val"] = a1[1];
                dict[@"condition"] = @"<";
                [arr addObject:dict];
                continue;
            }
        }
        _variableConditions = arr;
    }
    return YES;
}



- (UMSCCP_FilterResult) filterInbound:(UMSCCP_Packet *)packet
{
    UMSCCP_FilterResult fr = UMSCCP_FILTER_RESULT_UNMODIFIED;

    UMSCCP_FilterMatchResult r = UMSCCP_FilterMatchResult_untested;

    if(_tags)
    {
        NSArray *packetTags = [packet.tags allKeys];

        for(NSArray *tag in _tags)
        {
            NSInteger i = [packetTags indexOfObjectIdenticalTo:tag];

            BOOL matches = (i != NSNotFound );
            if(_not_tags)
            {
                matches = !matches;
            }

            if(matches)
            {
                r = UMSCCP_FilterMatchResult_does_match;
            }
            else
            {
                r = UMSCCP_FilterMatchResult_does_not_match;
                return fr; /* we bail out. No more to check */
                break;
            }
        }
    }

    /* if we dont match here, no point checking other rules */
    if(r==UMSCCP_FilterMatchResult_does_not_match)
    {
        return fr;
    }

    if(_variableConditions)
    {
        for(NSDictionary *rule in _variableConditions)
        {
            NSString *var = rule[@"var"];
            NSString *variable_value = packet.vars[var];
            NSString *val = rule[@"val"];
            NSString *condition = rule[@"condition"];
            BOOL matches = NO;
            if([condition isEqualToString:@"!="])
            {
                if(![variable_value isEqualToString:val])
                {
                    matches = YES;
                }
            }
            else if([condition isEqualToString:@"="])
            {
                if([variable_value isEqualToString:val])
                {
                    matches = YES;
                }
            }
            else if([condition isEqualToString:@">="])
            {
                double a = [variable_value doubleValue];
                double b = [val doubleValue];
                if(a >= b)
                {
                    matches = YES;
                }
            }
            else if([condition isEqualToString:@">"])
            {
                double a = [variable_value doubleValue];
                double b = [val doubleValue];
                if(a > b)
                {
                    matches = YES;
                }
            }
            else if([condition isEqualToString:@"<="])
            {
                double a = [variable_value doubleValue];
                double b = [val doubleValue];
                if(a <= b)
                {
                    matches = YES;
                }

            }
            else if([condition isEqualToString:@"<"])
            {
                double a = [variable_value doubleValue];
                double b = [val doubleValue];
                if(a < b)
                {
                    matches = YES;
                }
            }

            if(_not_tags)
            {
                matches = !matches;
            }

            if(matches)
            {
                r = UMSCCP_FilterMatchResult_does_match;
            }
            else
            {
                r = UMSCCP_FilterMatchResult_does_not_match;
                return fr; /* we bail out. No more to check */
                break;
            }
        }
    }


    if(_engine)
    {
        r = [_engine matchesInbound:packet];
        if(_engineInverseMatch)
        {
            r = InvertFilterMatchResult(r);
        }
    }

    if((r == UMSCCP_FilterMatchResult_does_not_match) || (r==UMSCCP_FilterMatchResult_untested))
    {
        return fr;
    }

    /* if we end up here, we have a match */
    if(_filterStatus==UMSS7FilterStatus_off)
    {
        return fr;
    }

    /* if we end up here, we have to take the action */

    NSString *alname = _config.actionList;
    if(alname.length > 0)
    {
        UMSS7FilterActionList *al = _appDelegate.active_action_list_dict[alname];
        if(al)
        {
            UMSynchronizedArray *ale = al.config.entries;
            for(UMSS7FilterAction *fa in ale)
            {
                if((fa.doPass) && (_filterStatus==UMSS7FilterStatus_on))

                {
                    break;
                }
                if((fa.doDrop || fa.doAbort || fa.doReject) &&
                   (_filterStatus==UMSS7FilterStatus_on))
                {
                    fr = fr | UMSCCP_FILTER_RESULT_DROP;
                }
                if((fa.doContinue) &&
                    (_filterStatus==UMSS7FilterStatus_on))
                {
                    return fr;
                }

                if(fa.doLog)
                {
                    UMSS7TraceFile *tf = _appDelegate.traceFiles[fa.traceDestination];
                    if(tf)
                    {
                        [tf logPacket:packet];
                    }
                }
                if((fa.doReroute)  && (_filterStatus==UMSS7FilterStatus_on))
                {
                    fr = fr | UMSCCP_FILTER_RESULT_MODIFIED;
                    if(fa.rerouteDestinationGroup)
                    {
                        packet.rerouteDestinationGroup = fa.rerouteDestinationGroup;
                    }
                    if(fa.reroutePrefix)
                    {
                        packet.outgoingCalledPartyAddress.address = [NSString stringWithFormat:@"%@%@",fa.reroutePrefix,packet.outgoingCalledPartyAddress.address];
                    }
                    if(fa.rerouteAddress)
                    {
                        packet.outgoingCalledPartyAddress.address = fa.rerouteAddress;

                    }
                    if(fa.rerouteTranslationType)
                    {
                        packet.outgoingCalledPartyAddress.tt.tt = [fa.rerouteTranslationType intValue];
                    }
                }
                if(fa.doAddTag)
                {
                    packet.tags[fa.tag]= fa.tag;
                }
                if(fa.doClearTag)
                {
                    [packet.tags removeObjectForKey:fa.tag];
                }
                if((fa.doStats) && (fa.statisticName.length > 0))
                {

                    UMStatistic *stat = _appDelegate.statistics_dict[fa.statisticName];
                    if(stat==NULL)
                    {
                        stat = [[UMStatistic alloc]initWithPath:_appDelegate.statisticsPath name:fa.statisticName];
                        _appDelegate.statistics_dict[fa.statisticName] = stat;
                    }
                    if(fa.statisticKey.length==0)
                    {
                        [stat increaseBy:1];
                    }
                    /* FIXME: we should have different substatistics by a specific key such as
                     called-address, called-address-country, calling-address,calling-address-country

                     also the increase value might vary such as packet size etc.
                     so currently we only support simple statistic without a subkey.
                    */
                }
                if((fa.doSetVar) && (fa.variable) && (fa.value))
                {
                    packet.vars[fa.variable]= fa.value;

                }
                if((fa.doClearVar) && (fa.variable))
                {
                    [packet.vars removeObjectForKey:fa.variable];
                }
            }
        }
    }
    return fr;
}


@end

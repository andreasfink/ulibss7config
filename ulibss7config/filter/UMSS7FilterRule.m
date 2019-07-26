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
    return YES;
}

- (UMSCCP_FilterResult) filterInbound:(UMSCCP_Packet *)packet
{
    UMSCCP_FilterResult fr = UMSCCP_FILTER_RESULT_UNMODIFIED;
    UMSCCP_FilterMatchResult r = [_engine matchesInbound:packet];
    if((r == UMSCCP_FilterMatchResult_does_match) &&
        ((_filterStatus==UMSS7FilterStatus_on) ||
         (_filterStatus==UMSS7FilterStatus_monitor)) )
    {
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
    }
    return fr;
}


@end

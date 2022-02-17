//
//  UMSS7FilterAction.m
//  ulibss7config
//
//  Created by Andreas Fink on 15.07.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7FilterAction.h"
#import "SS7AppDelegate.h"

@implementation UMSS7FilterAction

- (UMSS7FilterAction *)initWithConfig:(UMSS7ConfigSS7FilterAction *)cfg appDelegate:(SS7AppDelegate *)appdel
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
    if([_config.action isEqualToString:@"pass"])
    {
        _doPass=YES;
    }
    else if([_config.action isEqualToString:@"drop"])
    {
        _doDrop=YES;
    }
    else if([_config.action isEqualToString:@"abort"])
    {
        _doAbort=YES;
    }
    else if([_config.action isEqualToString:@"reject"])
    {
        _doReject=YES;
    }
    else if([_config.action isEqualToString:@"error"])
    {
        _doError=YES;
    }
    else if([_config.action isEqualToString:@"continue"])
    {
        _doContinue=YES;
    }
    else if([_config.action isEqualToString:@"log"])
    {
        _doLog=YES;
    }
    else if([_config.action isEqualToString:@"reroute"])
    {
        _doReroute=YES;
    }
    else if([_config.action isEqualToString:@"add-tag"])
    {
        _doAddTag=YES;
    }
    else if([_config.action isEqualToString:@"clear-tag"])
    {
        _doClearTag=YES;
    }
    else if([_config.action isEqualToString:@"set-var"])
    {
        _doSetVar=YES;
    }
    else if([_config.action isEqualToString:@"clear-var"])
    {
        _doClearVar=YES;
    }
    else if([_config.action isEqualToString:@"statistics"])
    {
        _doStats=YES;
    }

    if(_doReroute)
    {
        NSString *sccpName;
        NSString *sccpDestination;

        NSString *rerouteDestination = _config.rerouteDestination;
        if(rerouteDestination.length > 0)
        {
            NSArray *a = [_config.rerouteDestination componentsSeparatedByString:@":"];
            if(a.count>=2)
            {
                sccpName = a[0];
                sccpDestination = a[1];
            }
            if(a.count==1)
            {
                sccpDestination = a[0];
                NSArray *b = [_appDelegate getSCCPNames];
                if(b.count>=1)
                {
                    sccpName = b[0];
                }
            }
            UMLayerSCCP *sccp = [_appDelegate getSCCP:sccpName];
            if(sccp == NULL)
            {
                return NO;
            }
            SccpDestinationGroup *dest = [sccp.gttSelectorRegistry getDestinationGroupByName:sccpDestination];
            if(dest==NULL)
            {
                return NO;
            }
            _rerouteDestinationGroup = dest;
        }
        if(_config.rerouteCalledAddress.length > 0)
        {
            _rerouteAddress = _config.rerouteCalledAddress;
        }
        if(_config.rerouteCalledAddressPrefix.length > 0)
        {
            _reroutePrefix = _config.rerouteCalledAddressPrefix;
        }
        if(_config.reroute_tt!=NULL)
        {
            _rerouteTranslationType = _config.reroute_tt;
        }
    }
    if((_doAddTag) || (_doClearTag))
    {
        _tag = _config.tag;
    }
    if((_doSetVar) || (_doClearVar))
    {
        _variable = _config.variable;
        _value = _config.value;
    }
    if(_doLog)
    {
        _traceDestination = _config.log;
    }
    if(_doStats)
    {
        _statisticName = _config.statisticName;
        _statisticKey = _config.statisticKey;
    }
    return YES;
}

@end

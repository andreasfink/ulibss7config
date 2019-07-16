//
//  UMSS7FilterRule.m
//  ulibss7config
//
//  Created by Andreas Fink on 15.07.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7FilterRule.h"
#import "UMSS7ConfigSS7FilterRule.h"

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
    return YES;
}

- (UMSCCP_FilterResult) filterInbound:(UMSCCP_Packet *)packet
{
    return [_engine filterInbound:packet];
}


@end

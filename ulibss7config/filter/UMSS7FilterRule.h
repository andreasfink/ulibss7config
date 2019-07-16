//
//  UMSS7FilterRule.h
//  ulibss7config
//
//  Created by Andreas Fink on 15.07.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import <ulibsccp/ulibsccp.h>
#import "UMSS7ConfigSS7FilterRule.h"
#import "UMSS7Filter.h"

@class SS7AppDelegate;

@interface UMSS7FilterRule : UMObject
{
    SS7AppDelegate              *_appDelegate;
    UMSS7ConfigSS7FilterRule    *_config;
    UMSS7Filter                 *_engine;
}

@property(readwrite,strong,atomic)  SS7AppDelegate              *appDelegate;
@property(readwrite,strong,atomic)  UMSS7ConfigSS7FilterRule    *config;
@property(readwrite,strong,atomic)  UMSS7Filter                 *engine;


- (UMSS7FilterRule *)initWithConfig:(UMSS7ConfigSS7FilterRule *)cfg
                        appDelegate:(SS7AppDelegate *)appdel;

- (UMSCCP_FilterResult) filterInbound:(UMSCCP_Packet *)packet;

@end

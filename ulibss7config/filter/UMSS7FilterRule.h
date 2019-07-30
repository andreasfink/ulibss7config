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
#import "UMSS7FilterStatus.h"

@class SS7AppDelegate;

@interface UMSS7FilterRule : UMObject
{
    SS7AppDelegate              *_appDelegate;
    UMSS7ConfigSS7FilterRule    *_config;
    UMSS7Filter                 *_engine;
    UMSS7FilterStatus           _filterStatus;
    BOOL                        _engineInverseMatch;

    NSArray                     *_tags;
    BOOL                        _not_tags;

    NSArray                     *_variableConditions;
    BOOL                        _not_variableConditions;

}

@property(readwrite,strong,atomic)  SS7AppDelegate              *appDelegate;
@property(readwrite,strong,atomic)  UMSS7ConfigSS7FilterRule    *config;
@property(readwrite,strong,atomic)  UMSS7Filter                 *engine;
@property(readwrite,assign,atomic)  UMSS7FilterStatus           filterStatus;
@property(readwrite,assign,atomic)  BOOL                        engineInverseMatch;
@property(readwrite,strong,atomic)  NSArray                     *tags;
@property(readwrite,assign,atomic)  BOOL                        not_tags;
@property(readwrite,strong,atomic)  NSArray                     *variableConditions;
@property(readwrite,assign,atomic)  BOOL                        not_variableConditions;


- (UMSS7FilterRule *)initWithConfig:(UMSS7ConfigSS7FilterRule *)cfg
                        appDelegate:(SS7AppDelegate *)appdel;

- (UMSCCP_FilterResult) filterInbound:(UMSCCP_Packet *)packet;

@end

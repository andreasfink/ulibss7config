//
//  UMSS7FilterAction.h
//  ulibss7config
//
//  Created by Andreas Fink on 15.07.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import <ulib/ulib.h>
#import <ulibgt/ulibgt.h>
#import <ulibsccp/ulibsccp.h>

#import "UMSS7ConfigSS7FilterAction.h"

@class     SS7AppDelegate;

@interface UMSS7FilterAction : UMObject
{

    SS7AppDelegate          *_appDelegate;
    UMSS7ConfigSS7FilterAction *_config;
    BOOL    _doPass;
    BOOL    _doDrop;
    BOOL    _doAbort;
    BOOL    _doReject;
    BOOL    _doError;
    BOOL    _doContinue;
    BOOL    _doLog;
    BOOL    _doReroute;
    BOOL    _doAddTag;
    BOOL    _doClearTag;
    BOOL    _doStats;
    BOOL    _doSetVar;
    BOOL    _doClearVar;
    SccpDestinationGroup *_rerouteDestinationGroup;
    NSString *_rerouteAddress;
    NSString *_reroutePrefix;
    NSNumber *_rerouteTranslationType;
    NSString *_tag;
    NSString *_variable;
    NSString *_value;
    NSString *_statisticName;
    NSString *_statisticKey;
    NSString *_traceDestination;
}

@property(readwrite,strong,atomic)  SS7AppDelegate              *appDelegate;
@property(readwrite,strong,atomic)   UMSS7ConfigSS7FilterAction    *config;

@property(readwrite,assign,atomic)   BOOL    doPass;
@property(readwrite,assign,atomic)   BOOL    doDrop;
@property(readwrite,assign,atomic)   BOOL    doAbort;
@property(readwrite,assign,atomic)   BOOL    doReject;
@property(readwrite,assign,atomic)   BOOL    doError;
@property(readwrite,assign,atomic)   BOOL    doContinue;
@property(readwrite,assign,atomic)   BOOL    doLog;
@property(readwrite,assign,atomic)   BOOL    doReroute;
@property(readwrite,assign,atomic)   BOOL    doAddTag;
@property(readwrite,assign,atomic)   BOOL    doClearTag;
@property(readwrite,assign,atomic)   BOOL    doStats;
@property(readwrite,assign,atomic)   BOOL    doSetVar;
@property(readwrite,assign,atomic)   BOOL    doClearVar;

- (UMSS7FilterAction *)initWithConfig:(UMSS7ConfigSS7FilterAction *)cfg
                          appDelegate:(SS7AppDelegate *)appdel;

@end

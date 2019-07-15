//
//  UMSS7FilterRule.h
//  ulibss7config
//
//  Created by Andreas Fink on 15.07.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import <ulib/ulib.h>
#import "UMSS7ConfigFilterRule.h"

@class SS7AppDelegate;

@interface UMSS7FilterRule : UMObject
{
    SS7AppDelegate          *_appDelegate;
    UMSS7ConfigFilterRule *_config;
    UMSS7Filter           *_engine;
}

@property(readwrite,strong,atomic)  SS7AppDelegate          *appDelegate;
@property(readwrite,strong,atomic)  UMSS7ConfigFilterRule   *config;
@property(readwrite,strong,atomic)  UMSS7Filter             *engine;

@end

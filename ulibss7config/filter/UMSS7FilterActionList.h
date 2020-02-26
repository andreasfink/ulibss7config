//
//  UMSS7FilterActionList.h
//  ulibss7config
//
//  Created by Andreas Fink on 15.07.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import <ulib/ulib.h>

#import "UMSS7ConfigSS7FilterActionList.h"

@class SS7AppDelegate;


@interface UMSS7FilterActionList : UMObject
{
    SS7AppDelegate                  *_appDelegate;
    UMSS7ConfigSS7FilterActionList  *_config;
}


@property(readwrite,strong,atomic)  SS7AppDelegate              *appDelegate;
@property(readwrite,strong,atomic)  UMSS7ConfigSS7FilterActionList   *config;


- (UMSS7FilterActionList *)initWithConfig:(UMSS7ConfigSS7FilterActionList *)cfg
                              appDelegate:(SS7AppDelegate *)appdel;
- (NSString *)name;

@end


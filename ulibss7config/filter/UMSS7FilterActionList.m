//
//  UMSS7FilterActionList.m
//  ulibss7config
//
//  Created by Andreas Fink on 15.07.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7FilterActionList.h"
#import "UMSS7ConfigSS7FilterActionList.h"

@implementation UMSS7FilterActionList

- (UMSS7FilterActionList *)initWithConfig:(UMSS7ConfigSS7FilterActionList *)cfg
                              appDelegate:(SS7AppDelegate *)appdel
{
    self = [super init];
    if(self)
    {
        _appDelegate = appdel;
        _config = cfg;
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

- (NSString *)name
{
    return _config.name;
}

@end

//
//  UMSS7App.m
//  ulibss7config
//
//  Created by Andreas Fink on 16.07.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7App.h"
#import "SS7AppDelegate.h"

@implementation UMSS7App

- (UMSS7App *)initWithAppDelegate:(SS7AppDelegate *)appdel
{
    self = [super init];
    if(self)
    {
        _appDelegate = appdel;
        /* do something here */
    }
    return self;
}


- (int)setConfig:(NSDictionary *)dict /* returns 0 on success */
{
    return 0;
}


- (int)load /* returns 0 on success */
{
    return 0;
}

- (int)createInstance /* returns 0 on success */
{
    return 0;
}

- (int)startInstance /* returns 0 on success */
{
    return 0;
}

- (int)stopInstance /* returns 0 on success */
{
    return 0;
}

- (int)unload /* returns 0 on success */
{
    return 0;
}

@end

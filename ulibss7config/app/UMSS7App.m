//
//  UMSS7App.m
//  ulibss7config
//
//  Created by Andreas Fink on 16.07.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7App.h"

@implementation UMSS7App

- (UMSS7App *)initWithConfig:(NSDictionary *)dict
{
    self = [super init];
    if(self)
    {
        if([self setConfig:dict] == NO)
        {
            return NULL;
        }
    }
    return self;
}

- (BOOL)setConfig:(NSDictionary *)dict /* returns YES on Success */
{
    return YES;
}

@end

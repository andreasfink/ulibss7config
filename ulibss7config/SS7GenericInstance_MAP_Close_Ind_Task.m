//
//  SS7GenericInstance_MAP_Close_Ind_Task.m
//
//  Created by Andreas Fink on 07.12.17.
//  Copyright © 2017 Andreas Fink. All rights reserved.
//

#import "SS7GenericInstance_MAP_Close_Ind_Task.h"
#import "SS7GenericInstance.h"

@implementation SS7GenericInstance_MAP_Close_Ind_Task


- (SS7GenericInstance_MAP_Close_Ind_Task *)initWithInstance:(SS7GenericInstance *)inst
                                          userIdentifier:(UMGSMMAP_UserIdentifier *)userIdentifier
                                                 options:(NSDictionary *)options
{
    self = [super initWithName:[[self class]description]
                      receiver:inst
                        sender:NULL];
    if(self)
    {
        _inst = inst;
        _userIdentifier = userIdentifier;
        _options = options;
    }
    return self;
}

- (void)main
{
    [_inst executeMAP_Close_Ind:_userIdentifier
                   options:_options];
}

@end

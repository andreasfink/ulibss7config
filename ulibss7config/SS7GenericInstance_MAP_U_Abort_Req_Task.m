//
//  SS7GenericInstance_MAP_U_Abort_Req_Task.m
//
//  Created by Andreas Fink on 07.12.17.
//  Copyright © 2017 Andreas Fink. All rights reserved.
//
#if 0
#import "SS7GenericInstance_MAP_U_Abort_Req_Task.h"
#import "SS7GenericInstance.h"

@implementation SS7GenericInstance_MAP_U_Abort_Req_Task


- (SS7GenericInstance_MAP_U_Abort_Req_Task *)initWithInstance:(SS7GenericInstance *)inst
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
    @autoreleasepool
    {
        [_inst executeMAP_U_Abort_Req:_userIdentifier
                              options:_options];
    }
}

@end
#endif

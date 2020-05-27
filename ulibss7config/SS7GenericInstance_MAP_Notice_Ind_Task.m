//
//  SS7GenericInstance_MAP_Notice_Ind_Task.m
//
//  Created by Andreas Fink on 07.12.17.
//  Copyright © 2017 Andreas Fink. All rights reserved.
//

#import "SS7GenericInstance_MAP_Notice_Ind_Task.h"
#import "SS7GenericInstance.h"

@implementation SS7GenericInstance_MAP_Notice_Ind_Task


- (SS7GenericInstance_MAP_Notice_Ind_Task *)initWithInstance:(SS7GenericInstance *)inst
                                           userIdentifier:(UMGSMMAP_UserIdentifier *)userIdentifier
                                              transaction:(NSString *)tcapLocalTransactionId
                                                   reason:(SCCP_ReturnCause)reason
                                                  options:(NSDictionary *)options
{
    self = [super initWithName:[[self class]description]
                      receiver:inst
                        sender:NULL];
    if(self)
    {
        _inst = inst;
        _userIdentifier = userIdentifier;
        _tcapLocalTransactionId = tcapLocalTransactionId;
        _reason = reason;
        _options = options;
    }
    return self;
}
-(void)main
{
    @autoreleasepool
    {
        [_inst executeMAP_Notice_Ind:_userIdentifier
              tcapTransactionId:_tcapLocalTransactionId
                         reason:_reason
                        options:_options];
    }
}

@end

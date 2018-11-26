//
//  SS7GenericInstance_MAP_Invoke_Ind_Task.m
//
//  Created by Andreas Fink on 06.12.17.
//  Copyright © 2017 Andreas Fink. All rights reserved.
//

#import "SS7GenericInstance_MAP_Invoke_Ind_Task.h"
#import "SS7GenericInstance.h"

@implementation SS7GenericInstance_MAP_Invoke_Ind_Task


- (SS7GenericInstance_MAP_Invoke_Ind_Task *)initWithInstance:(SS7GenericInstance *)inst
                                                    param:(UMASN1Object *)param
                                                   userId:(UMGSMMAP_UserIdentifier *)userIdentifier
                                                   dialog:(UMGSMMAP_DialogIdentifier *)dialogId
                                              transaction:(NSString *)transactionId
                                                   opCode:(UMLayerGSMMAP_OpCode *)opcode
                                                 invokeId:(int64_t)invokeId
                                                 linkedId:(int64_t)linkedId
                                                     last:(BOOL)last
                                                  options:(NSDictionary *)options
{
    self = [super initWithName:[[self class]description]
                      receiver:inst
                        sender:NULL];
    if(self)
    {
        _inst = inst;
        _param = param;
        _userIdentifier = userIdentifier;
        _dialogId = dialogId;
        _transactionId = transactionId;
        _opcode = opcode;
        _invokeId = invokeId;
        _linkedId = linkedId;
        _last = last;
        _options = options;
    }
    return self;
}

-(void)main
{
    [_inst executeMAP_Invoke_Ind:_param
                     userId:_userIdentifier
                     dialog:_dialogId
                transaction:_transactionId
                     opCode:_opcode
                   invokeId:_invokeId
                   linkedId:_linkedId
                       last:_last
                    options:_options];
}
@end

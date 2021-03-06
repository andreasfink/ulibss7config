//
//  GenericInstance_MAP_ReturnResult_Resp_Task.m
//
//  Created by Andreas Fink on 07.12.17.
//  Copyright © 2017 Andreas Fink. All rights reserved.
//

#import "SS7GenericInstance_MAP_ReturnResult_Resp_Task.h"
#import "SS7GenericInstance.h"

@implementation SS7GenericInstance_MAP_ReturnResult_Resp_Task


- (SS7GenericInstance_MAP_ReturnResult_Resp_Task *)initWithInstance:(SS7GenericInstance *)inst
                                                           param:(UMASN1Object *)param
                                                          userId:(UMGSMMAP_UserIdentifier *)userIdentifier
                                                          dialog:(UMGSMMAP_DialogIdentifier *)dialogId
                                                     transaction:(NSString *)transactionId
                                                          opCode:(UMLayerGSMMAP_OpCode *)opcode
                                                        invokeId:(int64_t)invokeId
                                                        linkedId:(int64_t)linkedId
                                                            last:(BOOL)xlast
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
        _last = xlast;
        _options = options;
    }
    return self;
}

-(void)main
{
    @autoreleasepool
    {
        [_inst executeMAP_ReturnResult_Resp:_param
                                userId:_userIdentifier
                                dialog:_dialogId
                           transaction:_transactionId
                                opCode:_opcode
                              invokeId:_invokeId
                              linkedId:_linkedId
                                  last:_last
                               options:_options];
    }
}
@end

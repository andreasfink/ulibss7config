//
//  SS7AppTransportSession.m
//  ulibss7config
//
//  Created by Andreas Fink on 20.11.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "SS7AppTransportSession.h"

@implementation SS7AppTransportSession


- (void)umtransportOpenIndication:(UMTransportOpen *)pdu
                    remoteAddress:(SccpAddress *)address
{

}

- (void)umtransportCloseConfirmation:(UMTransportCloseAccept *)pdu
                            invokeId:(int64_t)invokeId
{

}

- (void)umtransportCloseIndication:(UMTransportClose *)pdu
{

}

- (void)umtransportOpenConfirmation:(UMTransportOpenAccept *)pdu
                           invokeId:(int64_t)invokeId
{

}

- (void)umtransportTransportConfirmation:(UMTransportResponse *)pdu
                                invokeId:(int64_t)invokeId
{

}

- (void)umtransportTransportIndication:(UMTransportRequest *)pdu
                              invokeId:(int64_t)invokeId
{

}

@end

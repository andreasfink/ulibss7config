//
//  SS7AppTransportSession.h
//  ulibss7config
//
//  Created by Andreas Fink on 20.11.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "SS7GenericSession.h"
#import <ulibsccp/ulibsccp.h>
#import <ulibtransport/ulibtransport.h>

@interface SS7AppTransportSession : SS7GenericSession
{
    NSString *_sessionId;
    UMTCAP_UserDialogIdentifier *_tcapUserId;
}
@property(readwrite,strong,atomic)      NSString *sessionId;
@property(readwrite,strong,atomic)      UMTCAP_UserDialogIdentifier *tcapUserId;


- (void)umtransportOpenIndication:(UMTransportOpen *)pdu
                    remoteAddress:(SccpAddress *)address;

- (void)umtransportCloseConfirmation:(UMTransportCloseAccept *)pdu
                            invokeId:(int64_t)invokeId;

- (void)umtransportCloseIndication:(UMTransportClose *)pdu;



- (void)umtransportOpenConfirmation:(UMTransportOpenAccept *)pdu
                           invokeId:(int64_t)invokeId;

- (void)umtransportTransportConfirmation:(UMTransportResponse *)pdu
                                invokeId:(int64_t)invokeId;

- (void)umtransportTransportIndication:(UMTransportRequest *)pdu
                              invokeId:(int64_t)invokeId;



@end

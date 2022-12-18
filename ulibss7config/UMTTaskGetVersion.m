//
//  UMTTaskGetVersion.m
//  ulibss7config
//
//  Created by Andreas Fink on 26.06.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMTTaskGetVersion.h"
#import "UMSS7ConfigObject.h"

#import "SS7AppDelegate.h"

@implementation UMTTaskGetVersion
 
 

- (void)executeWhenOpen
{
    NSLog(@"getversion %@",_remoteAddr.stringValueE164);

    UMTransportMessage *msg = [[UMTransportMessage alloc]init];
    msg.request = [[UMTransportRequest alloc]init];
    msg.request.requestOperationCode = UMTransportCMD_GetVersion;
    [_transportService umtransportTransportRequest:msg
                                          dialogId:_dialogId
                                          invokeId:&_invokeId];
    [_appDelegate addPendingUMTTask:self
                             dialog:_dialogId
                           invokeId:_invokeId];
}

- (void)processResponse:(UMTransportResponse *)resp
{
    NSLog(@"getversion response: %@",resp.responsePayload);
    [_req setResponsePlainText:@"success"];
    [_req resumePendingRequest];
}

@end

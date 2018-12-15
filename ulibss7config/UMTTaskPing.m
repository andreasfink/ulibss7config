//
//  UMTTaskPing.m
//  ulibss7config
//
//  Created by Andreas Fink on 25.06.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMTTaskPing.h"
#import "SS7AppDelegate.h"

@implementation UMTTaskPing


- (void)executeWhenOpen
{
    NSLog(@"pinging %@",_remoteAddr.stringValueE164);
    const char pingText[] = "hello world\n";
    NSData *pingData = [NSData dataWithBytes:&pingText[0] length:sizeof(pingText)];
    UMTransportMessage *msg = [[UMTransportMessage alloc]init];
    msg.request = [[UMTransportRequest alloc]init];
    msg.request.requestOperationCode = UMTransportCMD_Ping;
    msg.request.requestPayload = pingData;
    [_transportService umtransportTransportRequest:msg
                                          dialogId:_dialogId
                                          invokeId:&_invokeId];
    [_appDelegate addPendingUMTTask:self
                             dialog:_dialogId
                           invokeId:_invokeId];
}

- (void)processResponse:(UMTransportResponse *)resp
{
    NSLog(@"ping response: %@",resp.responsePayload);
    [_req setResponsePlainText:@"success"];
    [_req resumePendingRequest];
}
@end

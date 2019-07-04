//
//  UMSS7TraceFile.h
//  ulibss7config
//
//  Created by Andreas Fink on 19.06.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import <ulibpcap/ulibpcap.h>
#import <ulibgsmmap/ulibgsmmap.h>

#import "UMSS7ConfigSS7FilterTraceFile.h"

@interface UMSS7TraceFile : UMObject
{
	UMSS7ConfigSS7FilterTraceFile *_config;
	UMPCAPFile *_pcap;
}

@property(readwrite,strong,atomic)	UMSS7ConfigSS7FilterTraceFile *config;

- (void)logPacket:(UMSCCP_Packet *)packet;
- (UMSS7TraceFile *)initWithSS7Config:(UMSS7ConfigSS7FilterTraceFile *)config;

- (void)open;
- (void)close;
- (void)rotate;


@end


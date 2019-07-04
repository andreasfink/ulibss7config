//
//  UMSS7TraceFile.m
//  ulibss7config
//
//  Created by Andreas Fink on 19.06.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7TraceFile.h"

@implementation UMSS7TraceFile

- (UMSS7TraceFile *)initWithSS7Config:(UMSS7ConfigSS7FilterTraceFile *)config
{
	self = [super init];
	if(self)
	{
		_config = [config copy];
	}
	return self;
}

- (void)logPacket:(UMSCCP_Packet *)packet
{
}

- (void)open
{
}
- (void)close
{
}
- (void)rotate
{
}


@end


//
//  UMSS7TraceFile.h
//  ulibss7config
//
//  Created by Andreas Fink on 19.06.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import <ulibpcap/ulibpcap.h>


@interface UMSS7TraceFile : UMObject
{
	UMPCAPFile *_pcap;
}
@end


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

    NSString *_containingDirectory;
    NSString *_relativeFilename;
    NSString *_fullFilename;
    int         _maxRotations;
    int         _maxMinutes;
    int         _maxPackets;
    int         _currentPackets;
    NSDate      *_createdTime;
    NSDate      *_lastPacketTime;
    NSString *_fullFilenameNoExtenion;
    NSString *_fileExtension;
    UMMutex *_lock;
    BOOL        _enabled;
    BOOL        _isOpen;
    BOOL        _isDirty;
}

@property(readwrite,strong,atomic)	UMSS7ConfigSS7FilterTraceFile *config;

- (void)logPacket:(UMSCCP_Packet *)packet;
- (UMSS7TraceFile *)initWithSS7Config:(UMSS7ConfigSS7FilterTraceFile *)config defaultPath:(NSString *)path;

- (void)open;
- (void)close;
- (void)rotate;

- (void)enable;
- (void)disable;
- (void)action:(NSString *)action;
- (void)writeConfigToDisk;
- (void)deleteConfigOnDisk;

@end


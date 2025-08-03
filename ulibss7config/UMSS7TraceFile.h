//
//  UMSS7TraceFile.h
//  ulibss7config
//
//  Created by Andreas Fink on 19.06.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import <ulibpcap/ulibpcap.h>
#import <ulibgsmmap/ulibgsmmap.h>

#import <ulibss7config/UMSS7ConfigSS7TraceFile.h>

@interface UMSS7TraceFile : UMObject<UMSCCP_TracefileProtocol>
{
	UMSS7ConfigSS7TraceFile *_config;
	UMPCAPFile              *_pcap;

    NSString        *_containingDirectory;
    NSString        *_relativeFilename;
    NSString        *_fullFilename;
    int             _maxRotations;
    int             _maxMinutes;
    int             _maxPackets;
    int             _currentPackets;
    NSDate          *_createdTime;
    NSDate          *_lastPacketTime;
    NSString        *_fullFilenameNoExtenion;
    NSString        *_fileExtension;
    UMMutex         *_lock;
    BOOL            _enabled;
    BOOL            _isOpen;
    BOOL            _isDirty;
    BOOL            _isPcap;
    BOOL            _isHex;
    //NSFileHandle    *_fh;
    FILE            *_fptr;
}

@property(readwrite,strong,atomic)	UMSS7ConfigSS7TraceFile *config;

- (void)traceSentPdu:(NSData *)mtp3pdu          options:(NSDictionary *)dict;
- (void)traceReceivedPdu:(NSData *)mtp3pdu      options:(NSDictionary *)dict;
- (void)traceDroppedPdu:(NSData *)mtp3pdu       options:(NSDictionary *)dict;
- (void)traceUnroutablePdu:(NSData *)mtp3pdu    options:(NSDictionary *)dict;
- (void)traceProblematicPdu:(NSData *)mtp3pdu   options:(NSDictionary *)dict;

- (UMSS7TraceFile *)initWithSS7Config:(UMSS7ConfigSS7TraceFile *)config defaultPath:(NSString *)path;
- (void)open;
- (void)close;
- (void)rotate;
- (void)enable;
- (void)disable;
- (void)action:(NSString *)action;
- (void)writeConfigToDisk;
- (void)deleteConfigOnDisk;

@end


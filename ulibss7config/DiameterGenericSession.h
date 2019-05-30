//
//  DiameterGenericSession.h
//  ulibss7config
//
//  Created by Andreas Fink on 29.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import <ulibdiameter/ulibdiameter.h>
#import "OutputFormat.h"
#import "WebMacros.h"

@class UMPCAPFile;
@class DiameterGenericInstance;

@interface DiameterGenericSession : UMLayerTask
{
    NSString                *_sessionName;
    NSString                *_userIdentifier;
    uint32_t                _endToEndIdentifier;
    BOOL                    _hasEnded;
    UMDiameterPacket        *_query;
    uint32_t                _commandCode;
    DiameterGenericInstance *_gInstance;
    NSString                *_localRealm;
    NSString                *_remoteRealm;
    NSString                *_localAddress;
    NSString                *_remoteAddress;
    UMHTTPRequest           *_req;
    NSDate                  *_startTime;
    UMAtomicDate            *_lastActiveTime;
    NSTimeInterval          _timeoutInSeconds;

    NSMutableDictionary         *_options;
    NSMutableArray              *_packets_sent;
    NSMutableArray              *_packets_received;
    UMPCAPFile                  *_pcap;
    BOOL                        _doEnd;
    BOOL                        _nowait;
    BOOL                        _undefinedSession;
    NSDictionary                *_incomingOptions;
    BOOL                        _outgoing;
    BOOL                        _incoming;
    OutputFormat                _outputFormat;
    UMLogLevel                  _logLevel;
    UMHistoryLog            *_historyLog;
    UMMutex                 *_operationMutex;
}

@property(readwrite,strong,atomic)  NSString                *sessionName;
@property(readwrite,strong,atomic)  NSString                *userIdentifier;
@property(readwrite,assign,atomic)  uint32_t                endToEndIdentifier;
@property(readwrite,assign,atomic)  BOOL                    hasEnded;
@property(readwrite,strong,atomic)  UMDiameterPacket        *query;
@property(readwrite,assign,atomic)  uint32_t                commandCode;

@property(readwrite,strong,atomic)    DiameterGenericInstance *gInstance;

@property(readwrite,strong,atomic)    NSString                *localRealm;
@property(readwrite,strong,atomic)    NSString                *remoteRealm;
@property(readwrite,strong,atomic)    NSString                *localAddress;
@property(readwrite,strong,atomic)    NSString                *remoteAddress;
@property(readwrite,strong,atomic)    UMHTTPRequest           *req;
@property(readwrite,strong,atomic)    NSDate                  *startTime;
@property(readwrite,strong,atomic)    UMAtomicDate            *lastActiveTime;
@property(readwrite,assign,atomic)    NSTimeInterval          timeoutInSeconds;

@property(readwrite,strong,atomic)    NSMutableDictionary         *options;
@property(readwrite,strong,atomic)    NSMutableArray              *packets_sent;
@property(readwrite,strong,atomic)    NSMutableArray              *packets_received;
@property(readwrite,strong,atomic)    UMPCAPFile                  *pcap;
@property(readwrite,assign,atomic)    BOOL                        doEnd;
@property(readwrite,assign,atomic)    BOOL                        nowait;
@property(readwrite,assign,atomic)    BOOL                        undefinedSession;
@property(readwrite,strong,atomic)    NSDictionary                *incomingOptions;
@property(readwrite,assign,atomic)    BOOL                        outgoing;
@property(readwrite,assign,atomic)    BOOL                        incoming;
@property(readwrite,assign,atomic)    OutputFormat                outputFormat;
@property(readwrite,assign,atomic)    UMLogLevel                logLevel;

@property(readwrite,strong,atomic)      UMHistoryLog            *historyLog;

//--------------------------------------------------------------------------------------------


-(DiameterGenericSession *)initWithInstance:(DiameterGenericInstance *)inst;

-(DiameterGenericSession *)initWithHttpReq:(UMHTTPRequest *)xreq
                                  instance:(DiameterGenericInstance *)inst;
-(DiameterGenericSession *)setHttpRequest:(UMHTTPRequest *)xreq
                                 instance:(DiameterGenericInstance *)inst;

- (void)logWebSession;

+ (void)webFormStart:(NSMutableString *)s title:(NSString *)t;
+ (void)webFormEnd:(NSMutableString *)s;

- (NSString *)webTitle;
- (NSString *)webForm;

+ (void)webDiameterTitle:(NSMutableString *)s;
+ (void)webDiameterOptions:(NSMutableString *)s;

- (void)webApplicationParameters:(NSMutableString *)s defaultApplicationId:(uint32_t)dai comment:(NSString *)comment;
- (void)setApplicationId:(UMDiameterPacket *)pkt  default:(UMDiameterApplicationId) def;

- (void)webDiameterParameters:(NSMutableString *)s;

+ (void)webVariousTitle:(NSMutableString *)s;
+ (void)webVarioisOptions:(NSMutableString *)s;
- (void)webException:(NSException *)e;

- (void)touch;
- (void)timeout; /* gets called when timeouts occur */
- (BOOL)isTimedOut;
- (void)submit;

@end




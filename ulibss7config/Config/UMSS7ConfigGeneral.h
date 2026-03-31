//
//  UMSS7ConfigGeneral.h
//  estp
//
//  Created by Andreas Fink on 09.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import <ulibss7config/UMSS7ConfigObject.h>

@interface UMSS7ConfigGeneral : UMSS7ConfigObject
{
    NSString *_hostname;
    NSString *_logDirectory;
    NSNumber *_logRotations;
    NSString *_configStore;
    NSNumber *_queueHardLimit;
    NSString *_transactionIdRange;
    NSNumber *_sendSctpAborts;
    NSString *_filterEngineDirectory;
    NSString *_zmqSocket;
    NSString *_gui;
    NSString *_ss7TraceFileDirectory;
    NSArray<NSString *>*_webAllow;
    NSArray<NSString *>*_webDeny;

}

+ (NSString *)groupName;
- (NSString *)groupName;
- (UMSS7ConfigGeneral *)initWithConfig:(NSDictionary *)dict;

@property(readwrite,strong,atomic)  NSString *hostname;
@property(readwrite,strong,atomic)  NSString *logDirectory;
@property(readwrite,strong,atomic)  NSNumber *logRotations;
@property(readwrite,strong,atomic)  NSString *configStore;
@property(readwrite,strong,atomic)  NSNumber *queueHardLimit;
@property(readwrite,strong,atomic)  NSString *transactionIdRange;
@property(readwrite,strong,atomic)  NSNumber *sendSctpAborts;
@property(readwrite,strong,atomic)  NSString *filterEngineDirectory;
@property(readwrite,strong,atomic)  NSString *zmqSocket;
@property(readwrite,strong,atomic)  NSString *gui;
@property(readwrite,strong,atomic)  NSString *ss7TraceFileDirectory;
@property(readwrite,strong,atomic)  NSArray<NSString *>*webAllow;
@property(readwrite,strong,atomic)  NSArray<NSString *>*webDeny;

@end

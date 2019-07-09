//
//  UMDiameterGeneratorCMD.h
//  diameter-web-gen
//
//  Created by Andreas Fink on 09.07.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//


#import <ulib/ulib.h>

@class UMDiameterGeneratorAVP;
@interface UMDiameterGeneratorCMD : UMObject
{
    NSString *_commandName;
    NSString *_objectName;
    NSString *_webName;
    NSInteger _commandNumber;
    NSInteger _applicationId;
    BOOL     _rbit;
    BOOL     _pbit;
    BOOL     _ebit;
    BOOL     _tbit;
    NSArray<UMDiameterGeneratorAVP *> *_avps;
}

@property(readwrite,strong,atomic)  NSString *commandName;
@property(readwrite,assign,atomic)  NSInteger commandNumber;
@property(readwrite,assign,atomic)  NSInteger applicationId;
@property(readwrite,assign,atomic)  BOOL     rbit;
@property(readwrite,assign,atomic)  BOOL     pbit;
@property(readwrite,assign,atomic)  BOOL     ebit;
@property(readwrite,assign,atomic)  BOOL     tbit;
@property(readwrite,strong,atomic)  NSArray<UMDiameterGeneratorAVP *>  *avps;

- (UMDiameterGeneratorCMD *)initWithString:(NSString *)s;
- (UMDiameterGeneratorCMD *)initWithString:(NSString *)s error:(NSError **)e;
- (BOOL)parseString:(NSString *)s error:(NSError **)eptr;
- (BOOL)parseFirstLine:(NSString *)s error:(NSError **)eptr; /* returns YES on success */

- (NSString *)headerFileWithPrefix:(NSString *)prefix
                         avpPrefix:(NSString *)avpPrefix
                              user:(NSString *)user
                              date:(NSString *)date;

- (NSString *)methodFileWithPrefix:(NSString *)prefix
                         avpPrefix:(NSString *)avpPrefix
                              user:(NSString *)user
                              date:(NSString *)date;
@end


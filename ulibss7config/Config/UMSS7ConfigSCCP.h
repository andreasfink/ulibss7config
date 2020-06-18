//
//  UMSS7ConfigSCCP.h
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigSCCP : UMSS7ConfigObject
{
    NSString *_attachTo;
    NSString *_variant;
    NSString *_mode;
    NSArray<NSString *> *_next_pc;
    NSString *_next_pc1;
    NSString *_next_pc2;
    NSNumber *_ntt;
    NSArray<NSString *> *_gtFiles;
    NSString *_problematicPacketsTraceFile;
    NSString *_unrouteablePacketsTraceFile;
    NSNumber *_routeErrorsBackToOriginatingPointCode;
    NSString *_statisticDbPool;
    NSString *_statisticDbTable;
    NSString *_statisticDbInstance;
    NSNumber *_statisticDbAutocreate;
    
    NSNumber *_automaticAnsiItuConversion;
    NSNumber *_ansi_tt_e164;
    NSNumber *_ansi_tt_e212;
}

+ (NSString *)type;
- (NSString *)type;
- (UMSS7ConfigSCCP *)initWithConfig:(NSDictionary *)dict;

@property(readwrite,strong,atomic)  NSString *attachTo;
@property(readwrite,strong,atomic)  NSString *variant;
@property(readwrite,strong,atomic)  NSString *mode;
@property(readwrite,strong,atomic)  NSArray<NSString *> *next_pc;
@property(readwrite,strong,atomic)  NSString *next_pc1;
@property(readwrite,strong,atomic)  NSString *next_pc2;
@property(readwrite,strong,atomic)  NSNumber *ntt;
@property(readwrite,strong,atomic)  NSArray<NSString *> *gtFiles;
@property(readwrite,strong,atomic)  NSString *problematicPacketsTraceFile;
@property(readwrite,strong,atomic)  NSString *unrouteablePacketsTraceFile;
@property(readwrite,strong,atomic)  NSNumber *routeErrorsBackToSource;
@property(readwrite,strong,atomic)  NSString *statisticDbPool;
@property(readwrite,strong,atomic)  NSString *statisticDbTable;
@property(readwrite,strong,atomic)  NSString *statisticDbInstance;
@property(readwrite,strong,atomic)  NSNumber *statisticDbAutocreate;
@property(readwrite,strong,atomic)  NSNumber *automaticAnsiItuConversion;
@property(readwrite,strong,atomic)  NSNumber *ansi_tt_e164;
@property(readwrite,strong,atomic)  NSNumber *ansi_tt_e212;

@end

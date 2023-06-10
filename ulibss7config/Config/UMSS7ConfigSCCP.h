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
    NSNumber *_overrideCallingTT;
    NSNumber *_overrideCalledTT;
    
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
    NSString *_screeningSccpPluginName;
    NSString *_screeningSccpPluginConfigFile;
    NSString *_screeningSccpPluginTraceFile;
    NSNumber *_screeningSccpPluginTraceLevel;
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
@property(readwrite,strong,atomic)  NSNumber *overrideCallingTT;
@property(readwrite,strong,atomic)  NSNumber *overrideCalledTT;
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
@property(readwrite,strong,atomic)  NSString *screeningSccpPluginName;
@property(readwrite,strong,atomic)  NSString *screeningSccpPluginConfigFile;
@property(readwrite,strong,atomic)  NSString *screeningSccpPluginTraceFile;
@property(readwrite,strong,atomic)  NSNumber *screeningSccpPluginTraceLevel;

@end

//
//  UMSS7Filter.h
//  estp
//
//  Created by Andreas Fink on 20.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import <ulibgsmmap/ulibgsmmap.h>
#import <ulibcamel/ulibcamel.h>

@interface UMSS7Filter : UMPlugin<UMSCCP_FilterProtocol>
{
    NSString            *_filterConfigFile;
    BOOL                _isActive;
    UMSynchronizedDictionary *_tags;
    NSString            *_custom1;
    NSString            *_custom2;
    NSString            *_custom3;
    NSString            *_custom4;
    NSString            *_custom5;
    NSString            *_custom6;
    NSString            *_custom7;
    NSString            *_custom8;
    NSString            *_custom9;
    NSString            *_custom10;

    UMLayerCamel        *_camel;
    UMLayerTCAP         *_tcap_camel;
    UMLayerGSMMAP       *_gsmmap;
    UMLayerTCAP         *_tcap_gsmmap;
}

@property(readwrite,strong,atomic)  UMSynchronizedDictionary *tags;
@property(readwrite,strong,atomic)  NSString            *custom1;
@property(readwrite,strong,atomic)  NSString            *custom2;
@property(readwrite,strong,atomic)  NSString            *custom3;
@property(readwrite,strong,atomic)  NSString            *custom4;
@property(readwrite,strong,atomic)  NSString            *custom5;
@property(readwrite,strong,atomic)  NSString            *custom6;
@property(readwrite,strong,atomic)  NSString            *custom7;
@property(readwrite,strong,atomic)  NSString            *custom8;
@property(readwrite,strong,atomic)  NSString            *custom9;
@property(readwrite,strong,atomic)  NSString            *custom10;

/* note these methods are to manipulate the config, not while filtering */
- (void)addTag:(NSString *)tag;
- (void)clearTag:(NSString *)tag;
- (BOOL)hasTag:(NSString *)tag;
- (void)clearAllTags;

- (void)loadConfigFromFile:(NSString *)filename;

- (void)processConfig:(NSString *)jsonString error:(NSError**)eptr;
- (void)processConfigDict:(NSDictionary *)dict error:(NSError**)eptr;

- (void)refreshConfig; /* this is called if a namedlist is updated so the engines can readjust its internal structures if needed */

- (UMSCCP_FilterResult) filterInbound:(UMSCCP_Packet *)packet;
- (UMSCCP_FilterMatchResult) matchesInbound:(UMSCCP_Packet *)packet;

@end


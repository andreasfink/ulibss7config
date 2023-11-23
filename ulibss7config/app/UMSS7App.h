//
//  UMSS7App.h
//  ulibss7config
//
//  Created by Andreas Fink on 16.07.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import <ulib/ulib.h>
#import <ulibgt/ulibgt.h>
#import <ulibsccp/ulibsccp.h>
#import <ulibtcap/ulibtcap.h>
#import <ulibgsmmap/ulibgsmmap.h>
#import <ulibcamel/ulibcamel.h>
#import <ulibdiameter/ulibdiameter.h>
#import <ulibss7config/SS7AppDelegate.h>

typedef enum UMSS7AppType
{
    UMSS7AppType_MTP3 = 0,
    UMSS7AppType_SCCP = 1,
    UMSS7AppType_TCAP = 2,
    UMSS7AppType_GSMMAP = 3,
    UMSS7AppType_CAMEL = 4,
    UMSS7AppType_Diameter = 5,
} UMSS7AppType;

@interface UMSS7App : UMPlugin
{
    UMSS7AppType     _appType;
    BOOL             _isActive;
    UMMTP3PointCode  *_pc;
    NSNumber         *_mtp3_si;

    SS7AppDelegate   *_appDelegate;
    SccpAddress      *_globalTitle;
    UMLayerSCCP      *_sccp;
    UMLayerTCAP      *_tcap;
    UMLayerGSMMAP    *_map;
    UMLayerCamel     *_camel;
    UMDiameterRouter *_diameterRouter;
}

@property(readwrite,assign,atomic)      UMSS7AppType    appType;
@property(readwrite,assign,atomic)      BOOL            isActive;
@property(readwrite,strong,atomic)      SccpAddress     *globalTitle;
@property(readwrite,strong,atomic)      UMLayerSCCP     *scccp;
@property(readwrite,strong,atomic)      UMLayerTCAP     *tcap;
@property(readwrite,strong,atomic)      UMLayerGSMMAP   *map;
@property(readwrite,strong,atomic)      UMLayerCamel    *camel;
@property(readwrite,strong,atomic)      UMDiameterRouter *diameterRouter;
@property(readwrite,strong,atomic)      SS7AppDelegate  *appDelegate;

//@property(readwrite,strong,atomic)      UMLayerDiameter *diameter;


- (UMSS7App *)initWithAppDelegate:(SS7AppDelegate *)appdel;
- (int)setConfig:(NSDictionary *)dict; /* returns 0 on Success */

- (int)load; /* returns 0 on success */
- (int)createInstance; /* returns 0 on success */
- (int)startInstance; /* returns 0 on success */
- (int)stopInstance; /* returns 0 on success */
- (int)unload; /* returns 0 on success */

@end


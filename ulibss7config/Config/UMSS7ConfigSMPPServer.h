//
//  UMSS7ConfigSMPPServer.h
//  ulibss7config
//
//  Created by Andreas Fink on 07.07.22.
//  Copyright © 2022 Andreas Fink. All rights reserved.
//

#import <ulib/ulib.h>
#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigSMPPServer : UMSS7ConfigObject
{
    NSNumber *              _port;
    NSArray<NSString *>*    _ipAuthorisationPlugins;
    NSArray<NSString *>*    _userAuthorisationPlugins;
    NSArray<NSString *>*    _submissionAuthorisationPlugins;
    NSArray<NSString *>*    _characterisationPlugins;
    NSArray<NSString *>*    _modificationPlugins;
    NSArray<NSString *>*    _preroutingPlugins;
    NSString *              _routingPlugin;
    NSArray<NSString *>*    _billingPlugins;
    NSArray<NSString *>*    _dlrPlugins;
    NSString *              _storagePlugin;
    NSArray<NSString *>*    _cdrPlugins;
}

@property(readwrite,strong,atomic)      NSNumber                *port;
@property(readwrite,strong,atomic)      NSArray<NSString *>*    ipAuthorisationPlugins;
@property(readwrite,strong,atomic)      NSArray<NSString *>*    userAuthorisationPlugins;
@property(readwrite,strong,atomic)      NSArray<NSString *>*    submissionAuthorisationPlugins;
@property(readwrite,strong,atomic)      NSArray<NSString *>*    characterisationPlugins;
@property(readwrite,strong,atomic)      NSArray<NSString *>*    modificationPlugins;
@property(readwrite,strong,atomic)      NSArray<NSString *>*    preroutingPlugins;
@property(readwrite,strong,atomic)      NSString *              routingPlugin;
@property(readwrite,strong,atomic)      NSArray<NSString *>*    billingPlugins;
@property(readwrite,strong,atomic)      NSArray<NSString *>*    dlrPlugins;
@property(readwrite,strong,atomic)      NSString *              storagePlugin;
@property(readwrite,strong,atomic)      NSArray<NSString *>*    cdrPlugin;

@end


//
//  UMSS7ConfigSMPPPlugin.h
//  ulibss7config
//
//  Created by Andreas Fink on 11.04.22.
//  Copyright © 2022 Andreas Fink. All rights reserved.
//

#import <ulib/ulib.h>
#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigSMPPPlugin : UMSS7ConfigObject
{
    NSString    *_defaultFileNameilename;
    NSString    *_pluginFileName;
    NSString    *_configFile;
    NSString    *_configString;
}


@property(readwrite,strong,atomic)  NSString    *defaultFileNameilename;
@property(readwrite,strong,atomic)  NSString    *pluginFileName;
@property(readwrite,strong,atomic)  NSString    *configFile;
@property(readwrite,strong,atomic)  NSString    *configString;

@end


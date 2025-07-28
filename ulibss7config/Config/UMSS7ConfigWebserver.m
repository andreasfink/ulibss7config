//
//  UMSS7ConfigWebserver.m
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import <ulibss7config/UMSS7ConfigWebserver.h>
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigWebserver

+ (NSString *)groupName
{
    return @"webserver";
}
- (NSString *)groupName
{
    return [UMSS7ConfigWebserver groupName];
}

- (UMSS7ConfigWebserver *)initWithConfig:(NSDictionary *)dict
{
    self = [super initWithConfig:dict];
    if(self)
    {
        [self setConfig:dict];
    }
    return self;
}


- (void)appendConfigToString:(NSMutableString *)o
{
    [super appendConfigToString:o];
#include "UMSS7Config_macroAppendConfig.h"
#include "UMSS7ConfigWebserver.def.h"
#include "UMSS7Config_macroClear.h"

}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigWebserver.def.h"
#include "UMSS7Config_macroClear.h"
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigWebserver.def.h"
#include "UMSS7Config_macroClear.h"

}

- (UMSS7ConfigWebserver *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigWebserver allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end


//
//  UMSS7ConfigMtp3Route.m
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigMTP3Route.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigMTP3Route


+ (NSString *)type
{
    return @"mtp3-route";
}

- (NSString *)type
{
    return [UMSS7ConfigMTP3Route type];
}

- (NSString *)name
{
    if(_as)
    {
        return [NSString stringWithFormat:@"%@:AS:%@:%@",_mtp3,_as,_dpc];
    }
    else
    {
        return [NSString stringWithFormat:@"%@:LS:%@:%@",_mtp3,_ls,_dpc];
    }
}

- (UMSS7ConfigMTP3Route *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7ConfigMTP3Route.def.h"
#include "UMSS7Config_macroClear.h"

}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigMTP3Route.def.h"
#include "UMSS7Config_macroClear.h"
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigMTP3Route.def.h"
#include "UMSS7Config_macroClear.h"
}

- (UMSS7ConfigMTP3Route *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigMTP3Route allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end

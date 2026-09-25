//
//  UMSS7ConfigDiameterRoute.m
//  ulibss7config
//
//  Created by Andreas Fink on 18.06.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigDiameterRoute.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigDiameterRoute

+ (NSString *)groupName
{
    return @"diameter-route";
}

- (NSString *)groupName
{
    return [UMSS7ConfigDiameterRoute groupName];
}


- (UMSS7ConfigDiameterRoute *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7ConfigDiameterRoute.def.h"
#include "UMSS7Config_macroClear.h"
}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigDiameterRoute.def.h"
#include "UMSS7Config_macroClear.h"
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigDiameterRoute.def.h"
#include "UMSS7Config_macroClear.h"
}

- (UMSS7ConfigDiameterRoute *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigDiameterRoute allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

- (NSString *)name
{
    return [NSString stringWithFormat:@"%@/%@/%@/%@",_router,_realm,_hostname,_applicationId];
}

- (void)setName:(NSString *)str
{
}
@end



//
//  UMSS7ConfigServiceUserProfile.m
//  ulibss7config
//
//  Created by Andreas Fink on 08.05.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigServiceProfile.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigServiceProfile

+ (NSString *)type
{
    return @"service-profile";
}
- (NSString *)type
{
    return [UMSS7ConfigServiceProfile type];
}

- (UMSS7ConfigServiceProfile *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7ConfigServiceProfile.def.h"
#include "UMSS7Config_macroClear.h"
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
    
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigServiceProfile.def.h"
#include "UMSS7Config_macroClear.h"
    
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
#include "UMSS7Config_macroSetDict.h"
#include "UMSS7ConfigServiceProfile.def.h"
#include "UMSS7Config_macroClear.h"
}

- (UMSS7ConfigServiceProfile *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigServiceProfile allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end

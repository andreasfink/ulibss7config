//
//  UMSS7ConfigTCAPFilter.m
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigTCAPFilter.h"
#import "UMSS7ConfigMacroHelper.h"
#import "UMSS7ConfigTCAPFilterEntry.h"

@implementation UMSS7ConfigTCAPFilter

+ (NSString *)groupName

{
    return @"tcap-filter";
}
- (NSString *)groupName
{
    return [UMSS7ConfigTCAPFilter groupName];
}

- (UMSS7ConfigTCAPFilter *)initWithConfig:(NSDictionary *)dict
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
#include "UMSS7ConfigTCAPFilter.def.h"
#include "UMSS7Config_macroClear.h"

    for(UMSS7ConfigTCAPFilterEntry *e in _subEntries)
    {
        [o appendString:@"\n"];
        [e appendConfigToString:o];
    }
}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
    
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigTCAPFilter.def.h"
#include "UMSS7Config_macroClear.h"

    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigTCAPFilter.def.h"
#include "UMSS7Config_macroClear.h"
}

- (void)setSubConfig:(NSArray *)configs
{
    for(NSDictionary *config in configs)
    {
        UMSS7ConfigTCAPFilterEntry *entry = [[UMSS7ConfigTCAPFilterEntry alloc]initWithConfig:config];
        [_subEntries addObject:entry];
    }
}


- (UMSS7ConfigTCAPFilter *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigTCAPFilter allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}



@end


//
//  UMSS7ConfigSCCPTranslationTableEntry.m
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSCCPTranslationTableEntry.h"
#import "UMSS7ConfigMacroHelper.h"
#import <ulibgt/ulibgt.h>

@implementation UMSS7ConfigSCCPTranslationTableEntry

+ (NSString *)groupName
{
    return @"sccp-translation-table-entry";
}

- (NSString *)groupName
{
    return [UMSS7ConfigSCCPTranslationTableEntry groupName];
}


- (NSString *)singleGta
{
    if(_gtas.count > 1)
    {
        return _gtas[0];
    }
    return NULL;
}

- (void)setSingleGta:(NSString *)gta
{
    if([gta isKindOfClass:[NSString class]])
    {
        _gtas = @[(NSString *)gta];
    }
    else if([gta isKindOfClass:[NSArray class]])
    {
        _gtas = (NSArray *)gta;
    }
    else if(gta==NULL)
    {
        _gtas = @[];
    }
}

- (UMSS7ConfigSCCPTranslationTableEntry *)initWithConfig:(NSDictionary *)dict
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
    [super appendConfigToString:o withoutName:YES];
#include "UMSS7Config_macroAppendConfig.h"
#include "UMSS7ConfigSCCPTranslationTableEntry.def.h"
#include "UMSS7Config_macroClear.h"

}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super configWithoutName:YES];
#include "UMSS7Config_macroAppendDict.h"
#include "UMSS7ConfigSCCPTranslationTableEntry.def.h"
#include "UMSS7Config_macroClear.h"
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
#include "UMSS7Config_macroSetConfigFromDict.h"
#include "UMSS7ConfigSCCPTranslationTableEntry.def.h"
#include "UMSS7Config_macroClear.h"
    
    if(_tidRange)
    {
        NSArray *a  = [_appcontext componentsSeparatedByString:@"-"];
        if(a.count == 2)
        {
            NSString *startString = a[0];
            NSString *endString = a[1];
            if(startString.length == 0)
            {
                _tidStart = @(0);
            }
            else
            {
                _tidStart =@([startString integerValue]);
            }
            if(endString.length == 0)
            {
                _tidEnd = @(0xFFFFFFFF);
            }
            else
            {
                _tidEnd =@([endString integerValue]);
            }
        }
    }
    
    NSMutableArray *ssns = NULL;
    if(_ssn.length > 0)
    {
        NSArray *ssnStrings  =[_ssn componentsSeparatedByString:@","];
        if(ssnStrings.count == 0)
        {
            ssnStrings = NULL;
        }
        for(NSString *s in ssnStrings)
        {
            int i = [s intValue];
            [ssns addObject:@(i)];
        }
        if(ssns.count == 0)
        {
            ssns = NULL;
        }
    }

    
    NSMutableArray *ops = NULL;
    if(_opcode.length > 0)
    {
        ops = [[NSMutableArray alloc]init];
        NSArray *opsStrings  =[_opcode componentsSeparatedByString:@","];
        if(opsStrings.count == 0)
        {
            opsStrings = NULL;
        }
        for(NSString *o in opsStrings)
        {
            int i = [o intValue];
            [ops addObject:@(i)];
        }
        if(ops.count == 0)
        {
            ops = NULL;
        }
    }

    NSArray *acs = NULL;
    if(_appcontext.length > 0)
    {
        acs = [_appcontext componentsSeparatedByString:@","];
        if(acs.count == 0)
        {
            acs = NULL;
        }
    }
    _name = [SccpGttRoutingTableEntry entryNameForGta:_gtas
                                            tableName:_translationTableName
                            tcapTransactionRangeStart:_tidStart
                              tcapTransactionRangeEnd:_tidEnd
                                           calledSSNs:ssns
                                        calledOpcodes:ops
                                          appContexts:acs];
 
}

- (UMSS7ConfigSCCPTranslationTableEntry *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return  [[UMSS7ConfigSCCPTranslationTableEntry allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end

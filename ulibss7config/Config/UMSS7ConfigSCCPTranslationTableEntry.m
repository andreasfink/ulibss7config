//
//  UMSS7ConfigSCCPTranslationTableEntry.m
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSCCPTranslationTableEntry.h"
#import "UMSS7ConfigMacros.h"
#import <ulibgt/ulibgt.h>

@implementation UMSS7ConfigSCCPTranslationTableEntry

+ (NSString *)type
{
    return @"sccp-translation-table-entry";
}

- (NSString *)type
{
    return [UMSS7ConfigSCCPTranslationTableEntry type];
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
    [super appendConfigToString:s withoutName:YES];
    APPEND_CONFIG_STRING(o,@"table",_translationTableName);
    APPEND_CONFIG_ARRAY_VERBOSE(s,@"gta",_gtas);
    APPEND_CONFIG_STRING(o,@"destination",_sccpDestination);
    APPEND_CONFIG_STRING(o,@"post-translation",_postTranslation);
    APPEND_CONFIG_STRING(o,@"gt-owner",_gtOwner);
    APPEND_CONFIG_STRING(o,@"gt-user",_gtUser);
    APPEND_CONFIG_INTEGER(o,@"transaction-id-start",_tidStart);
    APPEND_CONFIG_INTEGER(o,@"transaction-id-end",_tidEnd);
    APPEND_CONFIG_STRING(o,@"transaction-id-range",_tidRange);
    APPEND_CONFIG_STRING(o,@"ssn",_ssn);
    APPEND_CONFIG_STRING(o,@"opcode",_opcode);
    APPEND_CONFIG_STRING(o,@"application-context",_appcontext);
}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super configWithoutName:YES];
    APPEND_DICT_STRING(o,@"table",_translationTableName);
    APPEND_DICT_ARRAY(dict,@"gta",_gtas);
    APPEND_DICT_STRING(o,@"destination",_sccpDestination);
    APPEND_DICT_STRING(o,@"post-translation",_postTranslation);
    APPEND_DICT_STRING(o,@"gt-owner",_gtOwner);
    APPEND_DICT_STRING(o,@"gt-user",_gtUser);
    APPEND_DICT_INTEGER(o,@"transaction-id-start",_tidStart);
    APPEND_DICT_INTEGER(o,@"transaction-id-end",_tidEnd);
    APPEND_DICT_STRING(o,@"transaction-id-range",_tidRange);
    APPEND_DICT_STRING(o,@"ssn",_ssn);
    APPEND_DICT_STRING(o,@"opcode",_opcode);
    APPEND_DICT_STRING(o,@"application-context",_appcontext);
    return dict;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];
    SET_DICT_FILTERED_STRING(dict,@"table",_translationTableName);
    SET_DICT_ARRAY(dict,@"gta",_gtas);
    SET_DICT_FILTERED_STRING(dict,@"destination",_sccpDestination);
    SET_DICT_FILTERED_STRING(dict,@"post-translation",_postTranslation);
    SET_DICT_FILTERED_STRING(dict,@"gt-owner",_gtOwner);
    SET_DICT_FILTERED_STRING(dict,@"gt-user",_gtUser);
    SET_DICT_INTEGER(o,@"transaction-id-start",_tidStart);
    SET_DICT_INTEGER(o,@"transaction-id-end",_tidEnd);
    SET_DICT_STRING(o,@"transaction-id-range",_tidRange);
    SET_DICT_STRING(o,@"ssn",_ssn);
    SET_DICT_STRING(o,@"opcode",_opcode);
    SET_DICT_STRING(o,@"application-context",_appcontext);
    
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

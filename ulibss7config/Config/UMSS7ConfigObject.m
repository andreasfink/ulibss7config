//
//  UMSS7ConfigObject.m
//  estp
//
//  Created by Andreas Fink on 01.02.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigObject

- (BOOL) isDirty
{
    return _dirty;
}

- (void)setDirty:(BOOL)d
{
    _dirty = d;
}

- (NSString *)type
{
    return @"undefined";
}

- (UMSS7ConfigObject *)initWithConfig:(NSDictionary *)o
{
    self = [super init];
    if(self)
    {
        _subEntries =     [[NSMutableArray<UMSS7ConfigObject *> alloc] init];
        [self setSuperConfig:o];
    }
    return self;
}

- (NSString *)configString
{
    NSMutableString *s = [[NSMutableString alloc]init];
    [self appendConfigToString:s];
    return s;
}

- (void)appendConfigToString:(NSMutableString *)o
{
    return [self appendConfigToString:o withoutName:NO];
}

- (void)appendConfigToString:(NSMutableString *)o withoutName:(BOOL)withoutName
{
    [o appendFormat:@"\n"];

    appendConfig_STRING(o,"group", self.type,"group",1,"index");
    if(withoutName==NO)
    {
        appendConfig_STRING(o,"name",_name,"name",2,"index,unique");
    }
    appendConfig_STRING(o,"description",_objectDescription,"description",3,"");
    appendConfig_BOOLEAN(o,"enable",_enabled,"enable",4,"");
    appendConfig_INTEGER(o,"log-level",_logLevel,"log_level",5,"");
    appendConfig_STRING(o,"log-file",_logFile,"log_file",6,"");
    appendConfig_ARRAY_VERBOSE(o,"comment",_comments,"comment",7,"");
}

- (UMSynchronizedSortedDictionary *)config
{
    return [self configWithoutName:NO];
}

- (UMSynchronizedSortedDictionary *)configWithoutName:(BOOL)withoutName
{
    UMSynchronizedSortedDictionary *o = [[UMSynchronizedSortedDictionary alloc]init];
    
    
#include "UMSS7Config_macroAppendDict.h"

    appendDict_STRING(o,"group", self.type,"group",1,"index");
    if((withoutName==NO) && (_name.length >0))
    {
        appendDict_STRING(o,"name",_name,"name",2,"index,unique");
    }
    STRING(o,"description",_objectDescription,"description",3,"");
    BOOLEAN(o,"enable",_enabled,"enable",4,"");
    INTEGER(o,"log-level",_logLevel,"log_level",5,"");
    STRING(o,"log-file",_logFile,"log_file",6,"");
    ARRAY_VERBOSE(o,"comment",_comments,"comment",7,"");
#include "UMSS7Config_macroClear.h"

    return o;
}

- (NSArray *)subConfig
{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for(UMSS7ConfigObject *e in _subEntries)
    {
        [array addObject:e.config];
    }
    return array;
}

- (void)setConfig:(NSDictionary *)o
{
    /* to be defined in subclass */
}

- (void)setSubConfig:(NSArray *)configs
{
    /* to be defined in subclass */
}

- (void)setSuperConfig:(NSDictionary *)o
{
    /* group can not be set as the subclass defines it statically.
     So we already have to be the right object */

    /* names can only be filtered names */
    NSString *group =  o[@"group"];
    id n = o[@"name"];
    if(n==NULL)
    {
        if(   (![group isEqualToString:@"general"])
           &&(![group isEqualToString:@"mtp3-route"])
           &&(![group isEqualToString:@"sccp-number-translation-entry"])
           &&(![group isEqualToString:@"tcap-filter-entry"])
           &&(![group isEqualToString:@"sccp-translation-table-entry"])
           &&(![group isEqualToString:@"sccp-destination-entry"])
           &&(![group isEqualToString:@"sccp-filter"])
           &&(![group isEqualToString:@"cdr-writer"])
           &&(![group isEqualToString:@"ss7-filter-action"])
           &&(![group isEqualToString:@"ss7-filter-rule"])
           &&(![group isEqualToString:@"diameter-route"]))
        {
            NSLog(@"Warning: object of type %@ without a name",group);
        }
    }
    else if([n isKindOfClass:[NSString class]])
    {
        NSString *n2 = [UMSS7ConfigObject filterName:(NSString *)n];
        if(n2.length > 0)
        {
            _name = n2;
        }
    }
    else
    {
        NSLog(@"Warning: Not a string for an object name. Probably misconfiguration: %@ in group %@",n,group);
    }

    NSString *newName = [UMSS7ConfigObject filterName:o[@"newname"]];
    if((newName.length > 0) && (![newName isEqualToString:_name]))
    {
        _oldName = _name;
        _name = newName;
        _nameChanged = YES;
    }
    
#include "UMSS7Config_macroSetConfigFromDict.h"
     STRING(o,"description",_objectDescription,"description",3,"");
     BOOLEAN(o,"enable",_enabled,"enable",4,"");
     INTEGER(o,"log-level",_logLevel,"log_level",5,"");
     STRING(o,"log-file",_logFile,"log_file",6,"");
#include "UMSS7Config_macroClear.h"

    id comments = o[@"comment"];
    if([comments isKindOfClass:[NSArray class]])
    {
        _comments = (NSArray *)comments;
    }
    else if([comments isKindOfClass:[NSString class]])
    {
        _comments = [((NSString *)comments) componentsSeparatedByString:@"\n"];
    }
}

+(NSString *)filterName:(NSString *)str
{
    if(str==NULL)
    {
        return NULL;
    }
    NSInteger LIMIT = 64;
    char out[LIMIT];
    NSInteger i;
    NSInteger j=0;
    NSInteger n=str.length;
    if(n>LIMIT)
    {
        n = LIMIT;
    }
    memset(out,0x00,sizeof(out));
    for(i=0;i<n;i++)
    {
        unichar c = [str characterAtIndex:i];
        if((c>='a') && (c<='z'))
        {
            out[j++]=c;
        }
        else if((c>='A') && (c<='Z')) 
        {
            out[j++]=c-'A'+'a';
        }
        else if((c>='0') && (c<='9'))
        {
            out[j++]=c;
        }
        else
        {
            switch(c)
            {
                case '.':
                    if(i>0)
                    {
                        out[j++]=c;
                    }
                    break;
                case '_':
                case '-':
                case '+':
                case ',':
                case '=':
                case '%':
                    out[j++]=c;
                    break;
                default:
                    break;
            }
        }
    }
    out[LIMIT-1]='\0';
    NSString *result = @(out);
    return result;
}

- (UMSS7ConfigObject *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    UMSS7ConfigObject *o = [[UMSS7ConfigObject allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
    o.subEntries = _subEntries;
    return o;
}

- (void)addSubEntry:(UMSS7ConfigObject *)obj
{
    if(_subEntries==NULL)
    {
       _subEntries =  [[NSMutableArray alloc]init];
    }
    [_subEntries addObject:obj];
}

- (NSArray<NSDictionary *> *)subConfigs
{
    NSMutableArray *configs = [[NSMutableArray alloc]init];
    for(UMSS7ConfigObject *co in _subEntries)
    {
        [configs addObject:[co.config dictionaryCopy]];
    }
    return configs;
}

- (id)proxyForJson
{
    return self.config;
}

- (UMSS7ConfigObject *)initWithString:(NSString *)s
{
    NSArray *lines = [s componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    for(NSString *line in lines)
    {
        NSArray *items  = [line componentsSeparatedByString:@"="];
        if ([items count] == 2)
        {
            NSString *tag = [[items objectAtIndex:0] trim];
            NSString *val = [[items objectAtIndex:1] trim];
            dict[tag] = val;
        }
    }
    return [self initWithConfig:dict];
}

- (NSString *)description
{
    NSMutableString *s = [[NSMutableString alloc]init];
    
    [s appendString:[super description]];
    [s appendString:@"\n{"];
    [s appendString:[self configString]];
    [s appendString:@"\n}"];
    return s;
}

@end

//
//  UMSS7ConfigObject.m
//  estp
//
//  Created by Andreas Fink on 01.02.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigMacros.h"

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

- (UMSS7ConfigObject *)initWithConfig:(NSDictionary *)dict
{
    self = [super init];
    if(self)
    {
        _subEntries =     [[NSMutableArray<UMSS7ConfigObject *> alloc] init];
        [self setSuperConfig:dict];
    }
    return self;
}

- (NSString *)configString
{
    NSMutableString *s = [[NSMutableString alloc]init];
    [self appendConfigToString:s];
    return s;
}

- (void)appendConfigToString:(NSMutableString *)s
{
    return [self appendConfigToString:s withoutName:NO];
}

- (void)appendConfigToString:(NSMutableString *)s withoutName:(BOOL)withoutName
{
    [s appendFormat:@"\n"];
    APPEND_CONFIG_STRING(s,@"group",self.type);
    if(withoutName==NO)
    {
        APPEND_CONFIG_STRING(s,@"name",_name);
    }
    APPEND_CONFIG_STRING(s,@"description",_objectDescription);
    APPEND_CONFIG_BOOLEAN(s,@"enable",_enabled);
    APPEND_CONFIG_INTEGER(s,@"log-level",_logLevel);
    APPEND_CONFIG_STRING(s,@"log-file",_logFile);
    APPEND_CONFIG_ARRAY_VERBOSE(s,@"comment",_comments); /* this will write multipe comment=.. lines */
}

- (UMSynchronizedSortedDictionary *)config
{
    return [self configWithoutName:NO];
}

- (UMSynchronizedSortedDictionary *)configWithoutName:(BOOL)withoutName
{
    UMSynchronizedSortedDictionary *dict = [[UMSynchronizedSortedDictionary alloc]init];
    APPEND_DICT_STRING(dict,@"group",self.type);
    if((withoutName==NO) && (_name.length >0))
    {
        APPEND_DICT_STRING(dict,@"name",_name);
    }
    APPEND_DICT_STRING(dict,@"description",_objectDescription);
    APPEND_DICT_BOOLEAN(dict,@"enable",_enabled);
    APPEND_DICT_INTEGER(dict,@"log-level",_logLevel);
    APPEND_DICT_STRING(dict,@"log-file",_logFile);
    NSString *commentsAsString = [_comments componentsJoinedByString:@"\n"];
    APPEND_DICT_STRING(dict,@"comment",commentsAsString);
    return dict;
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

- (void)setConfig:(NSDictionary *)dict
{
    /* to be defined in subclass */
}

- (void)setSubConfig:(NSArray *)configs
{
    /* to be defined in subclass */
}

- (void)setSuperConfig:(NSDictionary *)dict
{
    /* group can not be set as the subclass defines it statically.
     So we already have to be the right object */

    /* names can only be filtered names */
    NSString *group =  dict[@"group"];
    id n = dict[@"name"];
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

    NSString *newName = [UMSS7ConfigObject filterName:dict[@"newname"]];
    if((newName.length > 0) && (![newName isEqualToString:_name]))
    {
        _oldName = _name;
        _name = newName;
        _nameChanged = YES;
    }
    SET_DICT_STRING(dict,@"description",_objectDescription);
    SET_DICT_BOOLEAN(dict,@"enable",_enabled);
    SET_DICT_INTEGER(dict,@"log-level",_logLevel);
    SET_DICT_STRING(dict,@"log-file",_logFile);
    id comments = dict[@"comment"];
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

@end

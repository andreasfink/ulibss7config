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
    [s appendFormat:@"\n"];
    APPEND_CONFIG_STRING(s,@"group",self.type);
    APPEND_CONFIG_STRING(s,@"name",_name);
    APPEND_CONFIG_STRING(s,@"description",_objectDescription);
    APPEND_CONFIG_BOOLEAN(s,@"enable",_enabled);
    APPEND_CONFIG_INTEGER(s,@"log-level",(int)_logLevel);
    APPEND_CONFIG_ARRAY_VERBOSE(s,@"comment",_comments);
}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [[UMSynchronizedSortedDictionary alloc]init];
    APPEND_DICT_STRING(dict,@"group",self.type);
    APPEND_DICT_STRING(dict,@"name",_name);
    APPEND_DICT_STRING(dict,@"description",_objectDescription);
    APPEND_DICT_BOOLEAN(dict,@"enable",_enabled);
    APPEND_DICT_INTEGER(dict,@"log-level",(int)_logLevel);
    APPEND_DICT_ARRAY(dict,@"comment",_comments);
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

    id n = dict[@"name"];
    if([n isKindOfClass:[NSString class]])
    {
        NSString *n2 = [UMSS7ConfigObject filterName:(NSString *)n];
        if(n2.length > 0)
        {
            _name = n2;
        }
    }
    else
    {
        NSLog(@"Warning: Not a string for an object name. Probably misconfiguration: %@",n);
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
    SET_DICT_ARRAY(dict,@"comment",_comments);
}

+(NSString *)filterName:(NSString *)str
{
    if(str==NULL)
    {
        return NULL;
    }
    char out[256];
    const char *in = str.UTF8String;
    size_t i;
    size_t j=0;
    size_t n=strlen(in);
    if(n>255)
    {
        n = 255;
    }
    memset(out,0x00,sizeof(out));
    for(i=0;i<n;i++)
    {
        char c = in[i];
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
                    out[j++]=c;
                    break;
                default:
                    break;
            }
        }
    }
    return @(out);
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

@end

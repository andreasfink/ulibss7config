//
//  UMSS7ConfigSCCPTranslationTableMap.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.12.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSCCPTranslationTableMap.h"
#import "UMSS7ConfigMacroHelper.h"

@implementation UMSS7ConfigSCCPTranslationTableMap

+ (NSString *)type
{
    return @"sccp-translation-table-map";
}

- (NSString *)type
{
    return [UMSS7ConfigSCCPTranslationTableMap type];
}


- (UMSS7ConfigSCCPTranslationTableMap *)initWithConfig:(NSDictionary *)dict
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
    for(int i=0;i<256;i++)
    {
        NSNumber *value = _map[i];
        if(value!=NULL)
        {
            [o appendFormat:@"%d=%@\n",i,value];
        }
    }
}

- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *o = [super config];
    for(int i=0;i<256;i++)
    {
        if(_map[i]!=NULL)
        {
            NSString *n = [NSString stringWithFormat:@"%d",i];
            o[n] = [_map[i] copy];
        }
    }
    return o;
}

- (void)setConfig:(NSDictionary *)o
{
    [self setSuperConfig:o];

    for(int i=0;i<256;i++)
    {
        NSString *n = [NSString stringWithFormat:@"%d",i];
        id o1 = o[n];
        if([o1 isKindOfClass:[NSString class]]) \
        {
            NSString *s = o1;
            int k = [s intValue];
            if([s isEqualToString:@"*"])
            {
                for(i=0;i<256;i++)
                {
                    _map[i] =@(k);
                }
            }
            else
            {
                _map[i] =@(k);
            }
        }
        else if([o1 isKindOfClass:[NSNumber class]]) \
        {
            _map[i]= [o1 copy];
        }
        else
        {
            _map[i]=NULL;
        }
    }
}

- (UMSS7ConfigSCCPTranslationTableMap *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigSCCPTranslationTableMap allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end

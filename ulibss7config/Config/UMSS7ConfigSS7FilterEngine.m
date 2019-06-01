//
//  UMSS7ConfigSS7FilterEngine.m
//  ulibss7config
//
//  Created by Andreas Fink on 17.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSS7FilterEngine.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigSS7FilterEngine

+ (NSString *)type
{
	return @"ss7-filter-engine";
}

- (NSString *)type
{
	return [UMSS7ConfigSS7FilterEngine type];
}


- (UMSS7ConfigSS7FilterEngine *)initWithConfig:(NSDictionary *)dict
{
	self = [super initWithConfig:dict];
	if(self)
	{
		[self setConfig:dict];
	}
	return self;
}

- (void)appendConfigToString:(NSMutableString *)s
{
	[super appendConfigToString:s];
	APPEND_CONFIG_STRING(s,@"filename",_filename);
}


- (UMSynchronizedSortedDictionary *)config
{
	UMSynchronizedSortedDictionary *dict = [super config];

	APPEND_DICT_STRING(dict,@"filename",_filename);
	return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
	[self setSuperConfig:dict];
	SET_DICT_STRING(dict,@"filename",_filename);
}

- (UMSS7ConfigSS7FilterEngine *)copyWithZone:(NSZone *)zone
{
	UMSynchronizedSortedDictionary *currentConfig = [self config];
	return [[UMSS7ConfigSS7FilterEngine allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end

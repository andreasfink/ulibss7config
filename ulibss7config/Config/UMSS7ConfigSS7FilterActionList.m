//
//  UMSS7ConfigSS7FilterActionList.m
//  ulibss7config
//
//  Created by Andreas Fink on 17.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSS7FilterActionList.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigSS7FilterActionList

+ (NSString *)type
{
	return @"ss7-filter-action-list";
}

- (NSString *)type
{
	return [UMSS7ConfigSS7FilterActionList type];
}

- (UMSS7ConfigSS7FilterActionList *)initWithConfig:(NSDictionary *)dict
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
	APPEND_CONFIG_STRING(s,@"action",_action);
	APPEND_CONFIG_STRING(s,@"log",_log);
	APPEND_CONFIG_INTEGER(s,@"error",_error);
	APPEND_CONFIG_STRING(s,@"reroute-destination",_rerouteDestination);
	APPEND_CONFIG_STRING(s,@"reroute-called-address",_rerouteCalledAddress);
	APPEND_CONFIG_STRING(s,@"reroute-called-address-prefix",_rerouteCalledAddressPrefix);
	APPEND_CONFIG_STRING(s,@"category",_category);
	APPEND_CONFIG_STRING(s,@"description",_userDescription);
}

- (UMSynchronizedSortedDictionary *)config
{
	UMSynchronizedSortedDictionary *dict = [super config];
	APPEND_DICT_STRING(dict,@"action",_action);
	APPEND_DICT_STRING(dict,@"log",_log);
	APPEND_DICT_INTEGER(dict,@"error",_error);
	APPEND_DICT_STRING(dict,@"reroute-destination",_rerouteDestination);
	APPEND_DICT_STRING(dict,@"reroute-called-address",_rerouteCalledAddress);
	APPEND_DICT_STRING(dict,@"reroute-called-address-prefix",_rerouteCalledAddressPrefix);
	APPEND_DICT_STRING(dict,@"category",_category);
	APPEND_DICT_STRING(dict,@"description",_userDescription);
	return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
	[self setSuperConfig:dict];
	SET_DICT_STRING(dict,@"action",_action);
	SET_DICT_STRING(dict,@"log",_log);
	SET_DICT_INTEGER(dict,@"error",_error);
	SET_DICT_STRING(dict,@"reroute-destination",_rerouteDestination);
	SET_DICT_STRING(dict,@"reroute-called-address",_rerouteCalledAddress);
	SET_DICT_STRING(dict,@"reroute-called-address-prefix",_rerouteCalledAddressPrefix);
	SET_DICT_STRING(dict,@"category",_category);
	SET_DICT_STRING(dict,@"description",_userDescription);
}

- (UMSS7ConfigSS7FilterActionList *)copyWithZone:(NSZone *)zone
{
	UMSynchronizedSortedDictionary *currentConfig = [self config];
	return [[UMSS7ConfigSS7FilterActionList allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end

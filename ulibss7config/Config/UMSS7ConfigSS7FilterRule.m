//
//  UMSS7ConfigSS7FilterRule.m
//  ulibss7config
//
//  Created by Andreas Fink on 17.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigSS7FilterRule.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigSS7FilterRule


+ (NSString *)type
{
	return @"ss7-filter-rule";
}

- (NSString *)type
{
	return [UMSS7ConfigSS7FilterRule type];
}

- (UMSS7ConfigSS7FilterRule *)initWithConfig:(NSDictionary *)dict
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

	APPEND_CONFIG_STRING(o,@"filter-set",_filterSet);
    APPEND_CONFIG_DATE(s,@"created-timestamp",_createdTimestamp);
    APPEND_CONFIG_DATE(s,@"modified-timestamp",_modifiedTimestamp);
    APPEND_CONFIG_STRING(o,@"status",_status);
	APPEND_CONFIG_STRING(o,@"engine",_engine);
	APPEND_CONFIG_STRING(o,@"action-list",_actionList);
    APPEND_CONFIG_STRING(o,@"engine-config",_engineConfig);
    APPEND_CONFIG_STRING(o,@"tags",_tags);
    APPEND_CONFIG_BOOLEAN(o,@"not-tags",_notTags);
    APPEND_CONFIG_STRING(o,@"variables",_variables);
    APPEND_CONFIG_BOOLEAN(o,@"not-vars",_notVars);
}

- (UMSynchronizedSortedDictionary *)config
{
	UMSynchronizedSortedDictionary *o = [super config];
	APPEND_DICT_STRING(o,@"filter-set",_filterSet);
    APPEND_DICT_DATE(dict,@"created-timestamp",_createdTimestamp);
    APPEND_DICT_DATE(dict,@"modified-timestamp",_modifiedTimestamp);
    APPEND_DICT_STRING(o,@"status",_status);
	APPEND_DICT_STRING(o,@"engine",_engine);
	APPEND_DICT_STRING(o,@"action-list",_actionList);
	APPEND_DICT_STRING(o,@"engine-config",_engineConfig);
    APPEND_DICT_STRING(o,@"tags",_tags);
    APPEND_DICT_BOOLEAN(o,@"not-tags",_notTags);
    APPEND_DICT_STRING(o,@"variables",_variables);
    APPEND_DICT_BOOLEAN(o,@"not-vars",_notVars);

	return dict;
}

- (void)setConfig:(NSDictionary *)o
{
	[self setSuperConfig:o];
	SET_DICT_STRING(o,@"filter-set",_filterSet);
    SET_DICT_DATE(dict,@"created-timestamp",_createdTimestamp);
    SET_DICT_DATE(dict,@"modified-timestamp",_modifiedTimestamp);
    SET_DICT_STRING(o,@"status",_status);
	SET_DICT_STRING(o,@"engine",_engine);
	SET_DICT_STRING(o,@"action-list",_actionList);
	SET_DICT_STRING(o,@"engine-config",_engineConfig);
    SET_DICT_STRING(o,@"tags",_tags);
    SET_DICT_BOOLEAN(o,@"not-tags",_notTags);
    SET_DICT_STRING(o,@"variables",_variables);
    SET_DICT_BOOLEAN(o,@"not-vars",_notVars);

}

- (UMSS7ConfigSS7FilterRule *)copyWithZone:(NSZone *)zone
{
	UMSynchronizedSortedDictionary *currentConfig = [self config];
	return [[UMSS7ConfigSS7FilterRule allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end

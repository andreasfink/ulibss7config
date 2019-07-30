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

- (void)appendConfigToString:(NSMutableString *)s
{
	[super appendConfigToString:s];

	APPEND_CONFIG_STRING(s,@"filter-set",_filterSet);
    APPEND_CONFIG_DATE(s,@"created-timestamp",_createdTimestamp);
    APPEND_CONFIG_DATE(s,@"modified-timestamp",_modifiedTimestamp);
    APPEND_CONFIG_STRING(s,@"status",_status);
	APPEND_CONFIG_STRING(s,@"engine",_engine);
	APPEND_CONFIG_STRING(s,@"action-list",_actionList);
    APPEND_CONFIG_STRING(s,@"engine-config",_engineConfig);
    APPEND_CONFIG_STRING(s,@"tags",_tags);
    APPEND_CONFIG_BOOLEAN(s,@"not-tags",_notTags);
    APPEND_CONFIG_STRING(s,@"variables",_variables);
    APPEND_CONFIG_BOOLEAN(s,@"not-vars",_notVars);
}

- (UMSynchronizedSortedDictionary *)config
{
	UMSynchronizedSortedDictionary *dict = [super config];
	APPEND_DICT_STRING(dict,@"filter-set",_filterSet);
    APPEND_DICT_DATE(dict,@"created-timestamp",_createdTimestamp);
    APPEND_DICT_DATE(dict,@"modified-timestamp",_modifiedTimestamp);
    APPEND_DICT_STRING(dict,@"status",_status);
	APPEND_DICT_STRING(dict,@"engine",_engine);
	APPEND_DICT_STRING(dict,@"action-list",_actionList);
	APPEND_DICT_STRING(dict,@"engine-config",_engineConfig);
    APPEND_DICT_STRING(dict,@"tags",_tags);
    APPEND_DICT_BOOLEAN(dict,@"not-tags",_notTags);
    APPEND_DICT_STRING(dict,@"variables",_variables);
    APPEND_DICT_BOOLEAN(dict,@"not-vars",_notVars);

	return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
	[self setSuperConfig:dict];
	SET_DICT_STRING(dict,@"filter-set",_filterSet);
    SET_DICT_DATE(dict,@"created-timestamp",_createdTimestamp);
    SET_DICT_DATE(dict,@"modified-timestamp",_modifiedTimestamp);
    SET_DICT_STRING(dict,@"status",_status);
	SET_DICT_STRING(dict,@"engine",_engine);
	SET_DICT_STRING(dict,@"action-list",_actionList);
	SET_DICT_STRING(dict,@"engine-config",_engineConfig);
    SET_DICT_STRING(dict,@"tags",_tags);
    SET_DICT_BOOLEAN(dict,@"not-tags",_notTags);
    SET_DICT_STRING(dict,@"variables",_variables);
    SET_DICT_BOOLEAN(dict,@"not-vars",_notVars);

}

- (UMSS7ConfigSS7FilterRule *)copyWithZone:(NSZone *)zone
{
	UMSynchronizedSortedDictionary *currentConfig = [self config];
	return [[UMSS7ConfigSS7FilterRule allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end

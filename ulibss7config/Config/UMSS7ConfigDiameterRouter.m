//
//  UMSS7ConfigDiameterRouter.m
//  ulibss7config
//
//  Created by Andreas Fink on 27.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigDiameterRouter.h"
#import "UMSS7ConfigMacros.h"

@implementation UMSS7ConfigDiameterRouter

+ (NSString *)type
{
    return @"diameter-router";
}

- (NSString *)type
{
    return [UMSS7ConfigDiameterRouter type];
}


- (UMSS7ConfigDiameterRouter *)initWithConfig:(NSDictionary *)dict
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
    APPEND_CONFIG_STRING(s,@"local-hostname",_localHostName);
    APPEND_CONFIG_STRING(s,@"local-realm",_localRealm);
    
    APPEND_CONFIG_STRING(s,@"statistic-db-pool",_statisticDbPool);
    APPEND_CONFIG_STRING(s,@"statistic-db-table",_statisticDbTable);
    APPEND_CONFIG_STRING(s,@"statistic-db-instance",_statisticDbInstance);
    APPEND_CONFIG_BOOLEAN(s,@"statistic-db-autocreate",_statisticDbAutocreate);
    
    APPEND_CONFIG_STRING(s,@"screening-sccp-plugin-name",_screeningDiameterPluginName);
    APPEND_CONFIG_STRING(s,@"screening-sccp-plugin-config-file",_screeningDiameterPluginConfigFile);
    APPEND_CONFIG_STRING(s,@"screening-sccp-plugin-trace-file",_screeningDiameterPluginTraceFile);


}


- (UMSynchronizedSortedDictionary *)config
{
    UMSynchronizedSortedDictionary *dict = [super config];
    APPEND_DICT_STRING(dict,@"local-hostname",_localHostName);
    APPEND_DICT_STRING(dict,@"local-realm",_localRealm);
    APPEND_DICT_STRING(dict,@"statistic-db-pool",_statisticDbPool);
    APPEND_DICT_STRING(dict,@"statistic-db-table",_statisticDbTable);
    APPEND_DICT_STRING(dict,@"statistic-db-instance",_statisticDbInstance);
    APPEND_DICT_BOOLEAN(dict,@"statistic-db-autocreate",_statisticDbAutocreate);
    APPEND_DICT_STRING(dict,@"screening-diameter-plugin-name",_screeningDiameterPluginName);
    APPEND_DICT_STRING(dict,@"screening-diameter-plugin-config-file",_screeningDiameterPluginConfigFile);
    APPEND_DICT_STRING(dict,@"screening-diameter-plugin-trace-file",_screeningDiameterPluginTraceFile);

    return dict;
}

- (void)setConfig:(NSDictionary *)dict
{
    [self setSuperConfig:dict];
    SET_DICT_STRING(dict,@"local-hostname",_localHostName);
    SET_DICT_STRING(dict,@"local-realm",_localRealm);
    SET_DICT_STRING(dict,@"statistic-db-pool",_statisticDbPool);
    SET_DICT_STRING(dict,@"statistic-db-table",_statisticDbTable);
    SET_DICT_STRING(dict,@"statistic-db-instance",_statisticDbInstance);
    SET_DICT_BOOLEAN(dict,@"statistic-db-autocreate",_statisticDbAutocreate);

    SET_DICT_STRING(dict,@"screening-diameter-plugin-name",_screeningDiameterPluginName);
    SET_DICT_STRING(dict,@"screening-diameter-plugin-config-file",_screeningDiameterPluginConfigFile);
    SET_DICT_STRING(dict,@"screening-diameter-plugin-trace-file",_screeningDiameterPluginTraceFile);

}

- (UMSS7ConfigDiameterRouter *)copyWithZone:(NSZone *)zone
{
    UMSynchronizedSortedDictionary *currentConfig = [self config];
    return [[UMSS7ConfigDiameterRouter allocWithZone:zone]initWithConfig:[currentConfig dictionaryCopy]];
}

@end



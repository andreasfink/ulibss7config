//
//  UMSS7ConfigDiameterRouter.h
//  ulibss7config
//
//  Created by Andreas Fink on 27.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"


@interface UMSS7ConfigDiameterRouter : UMSS7ConfigObject
{
    NSString *_localHostName;
    NSString *_localRealm;
    NSString *_statisticDbPool;
    NSString *_statisticDbTable;
    NSString *_statisticDbInstance;
    NSNumber *_statisticDbAutocreate;
    NSString *_screeningDiameterPluginName;
    NSString *_screeningDiameterPluginConfigFile;
    NSString *_screeningDiameterPluginTraceFile;
}

@property(readwrite,strong,atomic)  NSString *localHostName;
@property(readwrite,strong,atomic)  NSString *localRealm;
@property(readwrite,strong,atomic)  NSString *statisticDbPool;
@property(readwrite,strong,atomic)  NSString *statisticDbTable;
@property(readwrite,strong,atomic)  NSString *statisticDbInstance;
@property(readwrite,strong,atomic)  NSNumber *statisticDbAutocreate;
@property(readwrite,strong,atomic)  NSString *screeningDiameterPluginName;
@property(readwrite,strong,atomic)  NSString *screeningDiameterPluginConfigFile;
@property(readwrite,strong,atomic)  NSString *screeningDiameterPluginTraceFile;


+ (NSString *)type;
- (NSString *)type;

- (UMSS7ConfigDiameterRouter *)initWithConfig:(NSDictionary *)dict;

@end

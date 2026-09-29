//
//  UMSS7ConfigSMSLog.h
//  ulibss7config
//
//  Created by Andreas Fink on 04.04.2024.
//  Copyright © 2024 Andreas Fink. All rights reserved.
//

#import <ulibss7config/ulibss7config.h>


@interface UMSS7ConfigSMSLog : UMSS7ConfigObject
{
    NSString *_zmqListener;
    NSString *_dbPool;
    NSString *_dbTable;
}
@property(readwrite,strong,atomic)     NSString *zmqListener;
@property(readwrite,strong,atomic)     NSString *dbPool;
@property(readwrite,strong,atomic)     NSString *dbTable;

+ (NSString *)groupName;
- (NSString *)groupName;

@end


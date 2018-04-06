//
//  UMSS7ConfigGeneral.h
//  estp
//
//  Created by Andreas Fink on 09.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigGeneral : UMSS7ConfigObject
{
    NSString *_hostname;
    NSString *_logDirectory;
    NSNumber *_logRotations;
    NSString *_configStore;
    NSNumber *_concurrentTasks;
}

+ (NSString *)type;
- (NSString *)type;
- (UMSS7ConfigGeneral *)initWithConfig:(NSDictionary *)dict;

@property(readwrite,strong,atomic)  NSString *hostname;
@property(readwrite,strong,atomic)  NSString *logDirectory;
@property(readwrite,strong,atomic)  NSNumber *logRotations;
@property(readwrite,strong,atomic)  NSString *configStore;
@property(readwrite,strong,atomic)  NSNumber *concurrentTasks;


@end

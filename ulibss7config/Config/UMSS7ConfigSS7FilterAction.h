//
//  UMSS7ConfigSS7FilterAction.h
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigSS7FilterAction : UMSS7ConfigObject
{
    NSString *_action;
    NSString *_log;
    NSNumber *_error;
    NSString *_rerouteDestination;
    NSString *_rerouteCalledAddress;
    NSString *_rerouteCalledAddressPrefix;
    NSNumber *_reroute_tt;
    NSString *_tag;
    NSString *_variable;
    NSString *_value;
    NSString *_statisticName;
    NSString *_statisticKey;
    NSString *_userDescription;
    NSDate  *_createdTimestamp;
    NSDate  *_modifiedTimestamp;
}

@property(readwrite,strong,atomic)  NSString *action;
@property(readwrite,strong,atomic)  NSString *log;
@property(readwrite,strong,atomic)  NSNumber *error;
@property(readwrite,strong,atomic)  NSString *rerouteDestination;
@property(readwrite,strong,atomic)  NSString *rerouteCalledAddress;
@property(readwrite,strong,atomic)  NSString *rerouteCalledAddressPrefix;
@property(readwrite,strong,atomic)  NSNumber *reroute_tt;
@property(readwrite,strong,atomic)  NSString *tag;
@property(readwrite,strong,atomic)  NSString *userDescription;
@property(readwrite,strong,atomic)  NSString *variable;
@property(readwrite,strong,atomic)  NSString *value;
@property(readwrite,strong,atomic)  NSString *statisticName;
@property(readwrite,strong,atomic)  NSString *statisticKey;
@property(readwrite,strong,atomic)  NSDate *createdTimestamp;
@property(readwrite,strong,atomic)  NSDate *modifiedTimestamp;

@end


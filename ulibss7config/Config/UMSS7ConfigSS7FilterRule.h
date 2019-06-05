//
//  UMSS7ConfigSS7FilterRule.h
//  ulibss7config
//
//  Created by Andreas Fink on 17.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"


@interface UMSS7ConfigSS7FilterRule : UMSS7ConfigObject
{
	NSString *_filterSet;
	NSString *_status;
	NSString *_engine;
	NSString *_passAction;
	NSString *_dropAction;
	NSString *_rerouteAction;
	NSString *_logAction;
	NSString *_engineConfig;
    NSDate                 *_createdTimestamp;
    NSDate                 *_modifiedTimestamp;

}

@property(readwrite,strong,atomic)	NSString *filterSet;
@property(readwrite,strong,atomic)	NSString *status;
@property(readwrite,strong,atomic)	NSString *engine;
@property(readwrite,strong,atomic)	NSString *passAction;
@property(readwrite,strong,atomic)	NSString *dropAction;
@property(readwrite,strong,atomic)	NSString *rerouteAction;
@property(readwrite,strong,atomic)	NSString *logAction;
@property(readwrite,strong,atomic)	NSString *engineConfig;
@property(readwrite,strong,atomic)    NSDate *createdTimestamp;
@property(readwrite,strong,atomic)    NSDate *modifiedTimestamp;

@end


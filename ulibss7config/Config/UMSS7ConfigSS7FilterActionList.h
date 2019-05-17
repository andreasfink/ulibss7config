//
//  UMSS7ConfigSS7FilterActionList.h
//  ulibss7config
//
//  Created by Andreas Fink on 17.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigSS7FilterActionList : UMSS7ConfigObject
{
	NSString *_action;
	NSString *_log;
	NSNumber *_error;
	NSString *_rerouteDestination;
	NSString *_rerouteCalledAddress;
	NSString *_rerouteCalledAddressPrefix;
	NSString *_category;
	NSString *_userDescription;
}

@property(readwrite,strong,atomic)	NSString *action;
@property(readwrite,strong,atomic)	NSString *log;
@property(readwrite,strong,atomic)	NSNumber *error;
@property(readwrite,strong,atomic)	NSString *rerouteDestination;
@property(readwrite,strong,atomic)	NSString *rerouteCalledAddress;
@property(readwrite,strong,atomic)	NSString *rerouteCalledAddressPrefix;
@property(readwrite,strong,atomic)	NSString *category;
@property(readwrite,strong,atomic)	NSString *userDescription;

@end


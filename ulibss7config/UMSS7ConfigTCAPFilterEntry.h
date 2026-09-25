//
//  UMSS7ConfigTCAPFilterEntry.h
//  estp
//
//  Created by Andreas Fink on 10.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import <ulibss7config/UMSS7ConfigObject.h>

@interface UMSS7ConfigTCAPFilterEntry : UMSS7ConfigObject
{
    NSString *_filter;
    NSString *_command;
    NSString *_operation;
    NSArray *_applicationContexts;
    NSString *_result;
}


@property(readwrite,strong,atomic)      NSString *filter;
@property(readwrite,strong,atomic)      NSString *command;
@property(readwrite,strong,atomic)      NSString *operation;
@property(readwrite,strong,atomic)      NSArray *applicationContexts;
@property(readwrite,strong,atomic)      NSString *result;

+ (NSString *)groupName;
- (NSString *)groupName;
- (UMSS7ConfigTCAPFilterEntry *)initWithConfig:(NSDictionary *)dict;

@end

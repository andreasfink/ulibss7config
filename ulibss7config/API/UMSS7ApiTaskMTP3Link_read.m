//
//  UMSS7ApiTaskMTP3Link_read.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskMTP3Link_read.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigMTP3Link.h"

@implementation UMSS7ApiTaskMTP3Link_read

+ (NSString *)apiPath
{
    return @"/api/mtp3-link-read";
}

- (void)main
{
    if(![self isAuthenticated])
    {
        [self sendErrorNotAuthenticated];
        return;
    }
    NSString *name = _webRequest.params[@"name"];
    UMSS7ConfigStorage *cs = [_appDelegate runningConfig];
    UMSS7ConfigMTP3Link *obj = [cs getMTP3Link:name];
    if(obj)
    {
        [self sendResultObject:obj.config];
    }
    else
    {
        [self sendErrorNotFound];
    }
}

@end



//
//  UMSS7ApiTaskMTP3Link_list.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//


#import "UMSS7ApiTaskMTP3Link_list.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"

@implementation UMSS7ApiTaskMTP3Link_list

+ (NSString *)apiPath
{
    return @"/api/mtp3-link-list";
}

- (void)main
{
    if(![self isAuthenticated])
    {
        [self sendErrorNotAuthenticated];
        return;
    }
    UMSS7ConfigStorage *cs = [_appDelegate runningConfig];
    NSArray *names = [cs getMTP3LinkNames];
    [self sendResultObject:names];
}

@end

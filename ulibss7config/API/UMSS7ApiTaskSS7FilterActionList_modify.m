//
//  UMSS7ApiTaskSS7FilterActionList_modify.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSS7FilterActionList_modify.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSS7FilterActionList.h"
#import "UMSS7ConfigStorage.h"

@implementation UMSS7ApiTaskSS7FilterActionList_modify

+ (NSString *)apiPath
{
    return @"/api/ss7-filter-action-list-modify";
}

- (void)main
{
    if(![self isAuthenticated])
    {
        [self sendErrorNotAuthenticated];
        return;
    }
    
    if(![self isAuthorized])
    {
        [self sendErrorNotAuthorized];
        return;
    }
    [self sendErrorNotImplemented];
}

@end

//
//  UMSS7ApiTaskMTP3LinkSet_read.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskMTP3LinkSet_read.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigMTP3LinkSet.h"

@implementation UMSS7ApiTaskMTP3LinkSet_read

+ (NSString *)apiPath
{
    return @"/api/mtp3-linkset-read";
}

- (void)main
{
    @autoreleasepool
    {
        if(![self isAuthenticated])
        {
            [self sendErrorNotAuthenticated];
            return;
        }
        
        if(![self isAuthorised])
        {
            [self sendErrorNotAuthorised];
            return;
        }

        NSString *name = _params[@"name"];
        UMSS7ConfigStorage *cs = [_appDelegate runningConfig];
        UMSS7ConfigMTP3LinkSet *obj = [cs getMTP3LinkSet:name];
        if(obj)
        {
            [self sendResultObject:obj.config];
        }
        else
        {
            [self sendErrorNotFound];
        }
    }
}

@end



//
//  UMSS7ApiTaskM3UAASP_read.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskM3UAASP_read.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigM3UAASP.h"

@implementation UMSS7ApiTaskM3UAASP_read

+ (NSString *)apiPath
{
    return @"/api/m3ua-asp-read";
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
        UMSS7ConfigM3UAASP *obj = [cs getM3UAASP:name];
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



//
//  UMSS7ApiTaskM3UAASP_status.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskM3UAASP_status.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigStorage.h"
#import <ulibmtp3/ulibmtp3.h>

@implementation UMSS7ApiTaskM3UAASP_status

+ (NSString *)apiPath
{
    return @"/api/m3ua-asp-status";
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
        name = [UMSS7ConfigObject filterName:name];
        UMM3UAApplicationServerProcess *asp = [_appDelegate getM3UAASP:name];
        if(asp)
        {
            UMSynchronizedSortedDictionary *dict = [asp m3uaStatusDict];
            [self sendResultObject:dict];
        }
        else
        {
            [self sendErrorNotFound];
        }
    }
}
@end

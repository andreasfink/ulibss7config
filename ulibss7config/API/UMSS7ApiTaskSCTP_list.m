//
//  UMSS7ApiTaskSCTP_list.m
//  estp
//
//  Created by Andreas Fink on 12.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSCTP_list.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigSCTP.h"
@implementation UMSS7ApiTaskSCTP_list

+ (NSString *)apiPath
{
    return @"/api/sctp-list";
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

    UMSS7ConfigStorage *cs = [_appDelegate runningConfig];
    NSArray *names = [cs getSCTPNames];

    int details = [((NSString *)_params[@"details"]) intValue];
    switch(details)
    {
         case 0:
             [self sendResultObject:names];
             break;
         case 1:
         case 2:
             {
                 NSMutableArray *entries = [[NSMutableArray alloc]init];
                 for(NSString *name in names)
                 {
                     UMSS7ConfigSCTP *obj = [cs getSCTP:name];
                     if(obj)
                     {
                         [entries addObject:obj.config];
                     }
                 }
                 [self sendResultObject:entries];
             }
             break;
    }
}

@end

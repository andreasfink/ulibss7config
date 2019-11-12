//
//  UMSS7ApiTaskMTP3LinkSet_list.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskMTP3LinkSet_list.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigMTP3LinkSet.h"
#import "UMSS7ApiTaskMacros.h"

@implementation UMSS7ApiTaskMTP3LinkSet_list

+ (NSString *)apiPath
{
    return @"/api/mtp3-linkset-list";
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
    NSArray *names = [cs getMTP3LinkSetNames];

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
                     UMSS7ConfigMTP3LinkSet *obj = [cs getMTP3LinkSet:name];
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


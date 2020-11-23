//
//  UMSS7ApiTaskApiUser_list.m
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskApiUser_list.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigApiUser.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ApiTaskMacros.h"

@implementation UMSS7ApiTaskApiUser_list



+ (NSString *)apiPath
{
    return @"/api/apiuser-list";
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

        if(![self isAuthorized])
        {
            [self sendErrorNotAuthorized];
            return;
        }

        UMSS7ConfigStorage *cs = [_appDelegate runningConfig];
        NSArray *names = [cs getApiUserNames];


        int details = [((NSString *)_params[@"details"]) intValue];
        switch(details)
        {
             case 0:
             default:
                 [self sendResultObject:names];
                 break;
             case 1:
                {
                    NSMutableArray *entries = [[NSMutableArray alloc]init];
                    for(NSString *name in names)
                    {
                        UMSS7ConfigApiUser *obj = [cs getApiUser:name];
                        if(obj)
                        {
                            UMSynchronizedSortedDictionary *dict = [[UMSynchronizedSortedDictionary alloc]init];
                            SET_DICT_STRING_OR_EMPTY(dict,@"name",obj.name);
                            SET_DICT_STRING_OR_EMPTY(dict,@"profile",obj.profile);
                            [entries addObject:dict];
                        }
                    }
                    [self sendResultObject:entries];
                }
                break;
             case 2:
                 {
                     NSMutableArray *entries = [[NSMutableArray alloc]init];
                     for(NSString *name in names)
                     {
                         UMSS7ConfigApiUser *obj = [cs getApiUser:name];
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
}

@end

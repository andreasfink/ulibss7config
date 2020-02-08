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
        case 3:
            {
                NSMutableArray *entries = [[NSMutableArray alloc]init];
                for(NSString *name in names)
                {
                    UMSS7ConfigMTP3LinkSet *obj = [cs getMTP3LinkSet:name];
                    if(obj)
                    {
                        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
                        dict[@"config"] = obj.config;
                        UMMTP3LinkSet *mtp3LinkSet = [_appDelegate getMTP3LinkSet:name];
                        if(mtp3LinkSet)
                        {
                            NSMutableDictionary *sdict = [[NSMutableDictionary alloc]init];
                            sdict[@"active-links"] = @(mtp3LinkSet.activeLinks);
                            sdict[@"inactive-links"] = @(mtp3LinkSet.inactiveLinks);
                            sdict[@"ready-links"] = @(mtp3LinkSet.readyLinks);
                            sdict[@"total-links"] = @(mtp3LinkSet.totalLinks);
                            sdict[@"congestion-level"] = @(mtp3LinkSet.congestionLevel);
                            sdict[@"speed"] = @(mtp3LinkSet.speed);
                            sdict[@"trw-received"] = @(mtp3LinkSet.trw_received);
                            sdict[@"tra-sent"] = @(mtp3LinkSet.tra_sent);
                            dict[@"status"] = sdict;

                            dict[@"action"] =
                            @[ @"add-link",
                               @"remove-link",
                               @"power-on",
                               @"power-off",
                               @"start-slc",
                               @"stop-slc"];
                        }
                        [entries addObject:dict];
                    }
                }
                [self sendResultObject:entries];
            }
            break;
     }
}

@end


//
//  UMSS7ApiTaskM3UAAS_list.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//



#import "UMSS7ApiTaskM3UAAS_list.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigM3UAAS.h"

@implementation UMSS7ApiTaskM3UAAS_list

+ (NSString *)apiPath
{
    return @"/api/m3ua-as-list";
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

        UMSS7ConfigStorage *cs = [_appDelegate runningConfig];
        NSArray *names = [cs getM3UAASNames];
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
                        UMSS7ConfigM3UAAS *obj = [cs getM3UAAS:name];
                        if(obj)
                        {
                            [entries addObject:obj.config];
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
                        UMSS7ConfigM3UAAS *obj = [cs getM3UAAS:name];
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
                        UMSS7ConfigM3UAAS *obj = [cs getM3UAAS:name];
                        if(obj)
                        {
                            NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
                            dict[@"config"] = obj.config;
                            UMM3UAApplicationServer  *m3ua_as = [_appDelegate getM3UAAS:name];
                            if(m3ua_as)
                            {
                                NSMutableDictionary *sdict = [[NSMutableDictionary alloc]init];
                                sdict[@"active-links"] = @(m3ua_as.activeLinks);
                                sdict[@"inactive-links"] = @(m3ua_as.inactiveLinks);
                                sdict[@"ready-links"] = @(m3ua_as.readyLinks);
                                sdict[@"total-links"] = @(m3ua_as.totalLinks);
                                sdict[@"congestion-level"] = @(m3ua_as.congestionLevel);
                                sdict[@"speed"] = @(m3ua_as.speed);
                                sdict[@"trw-received"] = @(m3ua_as.trw_received);
                                sdict[@"tra-sent"] = @(m3ua_as.tra_sent);
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
}

@end

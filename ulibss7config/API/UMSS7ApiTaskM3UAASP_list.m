//
//  UMSS7ApiTaskM3UAASP_list.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskM3UAASP_list.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigM3UAASP.h"

@implementation UMSS7ApiTaskM3UAASP_list

+ (NSString *)apiPath
{
    return @"/api/m3ua-asp-list";
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
        
        UMSS7ConfigStorage *cs = [_appDelegate runningConfig];
        NSArray *names = [cs getM3UAASPNames];
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
                        UMSS7ConfigM3UAASP *obj = [cs getM3UAASP:name];
                        if(obj)
                        {
                            [entries addObject:obj];
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
                        UMSS7ConfigM3UAASP *obj = [cs getM3UAASP:name];
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
                         UMSS7ConfigM3UAASP *obj = [cs getM3UAASP:name];
                         if(obj)
                         {
                             NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
                             dict[@"config"] = obj.config;
                             UMM3UAApplicationServerProcess  *m3ua_asp = [_appDelegate getM3UAASP:name];
                             if(m3ua_asp)
                             {
                                 NSMutableDictionary *sdict = [[NSMutableDictionary alloc]init];
                                 sdict[@"status"] = m3ua_asp.statusString;
                                 sdict[@"congested"] = @(m3ua_asp.congested);
                                 sdict[@"current-speed"] = m3ua_asp.speedometer.getSpeedTripleJson;
                                 sdict[@"standby"] = @(m3ua_asp.standby_mode);
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

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

@implementation UMSS7ApiTaskM3UAASP_list

+ (NSString *)apiPath
{
    return @"/api/m3ua-asp-list";
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
    NSArray *names = [cs getM3UAASPNames];
    int details = [((NSString *)_params[@"details"]) intValue];
    switch(details)
    {
        case 0:
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
                        [entries addObject:obj];
                    }
                }
                [self sendResultObject:entries];
            }
            break;
    }
}

@end

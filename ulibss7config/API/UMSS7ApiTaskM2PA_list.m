//
//  UMSS7ApiTaskM2PA_list.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskM2PA_list.h"
#import "UMSS7ConfigStorage.h"

@implementation UMSS7ApiTaskM2PA_list

+ (NSString *)apiPath
{
    return @"/api/m2pa-list";
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
        NSArray *names = [cs getM2PANames];

        
        
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
                        UMSS7ConfigM2PA *obj = [cs getM2PA:name];
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
                        UMSS7ConfigM2PA *obj = [cs getM2PA:name];
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
}

@end

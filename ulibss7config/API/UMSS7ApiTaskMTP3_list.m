//
//  UMSS7ApiTaskMTP3_list.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskMTP3_list.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigMTP3.h"
#import "UMSS7ApiTaskMacros.h"

@implementation UMSS7ApiTaskMTP3_list

+ (NSString *)apiPath
{
    return @"/api/mtp3-list";
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
        NSArray *names = [cs getMTP3Names];

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
                        UMSS7ConfigMTP3 *obj = [cs getMTP3:name];
                        if(obj)
                        {
                            UMSynchronizedSortedDictionary *dict = [[UMSynchronizedSortedDictionary alloc]init];
                            if(obj.name.length == 0)
                            {
                                continue;
                            }
                            SET_DICT_NUMBER_OR_ZERO(dict,@"name",obj.name);
                            SET_DICT_NUMBER_OR_ZERO(dict,@"enable",obj.enabled);
                            SET_DICT_NUMBER_OR_ZERO(dict,@"log-level",obj.logLevel);
                            SET_DICT_STRING_OR_EMPTY(dict,@"log-file",obj.logFile);
                            SET_DICT_STRING_OR_EMPTY(dict,@"variant",obj.mode);
                            SET_DICT_STRING_OR_EMPTY(dict,@"ni",obj.networkIndicator);
                            SET_DICT_STRING_OR_EMPTY(dict,@"opc",obj.opc);
                            SET_DICT_STRING_OR_DEFAULT(dict,@"mode",obj.mode,@"stp");
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
                        UMSS7ConfigMTP3 *obj = [cs getMTP3:name];
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

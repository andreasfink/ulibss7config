//
//  UMSS7ApiTaskMTP3PointCodeTranslationTable_add.m
//  ulibss7config
//
//  Created by Andreas Fink on 04.11.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskMTP3PointCodeTranslationTable_add.h"
#import "UMSS7ConfigMTP3PointCodeTranslationTable.h"
#import "UMSS7ConfigStorage.h"

@implementation UMSS7ApiTaskMTP3PointCodeTranslationTable_add

+ (NSString *)apiPath
{
    return @"/api/mtp3-pointcode-translation-table-add";
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
        UMSS7ConfigStorage *cs = [_appDelegate runningConfig];
        UMSS7ConfigMTP3PointCodeTranslationTable *pctt = [cs getPointcodeTranslationTable:name];
        if(pctt!=NULL)
        {
            [self sendErrorAlreadyExisting];
        }
        else
        {
            @try
            {
                pctt = [[UMSS7ConfigMTP3PointCodeTranslationTable alloc]initWithConfig:_params];
                UMSynchronizedSortedDictionary *config = pctt.config;
                [_appDelegate addWithConfigMTP3PointCodeTranslationTable:config.dictionaryCopy];
                [self sendResultObject:config];
            }
            @catch(NSException *e)
            {
                [self sendException:e];
            }
        }
    }
}

@end

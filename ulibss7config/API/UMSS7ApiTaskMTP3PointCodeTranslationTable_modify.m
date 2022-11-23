//
//  UMSS7ApiTaskMTP3PointCodeTranslationTable_modify.m
//  ulibss7config
//
//  Created by Andreas Fink on 04.11.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskMTP3PointCodeTranslationTable_modify.h"
#import "UMSS7ConfigMTP3PointCodeTranslationTable.h"
#import "UMSS7ConfigStorage.h"

@implementation UMSS7ApiTaskMTP3PointCodeTranslationTable_modify

+ (NSString *)apiPath
{
    return @"/api/mtp3-pointcode-translation-table-modify";
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
        UMSS7ConfigMTP3PointCodeTranslationTable *pctt_conf = [cs getPointcodeTranslationTable:name];
        if(pctt_conf==NULL)
        {
            [self sendErrorNotFound];
        }
        else
        {
            @try
            {
                [cs replacePointcodeTranslationTable:pctt_conf];
                [_appDelegate addWithConfigMTP3PointCodeTranslationTable:pctt_conf.config.dictionaryCopy];
                [self sendResultObject:pctt_conf.config];
            }
            @catch(NSException *e)
            {
                [self sendException:e];
            }
        }
    }
}

@end

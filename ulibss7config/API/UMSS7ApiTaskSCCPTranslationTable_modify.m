//
//  UMSS7ApiTaskSCCPTranslationTable_modify.m
//  estp
//
//  Created by Andronikos Stathis on 05.09.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskSCCPTranslationTable_modify.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigSCCP.h"
#import "UMSS7ConfigSCCPTranslationTable.h"

@implementation UMSS7ApiTaskSCCPTranslationTable_modify
+ (NSString *)apiPath
{
    return @"/api/sccp-translation-table-modify";
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

        NSString *name = _params[@"name"];
        name = [UMSS7ConfigObject filterName:name];
        UMSS7ConfigStorage *cs = [_appDelegate runningConfig];
        
        UMLayerSCCP *instance = [_appDelegate getSCCP:name];
        UMSS7ConfigSCCPTranslationTable *co = [cs getSCCPTranslationTable:name];
        if(co==NULL || instance==NULL)
        {
            [self sendErrorNotFound];
        }
        else
        {
            @try
            {
                // Find from sccp layer the old RoutingTable  by _gti, _np, _nai, _tt
                UMSynchronizedSortedDictionary *oldCo = [_appDelegate readSCCPTranslationTable:name tt:co.tt gti:co.gti np:co.np nai:co.nai];
                UMSS7ConfigSCCPTranslationTable *newCo = [[UMSS7ConfigSCCPTranslationTable alloc]initWithConfig:_params];
                UMSynchronizedSortedDictionary *config = [_appDelegate modifySCCPTranslationTable:newCo.config.dictionaryCopy old:oldCo.dictionaryCopy];
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

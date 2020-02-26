//
//  UMSS7ApiTaskM2PA_delete.m
//  estp
//
//  Created by Andreas Fink on 13.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskM2PA_delete.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigStorage.h"
#import "UMSS7ConfigObject.h"
#import "UMSS7ConfigM2PA.h"

@implementation UMSS7ApiTaskM2PA_delete

+ (NSString *)apiPath
{
    return @"/api/m2pa-delete";
}

- (void)main
{
    if(![self isAuthenticated])
    {
        [self sendErrorNotAuthenticated];
        return;
    }
    NSString *name = _params[@"name"];
    name = [UMSS7ConfigObject filterName:name];
    UMSS7ConfigStorage *cs = [_appDelegate runningConfig];

    UMSS7ConfigM2PA *config_object = [cs getM2PA:name];
    UMLayerM2PA *instance = [_appDelegate getM2PA:name];
    if((instance!=NULL) || (config_object==NULL))
    {
        [self sendErrorNotFound];
    }
    else
    {
        [cs deleteM2PA:name];
        [_appDelegate deleteM2PA:name];
        [self sendResultOK];
    }
}
@end

//
//  UMSS7ApiTaskFilterName.m
//  estp
//
//  Created by Andreas Fink on 15.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskFilterName.h"
#import "UMSS7ConfigObject.h"

@implementation UMSS7ApiTaskFilterName

+ (NSString *)apiPath
{
    return @"/api/filter-name";
}

- (void)main
{
    NSString *name = _webRequest.params[@"name"];
    name = [UMSS7ConfigObject filterName:name];
    [self sendResultObject:name];
}

@end

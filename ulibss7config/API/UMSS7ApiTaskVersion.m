//
//  UMSS7ApiTaskVersion.m
//  estp
//
//  Created by Andreas Fink on 15.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ApiTaskVersion.h"
#import "UMSS7ConfigAppDelegateProtocol.h"
#import "UMSS7ConfigObject.h"

@implementation UMSS7ApiTaskVersion

+ (NSString *)apiPath
{
    return @"/api/version";
}

- (void)main
{
    @autoreleasepool
    {
        if([_appDelegate respondsToSelector:@selector(apiVersionDict)])
        {
            UMSynchronizedSortedDictionary *d = [_appDelegate apiVersionDict];
            [self sendResultObject:d];
        }
        else
        {
            [self sendResultObject:
             @{ @"api-version" : @"1.0.0",
                @"product-name": @"e-stp",
                @"product-version": @"1.0.0",
                @"authentication-required": @(YES),
                @"https-supported": @(YES),
                @"https-port": @(8083),
              }
             ];
        }
    }
}


@end

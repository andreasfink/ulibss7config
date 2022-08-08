//
//  UMSS7ConfigSCCPDestinationGroup.h
//  estp
//
//  Created by Andreas Fink on 08.03.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"
@class UMSS7ConfigSCCPDestinationEntry;

@interface UMSS7ConfigSCCPDestination : UMSS7ConfigObject
{
    NSString *_sccp;
    NSString *_postTranslation;
    NSString *_distributionMethod;
}

@property(readwrite,strong,atomic)  NSString *sccp;
@property(readwrite,strong,atomic)  NSString *postTranslation;
@property(readwrite,strong,atomic)  NSString *distributionMethod;

+ (NSString *)type;
- (NSString *)type;

- (UMSS7ConfigSCCPDestination *)initWithConfig:(NSDictionary *)dict;

@end

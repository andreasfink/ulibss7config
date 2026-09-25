//
//  UMSS7ConfigIMSIPool.h
//  ulibss7config
//
//  Created by Andreas Fink on 16.07.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import <ulibss7config/UMSS7ConfigObject.h>

@interface UMSS7ConfigIMSIPool : UMSS7ConfigObject
{
    NSString *_imsiPrefix;
    NSNumber *_cacheTimer;
}


@property(readwrite,strong,atomic)   NSString *imsiPrefix;
@property(readwrite,strong,atomic)   NSNumber *cacheTimer;


+ (NSString *)groupName;
- (NSString *)groupName;
- (UMSS7ConfigIMSIPool *)initWithConfig:(NSDictionary *)dict;

@end

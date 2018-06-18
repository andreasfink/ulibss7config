//
//  UMSS7ConfigMAPI.h
//  ulibss7config
//
//  Created by Andreas Fink on 18.06.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import <ulibss7config/ulibss7config.h>

@interface UMSS7ConfigMAPI : UMSS7ConfigObject
{
    NSString *_number;
    NSString *_licenseDirectory;
}

@property(readwrite,strong,atomic)   NSString *number;
@property(readwrite,strong,atomic)   NSString *licenseDirectory;


+ (NSString *)type;
- (NSString *)type;

- (UMSS7ConfigMAPI *)initWithConfig:(NSDictionary *)dict;
@end


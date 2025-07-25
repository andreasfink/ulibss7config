//
//  UMSS7ConfigTcapSharing.h
//  ulibss7config
//
//  Created by Andreas Fink on 11.07.2025.
//  Copyright © 2025 Andreas Fink. All rights reserved.
//

#import <ulibss7config/ulibss7config.h>

@interface UMSS7ConfigTcapSharing : UMSS7ConfigObject
{
    NSNumber    *_timeout;
    NSString    *_sccpName;
}
+ (NSString *)type;

@property(readwrite,strong,atomic)  NSNumber    *timeout;
@property(readwrite,strong,atomic)  NSString    *sccpName;

@end



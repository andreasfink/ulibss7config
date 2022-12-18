//
//  UMSS7ConfigMirrorPort.h
//  ulibss7config
//
//  Created by Andreas Fink on 09.05.22.
//  Copyright © 2022 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigMirrorPort : UMSS7ConfigObject
{
    NSString *_interfaceName;
    NSString *_localMacAddress;
    NSString *_remoteMacAddress;
}
@property(readwrite,strong,atomic)     NSString *interfaceName;

+ (NSString *)type;
- (NSString *)type;

@end

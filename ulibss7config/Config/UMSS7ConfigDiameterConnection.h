//
//  UMSS7ConfigDiameterConnection.h
//  ulibss7config
//
//  Created by Andreas Fink on 23.04.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"


@interface UMSS7ConfigDiameterConnection : UMSS7ConfigObject
{
    NSString *_attachTo;
    NSString *_router;
}
@property(readwrite,strong,atomic)      NSString *attachTo;
@property(readwrite,strong,atomic)      NSString *router;

+ (NSString *)type;
- (NSString *)type;

- (UMSS7ConfigDiameterConnection *)initWithConfig:(NSDictionary *)dict;

@end


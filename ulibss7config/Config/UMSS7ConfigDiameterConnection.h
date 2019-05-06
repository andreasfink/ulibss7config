//
//  UMSS7ConfigDiameterConnection.h
//  ulibss7config
//
//  Created by Andreas Fink on 23.04.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import <ulibss7config/ulibss7config.h>


@interface UMSS7ConfigDiameterConnection : UMSS7ConfigObject
{
    NSString *_attachTo;
}
@property(readwrite,strong,atomic)      NSString *attachTo;

+ (NSString *)type;
- (NSString *)type;

- (UMSS7ConfigDiameterConnection *)initWithConfig:(NSDictionary *)dict;

@end


//
//  UMSS7ConfigDiameterRouter.h
//  ulibss7config
//
//  Created by Andreas Fink on 27.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"


@interface UMSS7ConfigDiameterRouter : UMSS7ConfigObject
{
    NSString *_localHostName;
    NSString *_localRealm;
}

+ (NSString *)type;
- (NSString *)type;

- (UMSS7ConfigDiameterRouter *)initWithConfig:(NSDictionary *)dict;

@end

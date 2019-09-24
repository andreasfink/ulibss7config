//
//  UMSS7ConfigGGSN.h
//  ulibss7config
//
//  Created by Andreas Fink on 24.09.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigGGSN : UMSS7ConfigObject
{
    NSString *_attachTo;
    NSNumber *_timeout;
    NSString *_number;
    NSNumber *_answerTranslationType;
}

@property(readwrite,strong,atomic)   NSString *attachTo;
@property(readwrite,strong,atomic)   NSNumber *timeout;
@property(readwrite,strong,atomic)   NSString *number;
@property(readwrite,strong,atomic)   NSNumber *answerTranslationType;

+ (NSString *)type;
- (NSString *)type;
- (UMSS7ConfigGGSN *)initWithConfig:(NSDictionary *)dict;
@end



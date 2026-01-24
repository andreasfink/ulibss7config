//
//  UMSS7ConfigGTMapEntry.h
//  ulibss7config
//
//  Created by Andreas Fink on 24.01.2026.
//  Copyright © 2026 Andreas Fink. All rights reserved.
//

#import <ulibss7config/UMSS7ConfigObject.h>


@interface UMSS7ConfigGTMapEntry : UMSS7ConfigObject
{
    NSString *_gtmap;
    NSString *_link;
    NSString *_calling_gt;
    NSNumber *_called_tt;
}

+ (NSString *)groupName;
- (NSString *)groupName;
- (UMSS7ConfigGTMapEntry *)initWithConfig:(NSDictionary *)dict;

@property(readwrite,strong,atomic)  NSString *link;
@property(readwrite,strong,atomic)  NSString *calling_gt;
@property(readwrite,strong,atomic)  NSNumber *called_tt;

@end

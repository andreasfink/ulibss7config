//
//  UMSS7ConfigMnpDatabase.h
//  ulibss7config
//
//  Created by Andreas Fink on 12.06.20.
//  Copyright © 2020 Andreas Fink. All rights reserved.
//

#import <ulibss7config/UMSS7ConfigObject.h>


@interface UMSS7ConfigMnpDatabase : UMSS7ConfigObject
{
    NSString *_dbPool;
    NSString *_dbTable;
}
@property(readwrite,strong,atomic)     NSString *dbPool;
@property(readwrite,strong,atomic)     NSString *dbTable;

+ (NSString *)groupName;
- (NSString *)groupName;

@end

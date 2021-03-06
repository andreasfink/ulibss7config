//
//  UMSS7ConfigESTP.h
//  ulibss7config
//
//  Created by Andreas Fink on 18.06.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigESTP : UMSS7ConfigObject
{
    NSString *_number;
    NSString *_sccp;
    NSString *_licenseDirectory;
    
    NSString *_gttAccountingDbPool;
    NSString *_gttAccountingTable;
    NSString *_gttAccountingPrefixesTable;
    NSString *_filterEngineDirectory;
}

@property(readwrite,strong,atomic)   NSString *number;
@property(readwrite,strong,atomic)   NSString *sccp;
@property(readwrite,strong,atomic)   NSString *licenseDirectory;
@property(readwrite,strong,atomic)   NSString *filterEngineDirectory;

@property(readwrite,strong,atomic)  NSString *gttAccountingDbPool;
@property(readwrite,strong,atomic)  NSString *gttAccountingTable;
@property(readwrite,strong,atomic)  NSString *gttAccountingPrefixesTable;

+ (NSString *)type;
- (NSString *)type;

- (UMSS7ConfigESTP *)initWithConfig:(NSDictionary *)dict;
@end


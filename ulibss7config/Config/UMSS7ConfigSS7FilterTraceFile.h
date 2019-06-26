//
//  UMSS7ConfigSS7FilterTraceFile.h
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigSS7FilterTraceFile : UMSS7ConfigObject
{
    NSString *_filename;
    NSString *_format;
    NSNumber *_minutes;
    NSNumber *_packets;
}

@property(readwrite,strong,atomic)  NSString *filename;
@property(readwrite,strong,atomic)  NSString *format;
@property(readwrite,strong,atomic)  NSNumber *minutes;
@property(readwrite,strong,atomic)  NSNumber *packets;

- (UMSS7ConfigSS7FilterTraceFile *)initWithConfig:(NSDictionary *)dict;

@end

 

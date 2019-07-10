//
//  UMDiameterGeneratorCMD.h
//  diameter-web-gen
//
//  Created by Andreas Fink on 09.07.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//


#import <ulib/ulib.h>

@interface UMDiameterGeneratorWeb : UMObject
{
    NSString *_prefix;
    NSString *_packet;
    NSString *_name;
    NSString *_human;
    NSString *_user;
    NSString *_date;

}


@property(readwrite,strong,atomic)  NSString *prefix;
@property(readwrite,strong,atomic)  NSString *packet;
@property(readwrite,strong,atomic)  NSString *name;
@property(readwrite,strong,atomic)  NSString *human;
@property(readwrite,strong,atomic)  NSString *user;
@property(readwrite,strong,atomic)  NSString *date;

- (NSString *)headerFile;
- (NSString *)methodFile;

@end


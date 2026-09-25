#if 0
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
    NSString *_calling_gt_msc;
    NSString *_calling_gt_vlr;
    NSString *_calling_gt_hlr;
    NSString *_calling_gt_gmlc;
    NSString *_calling_gt_eir;
    NSString *_calling_gt_gsmscf;
    NSString *_calling_gt_ggsn;
    NSString *_calling_gt_sgsn;
    NSNumber *_called_tt;
}

+ (NSString *)groupName;
- (NSString *)groupName;
- (UMSS7ConfigGTMapEntry *)initWithConfig:(NSDictionary *)dict;

@property(readwrite,strong,atomic)  NSString *link;
@property(readwrite,strong,atomic)  NSString *calling_gt;
@property(readwrite,strong,atomic)  NSNumber *called_tt;
@property(readwrite,strong,atomic)  NSString *calling_gt_msc;
@property(readwrite,strong,atomic)  NSString *calling_gt_vlr;
@property(readwrite,strong,atomic)  NSString *calling_gt_hlr;
@property(readwrite,strong,atomic)  NSString *calling_gt_gmlc;
@property(readwrite,strong,atomic)  NSString *calling_gt_eir;
@property(readwrite,strong,atomic)  NSString *calling_gt_gsmscf;
@property(readwrite,strong,atomic)  NSString *calling_gt_ggsn;
@property(readwrite,strong,atomic)  NSString *calling_gt_sgsn;


@end
#endif

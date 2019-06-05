//
//  UMSS7ConfigSS7FilterStagingArea.h
//  ulibss7config
//
//  Created by Andreas Fink on 21.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigSS7FilterStagingArea : UMSS7ConfigObject
{
    NSDate                 *_createdTimestamp;
    NSDate                 *_modifiedTimestamp;
}

@property(readwrite,strong)    NSDate   *createdTimestamp;
@property(readwrite,strong)    NSDate   *modifiedTimestamp;

@end


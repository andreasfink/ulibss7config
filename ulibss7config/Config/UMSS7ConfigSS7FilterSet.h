//
//  UMSS7ConfigSS7FilterSet.h
//  ulibss7config
//
//  Created by Andreas Fink on 17.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigSS7FilterSet : UMSS7ConfigObject
{
	NSString *_file;
}

@property(readwrite,strong,atomic)  NSString *file;

@end


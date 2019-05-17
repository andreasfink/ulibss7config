//
//  UMSS7ConfigSS7FilterEngine.h
//  ulibss7config
//
//  Created by Andreas Fink on 17.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import "UMSS7ConfigObject.h"

@interface UMSS7ConfigSS7FilterEngine : UMSS7ConfigObject
{
	NSString *_filename;
}

@property(readwrite,strong,atomic)	NSString *filename;

@end


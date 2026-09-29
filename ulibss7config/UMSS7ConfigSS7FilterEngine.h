//
//  UMSS7ConfigSS7FilterEngine.h
//  ulibss7config
//
//  Created by Andreas Fink on 17.05.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//

#import <ulibss7config/UMSS7ConfigObject.h>

@interface UMSS7ConfigSS7FilterEngine : UMSS7ConfigObject
{
	NSString *_filename;
    UMPluginHandler *_pluginHandler;
}

@property(readwrite,strong,atomic)	NSString *filename;

@end


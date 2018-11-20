//
//  OutputFormat.h
//  ulibss7config
//
//  Created by Andreas Fink on 20.11.18.
//  Copyright © 2018 Andreas Fink. All rights reserved.
//

typedef enum OutputFormat
{
    OutputFormat_json = 0,
    OutputFormat_dict = 1,
    OutputFormat_rest = 2,
    OutputFormat_xml  = 3,
    OutputFormat_none = -1,
} OutputFormat;

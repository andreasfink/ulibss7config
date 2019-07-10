//
//  UMDiameterGeneratorCMD.m
//  diameter-web-gen
//
//  Created by Andreas Fink on 09.07.19.
//  Copyright © 2019 Andreas Fink. All rights reserved.
//


#import "UMDiameterGeneratorWeb.h"


@implementation UMDiameterGeneratorWeb

- (NSString *)headerFile
{
    NSMutableString *s = [[NSMutableString alloc]init];
    [s appendString:@"//\n"];
    [s appendFormat:@"//  %@%@.h\n",_prefix,_name];
    [s appendString:@"//  ulibss7config\n"];
    [s appendString:@"//\n"];
    [s appendFormat:@"//  Created by %@ on %@\n",_user,_date];
    [s appendString:@"//  Copyright © 2019 Andreas Fink. All rights reserved.\n"];
    [s appendString:@"//\n"];
    [s appendString:@"\n"];
    [s appendString:@"#import \"DiameterGenericSession.h\"\n"];
    [s appendString:@"\n"];
    [s appendString:@"\n"];
    [s appendString:@"\n"];
    [s appendFormat:@"@interface %@%@ : DiameterGenericSession\n",_prefix,_name];
    [s appendString:@"\n"];
    [s appendString:@"@end\n"];
    [s appendString:@"\n"];
    [s appendString:@"\n"];
    return s;
}

- (NSString *)methodFile
{


    NSMutableString *s = [[NSMutableString alloc]init];
    [s appendString:@"//\n"];
    [s appendFormat:@"//  %@%@.m\n",_prefix,_name];
    [s appendString:@"//  ulibss7config\n"];
    [s appendString:@"//\n"];
    [s appendFormat:@"//  Created by %@ on %@\n",_user,_date];
    [s appendString:@"//  Copyright © 2019 Andreas Fink. All rights reserved.\n"];
    [s appendString:@"//\n"];
    [s appendString:@"\n"];
    [s appendFormat:@"#import \"%@%@.h\"\n",_prefix,_name];
    [s appendString:@"#import \"WebMacros.h\"\n"];
    [s appendString:@"#import <ulibdiameter/ulibdiameter.h>\n"];
    [s appendString:@"\n"];
    [s appendString:@"\n"];
    [s appendFormat:@"@implementation %@%@\n",_prefix,_name];
    [s appendString:@"\n"];
    [s appendString:@"\n"];
    [s appendString:@"- (NSString *)webTitle\n"];
    [s appendString:@"{\n"];
    [s appendFormat:@"    return @\"%@\";\n",_human];
    [s appendString:@"}\n"];
    [s appendString:@"\n"];
    [s appendString:@"\n"];
    [s appendString:@"- (void)webDiameterParameters:(NSMutableString *)s\n"];
    [s appendString:@"{\n"];
    [s appendFormat:@"    [self webApplicationParameters:s defaultApplicationId:[%@ defaultApplicationId] comment:NULL];\n",_packet];
    [s appendFormat:@"    [%@ webDiameterParameters:s];\n",_packet];
    [s appendString:@"}\n"];
    [s appendString:@"\n"];
    [s appendString:@"- (void)main\n"];
    [s appendString:@"{\n"];
    [s appendString:@"    @try\n"];
    [s appendString:@"    {\n"];
    [s appendFormat:@"        %@ *pkt = [[%@ alloc]init];\n",_packet,_packet];
    [s appendFormat:@"        [pkt setDictionaryValue:_req.params];\n"];
    [s appendString:@"        self.query = pkt;\n"];
    [s appendString:@"        [self submit];\n"];
    [s appendString:@"    }\n"];
    [s appendString:@"    @catch(NSException *e)\n"];
    [s appendString:@"    {\n"];
    [s appendString:@"        [self webException:e];\n"];
    [s appendString:@"    }\n"];
    [s appendString:@"}\n"];

    [s appendString:@"\n"];
    [s appendString:@"@end\n"];
    [s appendString:@"\n"];

    return s;
}


@end



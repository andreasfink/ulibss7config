//
//  main.m
//  trace-test
//
//  Created by Andreas Fink on 03.08.2025.
//  Copyright © 2025 Andreas Fink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ulibss7config/UMSS7TraceFile.h>

NSData *testMtp3Packet(void)
{
    UMASN1Sequence *s = [[UMASN1Sequence alloc]init];
    NSData *payload = s.berEncoded;
    SccpAddress *src = [[SccpAddress alloc]initWithHumanReadableString:@"+111" variant:UMMTP3Variant_ITU];
    SccpAddress *dst = [[SccpAddress alloc]initWithHumanReadableString:@"+111" variant:UMMTP3Variant_ITU];
    SCCP_ServiceClass pclass = SCCP_CLASS_BASIC;
    SCCP_Handling handling = SCCP_HANDLING_RETURN_ON_ERROR;
    UMMTP3PointCode *opc = [[UMMTP3PointCode alloc]initWitPc:1 variant:UMMTP3Variant_ITU];
    UMMTP3PointCode *dpc = [[UMMTP3PointCode alloc]initWitPc:2 variant:UMMTP3Variant_ITU];

    NSData *srcEncoded = [src encode:SCCP_VARIANT_ITU];
    NSData *dstEncoded = [dst encode:SCCP_VARIANT_ITU];

    NSMutableData *sccp_pdu = [[NSMutableData alloc]init];
    uint8_t header[5];
    header[0] = SCCP_UDT;
    header[1] = (pclass & 0x0F) ;
    if(handling == SCCP_HANDLING_RETURN_ON_ERROR)
    {
        header[1] |= 0x80;
    }
    header[2] = 3;
    header[3] = 3 + dstEncoded.length;
    header[4] = 3 + dstEncoded.length + srcEncoded.length;
    [sccp_pdu appendBytes:header length:5];
    [sccp_pdu appendByte:dstEncoded.length];
    [sccp_pdu appendData:dstEncoded];
    [sccp_pdu appendByte:srcEncoded.length];
    [sccp_pdu appendData:srcEncoded];
    [sccp_pdu appendByte:payload.length];
    [sccp_pdu appendData:payload];
    
    NSData *rawMtp3 = [UMLayerSCCP mtp3Wrap:sccp_pdu opc:opc dpc:dpc ni:0 si:MTP3_SERVICE_INDICATOR_SCCP];
    return rawMtp3;
}

int main(int argc, const char * argv[])
{
    @autoreleasepool
    {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        dict[@"name"] = @"test";
        
        UMSS7ConfigSS7TraceFile *config = [[UMSS7ConfigSS7TraceFile alloc]init];
        config.name = @"test";
        config.enabled = @(YES);
        config.filename = @"ss7-output";
        config.format = @"pcap";
        config.minutes = @(60);
        config.packets = @(1000);
        config.maxRotations = @(10);

        UMSS7TraceFile *f = [[UMSS7TraceFile alloc]initWithSS7Config:config defaultPath:@"/tmp"];
        [f open];
        [f traceComment:@"hello world"];
        NSData *data = testMtp3Packet();
        [f traceProblematicPdu: data options:@{@"timestamp": [NSDate date],
                                               @"linkset"  : @"the-linkset",
                                               @"error"    : @"no-error"}];
        [f close];
    }
    return 0;
}

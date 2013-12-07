//
//  ClientSocket.m
//  Honey
//
//  Created by Daisy on 13-12-1.
//  Copyright (c) 2013年 Daisy&Jack. All rights reserved.
//

#import "ClientSocket.h"
#import "PreDefine.h"
#import "FeedbackView.h"

@implementation ClientSocket
@synthesize delegate, hanlers;
kSingleton(ClientSocket)

- (void)startConnetSocket{
    clientSoket = [[GCDAsyncSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    NSString *host = socketHOST;
    uint16_t port = socketPORT;
    NSError *error;
    if (![clientSoket connectToHost:host onPort:port error:&error])
    {
        NSLog(@"Error connecting: %@", error);
    }
  //  [clientSoket readDataWithTimeout:-1 tag:0];
    [clientSoket readDataToLength:PACKET_HEADER_LEN withTimeout:-1 tag:PACKET_HEADER];
    hanlers = [[NSMutableDictionary alloc]init];
    FeedbackView *view;
    [hanlers setObject:view forKey:@"sss"];
    [[hanlers objectForKey:@"sss"] ssss];
    
    
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port{
    NSLog(@"socket:%p didConnectToHost:%@ port:%hu", sock, host, port);
}

- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(NSError *)err
{
	NSLog(@"socketDidDisconnect:%p withError: %@", sock, err);
}


- (void)socket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
	NSLog(@"socket:%p didWriteDataWithTag:%ld", sock, tag);
}


- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    if (tag == PACKET_HEADER) {
        NSUInteger len = [data length];
        if (len <PACKET_HEADER_LEN) {
            NSLog(@"坤哥救命啊，数据怎么有问题。。");
            return;
        }
        NSData *byteData =  [data subdataWithRange:NSMakeRange(0, PACKET_HEADER_LEN)];
        int index;
        for (index = 0; index<[byteData length]; index++) {
            unsigned char buffer;
            [byteData getBytes: &buffer range: NSMakeRange( index, 1 )];
            if (buffer == '*') {
                break;
            }
        }
        
        byteData =  [byteData subdataWithRange:NSMakeRange(0, index)];
        
        NSError *error = nil;
        NSDictionary *jsonDict =  [[NSDictionary alloc]init];
        jsonDict = [NSJSONSerialization JSONObjectWithData:byteData options:kNilOptions error:&error];
        
        if(error){
            NSLog(@"parse data fail with error %@", error);
        }
        int length = [[jsonDict objectForKey:@"len"]intValue];
        [clientSoket readDataToLength:length withTimeout:-1 tag:PACKET_BODY];
        
    }
    if (tag == PACKET_BODY) {
        
        
        
        [clientSoket readDataToLength:PACKET_HEADER_LEN withTimeout:-1 tag:PACKET_HEADER];
        
    }
    
}

- (void)sendNetworkPacket:(NSDictionary *)dicFeedback
{
    NSError *error = nil;
    NSData *content = [NSJSONSerialization dataWithJSONObject:dicFeedback options:kNilOptions error:&error];
    if (error != nil) {
        NSLog(@"parase json error : %@", error);
    }
    NSNumber *len = [NSNumber numberWithInt: [content length]];
    NSDictionary *length = @{@"len": len};
    NSData *header = [NSJSONSerialization dataWithJSONObject:length options:kNilOptions error:&error];
    if (error != nil) {
        NSLog(@"parase json error : %@", error);
    }
    
    NSMutableData *cData = [NSMutableData dataWithData:header];
    NSData *xData = [NSData dataWithBytes:[@"*" UTF8String] length:[@"*" lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
    for (; [cData length]<12; ) {
        [cData appendData:xData];
    }
    [cData appendData:content];
    [clientSoket writeData:cData withTimeout:-1 tag:0];
}
@end

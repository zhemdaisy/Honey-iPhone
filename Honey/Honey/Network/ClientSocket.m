//
//  ClientSocket.m
//  Honey
//
//  Created by Daisy on 13-12-1.
//  Copyright (c) 2013年 Daisy&Jack. All rights reserved.
//

#import "ClientSocket.h"
#import "PreDefine.h"


@implementation ClientSocket

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
	NSLog(@"socket:%p didReadData:withTag:%ld", sock, tag);
	
	NSString *httpResponse = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	
	NSLog(@"HTTP Response:\n%@", httpResponse);
	
}

- (void)sendNetworkPacket:(NSData *)data withTag:(long)tag
{
    [clientSoket writeData:data withTimeout:-1 tag:tag];
}
@end

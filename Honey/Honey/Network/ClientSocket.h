//
//  ClientSocket.h
//  Honey
//
//  Created by Daisy on 13-12-1.
//  Copyright (c) 2013年 Daisy&Jack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"
#import "SocketHandleProtocol.h"

@interface ClientSocket : NSObject
{
    GCDAsyncSocket *clientSoket;
}
@property(nonatomic, strong)NSMutableDictionary *hanlers;
@property(nonatomic, weak)id<SocketHandleProtocol> delegate;
+ (id)sharedInstance;
/**
 * @brief 连接IP 端口
 *
 */
- (void)startConnetSocket;
/**
 * @brief 发送数据
 *
 */
- (void)sendNetworkPacket:(NSDictionary *)packetDict;
@end

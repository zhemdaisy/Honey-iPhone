//
//  ClientSocket.h
//  Honey
//
//  Created by Daisy on 13-12-1.
//  Copyright (c) 2013年 Daisy&Jack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GCDAsyncSocket.h"

@interface ClientSocket : NSObject
{
    GCDAsyncSocket *clientSoket;
}
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
- (void)sendNetworkPacket:(NSData *)data withTag:(long)tag;
@end

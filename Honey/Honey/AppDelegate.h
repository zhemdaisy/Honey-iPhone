//
//  AppDelegate.h
//  Honey
//
//  Created by Daisy on 13-11-21.
//  Copyright (c) 2013年 Daisy&Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GCDAsyncSocket;
@class Reachability;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    GCDAsyncSocket *asyncSocket;
}

@property (nonatomic) Reachability *internetReachability;
@property (nonatomic) Reachability *hostReachability;

@property (strong, nonatomic) UIWindow *window;

@end

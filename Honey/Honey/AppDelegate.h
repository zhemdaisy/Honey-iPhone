//
//  AppDelegate.h
//  Honey
//
//  Created by Daisy on 13-11-21.
//  Copyright (c) 2013年 Daisy&Jack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Reachability;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic)Reachability *internetReachability;
@property (strong, nonatomic) UIWindow *window;

@end

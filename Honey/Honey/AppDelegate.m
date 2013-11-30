//
//  AppDelegate.m
//  Honey
//
//  Created by Daisy on 13-11-21.
//  Copyright (c) 2013年 Daisy&Jack. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "Reachability.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    LoginViewController *loginView =[[LoginViewController alloc]initWithNibName:@"LoginViewController" bundle:nil];
    // Override point for customization after application launch.
    self.window.rootViewController = loginView;
    self.window.backgroundColor = [UIColor clearColor];
    [self.window makeKeyAndVisible];
    
    self.internetReachability = [Reachability reachabilityForInternetConnection];
    [self.internetReachability startNotifier];

    self.hostReachability = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    [self.hostReachability startNotifier];
    
    [self updateInterfaceWithReachability:self.internetReachability];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    return YES;
}

- (void)updateInterfaceWithReachability:(Reachability *)reachability{
    NetworkStatus netStatus = [reachability currentReachabilityStatus];
    NSString *netWorkStatus = nil;
    if (netStatus == ReachableViaWiFi) {
        NSLog(@"file %s ,ReachableViaWiFi", __FILE__);
        netWorkStatus = @"ReachableViaWiFi";
    }
    if (netStatus == ReachableViaWWAN) {
         NSLog(@"file %s ,ReachableViaWWAN", __FILE__);
        netWorkStatus = @"ReachableViaWWAN";
    }
    if (netStatus == NotReachable) {
         NSLog(@"file %s ,NotReachable", __FILE__);
        netWorkStatus = @"无可用网络";
        UIAlertView *netWorkAlert = [[UIAlertView alloc]initWithTitle:@"温馨提示"
                                                              message:netWorkStatus
                                                             delegate:self
                                                    cancelButtonTitle:@"确认"
                                                    otherButtonTitles:nil,nil];
        [netWorkAlert show];
    }

}

- (void) reachabilityChanged:(NSNotification *)note
{
	Reachability* curReach = [note object];
	NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
	[self updateInterfaceWithReachability:curReach];
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

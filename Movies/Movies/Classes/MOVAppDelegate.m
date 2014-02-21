//
//  MOVAppDelegate.m
//  Movies
//
//  Created by Tristan Lopes on 21/02/2014.
//  Copyright (c) 2014 hotcandy. All rights reserved.
//

#import "MOVAppDelegate.h"
#import "MOVRootViewController.h"

#import "AFNetworkActivityLogger.h"

@implementation MOVAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [self setupApplication];

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    MOVRootViewController *rootViewController = MOVRootViewController.new;

    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    navigationController.navigationBarHidden = YES;
    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];

    return YES;
}

#pragma mark - Application Setup

- (void)setupApplication
{
    [self setupLiveStyles];
    [self setupNetworkLogging];
}

- (void)setupLiveStyles
{
#if TARGET_IPHONE_SIMULATOR
    NSString *absoluteFilePath = CASAbsoluteFilePath(@"../Styles/stylesheet.cas");
    [CASStyler defaultStyler].watchFilePath = absoluteFilePath;
#endif
}

- (void)setupNetworkLogging
{
#ifdef ENABLE_NETWORK_LOGGING
    [[AFNetworkActivityLogger sharedLogger] startLogging];
#ifdef ENABLE_NETWORK_LOGGING_VERBOSE
    [[AFNetworkActivityLogger sharedLogger] setLevel:AFLoggerLevelDebug];
#else
    [[AFNetworkActivityLogger sharedLogger] setLevel:AFLoggerLevelInfo];
#endif
#endif
}

@end

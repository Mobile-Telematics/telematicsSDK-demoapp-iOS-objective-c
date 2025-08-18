//
//  AppDelegate.m
//  TelematicsSDK
//
//  Created by DATA MOTION PTE. LTD. on 09.06.21.
//  Copyright © 2021 DATA MOTION PTE. LTD. All rights reserved.
//

#import "AppDelegate.h"
#import <TelematicsSDK//TelematicsSDK.h>

@interface AppDelegate () <RPSpeedLimitDelegate, RPTrackingStateListenerDelegate, RPAccuracyAuthorizationDelegate, RPLowPowerModeDelegate, RPLocationDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [RPEntry initializeSDK];
    
    [RPEntry instance].speedLimitDelegate = self;
    [RPEntry instance].trackingStateDelegate = self;
    [RPEntry instance].accuracyAuthorizationDelegate = self;
    [RPEntry instance].lowPowerModeDelegate = self;
    [RPEntry instance].locationDelegate = self;
    
    if ([self userIsAuthenticated]) {
        [RPEntry instance].virtualDeviceToken = [self getDeviceToken];
    } else {
        /// You can't set an empty device token.
        /// You must use removeVirtualDeviceToken method for logout from Raxel.
        [[RPEntry instance] removeVirtualDeviceToken];
    }

    [RPEntry instance].disableTracking = NO;
    [[RPEntry instance] application:application didFinishLaunchingWithOptions:launchOptions];
    return YES;
}

- (NSString *)getDeviceToken {
    /// You need to implement receiving your device token here.
    return @"DeviceToken";
}

- (BOOL)userIsAuthenticated {
    /// You need to implement user authentication checking.
    /// It shouldn't be a network request. It's enough to check stored device token.
    return YES;
}
        
#pragma mark - App Delegate Methods

- (void)application:(UIApplication *)application
handleEventsForBackgroundURLSession:(nonnull NSString *)identifier
  completionHandler:(nonnull void (^)(void))completionHandler {
    [[RPEntry instance] application:application
handleEventsForBackgroundURLSession:identifier
                  completionHandler:completionHandler];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    [[RPEntry instance] applicationDidReceiveMemoryWarning:application];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[RPEntry instance] applicationWillTerminate:application];
}

- (void)application:(UIApplication *)application
performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [[RPEntry instance] application:application
  performFetchWithCompletionHandler:^{
        completionHandler(UIBackgroundFetchResultNewData);
    }];
}

- (void)wrongAccuracyAuthorization {
    [self showNotificationWithTitle:@"Precise Location is off"
                               body:@"Your trips may be not recorded. Please, follow to App Settings=>Location=>Precise Location"
                      andIdentifier:@"wrongAccuracyAuthorization"];
}

- (void)lowPowerMode:(BOOL)state {
    if (state) {
        [self showNotificationWithTitle:@"Low Power Mode"
                                   body:@"Your trips may be not recorded. Please, follow to Settings=>Battery=>Low Power"
                          andIdentifier:@"lowPowerMode"];
    }
}

- (void)showNotificationWithTitle:(NSString*)title body:(NSString*)body andIdentifier:(NSString*)identifier {
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = title;
    content.body = body;
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1 repeats:NO];
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:trigger];
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:nil];
}

- (NSTimeInterval)timeThreshold {
    return 5;
}

- (double)speedLimit {
    return 100;
}

- (void)speedLimitNotification:(double)speedLimit
                         speed:(double)speed
                      latitude:(double)latitude
                     longitude:(double)longitude
                          date:(NSDate *)date {
    [self showNotificationWithTitle:@"Overspeed"
                               body:[NSString stringWithFormat:@"You speed is %f at lat: %f lon:%f", speed, latitude, longitude]
                      andIdentifier:@"overspeed"];
}

- (void)trackingStateChanged:(BOOL)state {
    NSString *body = @"Tracking Stopped";
    if (state) {
        body = @"Tracking Started";
    }
    [self showNotificationWithTitle:@"Tracking State"
                               body:body
                      andIdentifier:@"trackingStateChanged"];
}

- (void)onLocationChanged:(CLLocation *)location {
    NSLog(@"location = %@", location);
}

- (void)onNewEvents:(NSArray<RPEventPoint *> *)events {
    //TODO NEW EVENTS IF NEEDED
}

#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

@end

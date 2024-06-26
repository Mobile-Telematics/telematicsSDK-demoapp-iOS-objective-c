//
//  AppDelegate.m
//  TelematicsSDK
//
//  Created by DATA MOTION PTE. LTD. on 09.06.21.
//  Copyright © 2021 DATA MOTION PTE. LTD. All rights reserved.
//

#import "AppDelegate.h"
#import <RaxelPulse/RaxelPulse.h>
#import "Logger.h"

@interface AppDelegate () <RPSpeedLimitDelegate, RPTrackingStateListenerDelegate, RPAccuracyAuthorizationDelegate, RPLowPowerModeDelegate, RPLocationDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [RPEntry initializeWithRequestingPermissions:NO];
    //PAGE 1 WIZARD TEXT 1
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;

    NSString *page1_LBL1 = @"Attention Required!\n\n";
    NSString *page1_LBL2 = @"“Always While Using App”";
    NSString *page1_LBL_ALL1 = [NSString stringWithFormat:@"You will receive a popup shortly. This popup will ask you for access to your location even when you are not using the app.\n\nPlease, choose %@ for %@ to automatically detect when you start a trip.", page1_LBL2, @"DemoObjcApp"];

    NSString *page1_totalMainLbl1 = [NSString stringWithFormat:@"%@%@", page1_LBL1, page1_LBL_ALL1];
    
    NSMutableAttributedString *page1_completeText1 = [[NSMutableAttributedString alloc] initWithString:page1_totalMainLbl1];
    NSRange page1_LBL1_range = [page1_totalMainLbl1 rangeOfString:page1_LBL1];
    NSRange page1_LBL2_range = [page1_totalMainLbl1 rangeOfString:page1_LBL2];
    
    [page1_completeText1 setAttributes:@{
                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:16.f],
                                NSParagraphStyleAttributeName: paragraphStyle
                                } range:NSMakeRange(0, page1_completeText1.length)];
    [page1_completeText1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0f weight:UIFontWeightSemibold] range:page1_LBL1_range];
    [page1_completeText1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0f weight:UIFontWeightSemibold] range:page1_LBL2_range];

    //PAGE 1 WIZARD TEXT 2
    NSString *page1_LBL3 = @"Allow DemoObjcApp to access your location?\n\n";
    NSString *page1_LBL_ALL2 = [NSString stringWithFormat:@"We use location services for tracking your mileage. By enabling “Always while using App” on location, the app will be able to automatically determine when you have a drive."];
    
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = [UIImage imageNamed:@"map"];
    NSInteger width = (UIScreen.mainScreen.bounds.size.width * 75 / 100) - 10;
    NSInteger height = width * 350 / 1000;
    attachment.bounds = CGRectMake(0, 0, width, height);
    NSAttributedString *attrStringWithImage = [NSAttributedString attributedStringWithAttachment:attachment];
    
    NSString *page1_totalMainLbl2 = [NSString stringWithFormat:@"%@%@", page1_LBL3, page1_LBL_ALL2];

    NSMutableAttributedString *page1_completeText2 = [[NSMutableAttributedString alloc] initWithString:page1_totalMainLbl2];
    NSRange page1_LBL3_range = [page1_totalMainLbl2 rangeOfString:page1_LBL3];
    [page1_completeText2 setAttributes:@{
                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:16.f],
                                NSForegroundColorAttributeName: [UIColor darkGrayColor],
                                NSParagraphStyleAttributeName: paragraphStyle
                                } range:NSMakeRange(0, page1_completeText2.length)];
    [page1_completeText2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0f weight:UIFontWeightSemibold] range:page1_LBL3_range];
    
    [page1_completeText2 appendAttributedString:attrStringWithImage];
    //PAGE 1 WIZARD BUTTONS
    NSMutableAttributedString *page1_firstButton = [[NSMutableAttributedString alloc] initWithString:@"Always While Using App"];
    NSMutableAttributedString *page1_secondButton = [[NSMutableAttributedString alloc] initWithString:@"Allow Once"];
    NSMutableAttributedString *page1_thirdButton = [[NSMutableAttributedString alloc] initWithString:@"Don't Allow"];
    NSMutableArray *page1_buttonsList = [[NSMutableArray alloc] initWithObjects:page1_firstButton, page1_secondButton, page1_thirdButton, nil];


    //PAGE 2 WIZARD TEXT 1
    NSString *page2_LBL1 = @"Attention Required!\n\n";
    NSString *page2_LBL2 = @"“OK“";
    NSString *page2_LBL_ALL1 = [NSString stringWithFormat:@"Then, You will receive a popup to grant us access to your Motion & Fitness activity. We need this information to create a driving score.\n\nPlease, choose %@ for %@ to grant us access to Motion & Fitness activity.", page2_LBL2,  @"DemoObjcApp"];

    NSString *page2_totalMainLbl1 = [NSString stringWithFormat:@"%@%@", page2_LBL1, page2_LBL_ALL1];

    NSMutableAttributedString *page2_completeText1 = [[NSMutableAttributedString alloc] initWithString:page2_totalMainLbl1];
    NSRange page2_LBL1_range = [page2_totalMainLbl1 rangeOfString:page2_LBL1];
    NSRange page2_LBL2_range = [page2_totalMainLbl1 rangeOfString:page2_LBL2];
    [page2_completeText1 setAttributes:@{
                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:16.f],
                                NSParagraphStyleAttributeName: paragraphStyle
                                } range:NSMakeRange(0, page2_completeText1.length)];
    [page2_completeText1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0f weight:UIFontWeightSemibold] range:page2_LBL1_range];
    [page2_completeText1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0f weight:UIFontWeightSemibold] range:page2_LBL2_range];

    //PAGE 2 WIZARD TEXT 2
    NSString *page2_LBL_ALL3 = [NSString stringWithFormat:@"%@ Would Like to Access Your Motion & Fitness Activity", @"DemoObjcApp"];
    NSString *page2_LBL_ALL = [NSString stringWithFormat:@"%@\n\nWe use motion sensors for evaluating your driving manner", page2_LBL_ALL3];

    NSString *page2_totalMainLbl2 = [NSString stringWithFormat:@"%@", page2_LBL_ALL];

    NSMutableAttributedString *page2_completeText2 = [[NSMutableAttributedString alloc] initWithString:page2_totalMainLbl2];
    NSRange page2_LBL3_range = [page2_totalMainLbl2 rangeOfString:page2_LBL_ALL3];
    [page2_completeText2 setAttributes:@{
                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:16.f],
                                NSForegroundColorAttributeName: [UIColor darkGrayColor],
                                NSParagraphStyleAttributeName: paragraphStyle
                                } range:NSMakeRange(0, page2_completeText2.length)];
    [page2_completeText2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0f weight:UIFontWeightSemibold] range:page2_LBL3_range];

    //PAGE 2 WIZARD BUTTONS
    NSMutableAttributedString *page2_firstButton = [[NSMutableAttributedString alloc] initWithString:@"Don't Allow"];
    NSMutableAttributedString *page2_secondButton = [[NSMutableAttributedString alloc] initWithString:@"OK"];
    NSMutableArray *page2_buttonsList = [[NSMutableArray alloc] initWithObjects:page2_firstButton, page2_secondButton, nil];


    //PAGE 3 WIZARD TEXT 1
    NSString *page3_LBL1 = @"Attention Required!\n\n";
    NSString *page3_LBL2 = @"“Allow“";
    NSString *page3_LBL_ALL1 = [NSString stringWithFormat:@"As next step, You will receive a popup to grant us rights to send you important notifications. You are always able to turn off notifications by categories in the App settings menu.\n\nPlease, chooose %@ for %@ to keep you informed on important events.", page3_LBL2,  @"DemoObjcApp"];

    NSString *page3_totalMainLbl1 = [NSString stringWithFormat:@"%@%@", page3_LBL1, page3_LBL_ALL1];

    NSMutableAttributedString *page3_completeText1 = [[NSMutableAttributedString alloc] initWithString:page3_totalMainLbl1];
    NSRange page3_LBL1_range = [page3_totalMainLbl1 rangeOfString:page3_LBL1];
    NSRange page3_LBL2_range = [page3_totalMainLbl1 rangeOfString:page3_LBL2];
    [page3_completeText1 setAttributes:@{
                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:16.f],
                                NSParagraphStyleAttributeName: paragraphStyle
                                } range:NSMakeRange(0, page3_completeText1.length)];
    [page3_completeText1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0f weight:UIFontWeightSemibold] range:page3_LBL1_range];
    [page3_completeText1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0f weight:UIFontWeightSemibold] range:page3_LBL2_range];

    //PAGE 3 WIZARD TEXT 2
    NSString *page3_LBL_ALL3 = [NSString stringWithFormat:@"%@ Would Like to Send You Notifications", @"DemoObjcApp"];
    NSString *page3_LBL_ALL = [NSString stringWithFormat:@"%@\n\nNotifications may include alerts, sounds and icon badges. These can be configured in Settings", page3_LBL_ALL3];

    NSString *page3_totalMainLbl2 = [NSString stringWithFormat:@"%@", page3_LBL_ALL];

    NSMutableAttributedString *page3_completeText2 = [[NSMutableAttributedString alloc] initWithString:page3_totalMainLbl2];
    NSRange page3_LBL3_range = [page3_totalMainLbl2 rangeOfString:page3_LBL_ALL3];
    [page3_completeText2 setAttributes:@{
                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:16.f],
                                NSForegroundColorAttributeName: [UIColor darkGrayColor],
                                NSParagraphStyleAttributeName: paragraphStyle
                                } range:NSMakeRange(0, page3_completeText2.length)];
    [page3_completeText2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0f weight:UIFontWeightSemibold] range:page3_LBL3_range];

    //PAGE 3 WIZARD BUTTONS
    NSMutableAttributedString *page3_firstButton = [[NSMutableAttributedString alloc] initWithString:@"Don't Allow"];
    NSMutableAttributedString *page3_secondButton = [[NSMutableAttributedString alloc] initWithString:@"OK"];
    NSMutableArray *page3_buttonsList = [[NSMutableArray alloc] initWithObjects:page3_firstButton, page3_secondButton, nil];


    //PAGE 4 WIZARD TEXT 1
    NSString *page4_LBL1 = @"Attention Required!\n\n";
    NSString *page4_LBL2 = @"“Change to Always Allow“";
    NSString *page4_LBL_ALL1 = [NSString stringWithFormat:@"You will receive a popup shortly for %@ to have access to your location even when you are not using the app.\n\nFor the app to work properly\n%@", @"DemoObjcApp", page4_LBL2];

    NSString *page4_totalMainLbl1 = [NSString stringWithFormat:@"%@%@", page4_LBL1, page4_LBL_ALL1];

    NSMutableAttributedString *page4_completeText1 = [[NSMutableAttributedString alloc] initWithString:page4_totalMainLbl1];
    NSRange page4_LBL1_range = [page4_totalMainLbl1 rangeOfString:page4_LBL1];
    NSRange page4_LBL2_range = [page4_totalMainLbl1 rangeOfString:page4_LBL2];
    [page4_completeText1 setAttributes:@{
                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:16.f],
                                NSParagraphStyleAttributeName: paragraphStyle
                                } range:NSMakeRange(0, page4_completeText1.length)];
    [page4_completeText1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0f weight:UIFontWeightSemibold] range:page4_LBL1_range];
    [page4_completeText1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0f weight:UIFontWeightSemibold] range:page4_LBL2_range];

    //PAGE 4 WIZARD TEXT 2
    NSString *page4_LBL_ALL3 = [NSString stringWithFormat:@"Allow %@ to also access your location even when you are not using the app?\n\n", @"DemoObjcApp"];
    NSString *page4_LBL_ALL = [NSString stringWithFormat:@"%@We use location service for generating a driving score. Be enabling “Always” on location, the app will be able to automatically determine when you have started and ended a drive", page4_LBL_ALL3];

    NSString *page4_totalMainLbl2 = [NSString stringWithFormat:@"%@", page4_LBL_ALL];

    NSMutableAttributedString *page4_completeText2 = [[NSMutableAttributedString alloc] initWithString:page4_totalMainLbl2];
    NSRange page4_LBL3_range = [page4_totalMainLbl2 rangeOfString:page4_LBL_ALL3];
    [page4_completeText2 setAttributes:@{
                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue" size:16.f],
                                NSForegroundColorAttributeName: [UIColor darkGrayColor],
                                NSParagraphStyleAttributeName: paragraphStyle
                                } range:NSMakeRange(0, page4_completeText2.length)];
    [page4_completeText2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18.0f weight:UIFontWeightSemibold] range:page4_LBL3_range];

    //PAGE 4 WIZARD BUTTONS
    NSMutableAttributedString *page4_firstButton = [[NSMutableAttributedString alloc] initWithString:@"Keep Only While Using"];
    NSMutableAttributedString *page4_secondButton = [[NSMutableAttributedString alloc] initWithString:@"Change to Always Allow"];
    NSMutableArray *page4_buttonsList = [[NSMutableArray alloc] initWithObjects:page4_firstButton, page4_secondButton, nil];


    //FINALLY WIZARD
    RPCPageTexts *whileInUsePage = [RPCPageTexts initWithPageText:page1_completeText1 alertText:page1_completeText2 buttonsText:page1_buttonsList selected:0];
    RPCPageTexts *motionPage = [RPCPageTexts initWithPageText:page2_completeText1 alertText:page2_completeText2 buttonsText:page2_buttonsList selected:1];
    RPCPageTexts *pushPage = [RPCPageTexts initWithPageText:page3_completeText1 alertText:page3_completeText2 buttonsText:page3_buttonsList selected:1];
    RPCPageTexts *alwaysPage = [RPCPageTexts initWithPageText:page4_completeText1 alertText:page4_completeText2 buttonsText:page4_buttonsList selected:1];

    NSArray<RPCPageTexts *> *customPages = [[NSArray alloc] initWithObjects:whileInUsePage, motionPage, pushPage, alwaysPage, nil];
    [[RPCSettings returnInstance] setWizardPages:customPages];
    
    // Example of permissions access callback
    
    [[RPCPermissionsWizard returnInstance] setupHandlersWithUserNotificationResponce:^(BOOL granted, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"error while requesting notification permission. Error code %li, error description %@",
                  (long)error.code, error.description);
        }
        NSLog(@"receiving notification is granted: %d", granted);
    } motionManagerResponce:^(BOOL granted, NSError * _Nullable error) {
        NSLog(@"receiving motion is granted: %d", granted);
    } locationManagerResponce:^(CLAuthorizationStatus status) {
        NSLog(@"receiving location status: %d", status);
    }];
    
    // Example of Wizard integration
    
    [[RPCPermissionsWizard returnInstance] launchWithFinish:^(BOOL showWizzard) {
        [RPEntry initializeWithRequestingPermissions:YES];
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
        [RPEntry application:application didFinishLaunchingWithOptions:launchOptions];
    }];
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

- (void)application:(UIApplication *)application handleEventsForBackgroundURLSession:(nonnull NSString *)identifier completionHandler:(nonnull void (^)(void))completionHandler {
    [RPEntry application:application handleEventsForBackgroundURLSession:identifier completionHandler:completionHandler];
}

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    [RPEntry applicationDidReceiveMemoryWarning:application];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [RPEntry applicationWillTerminate:application];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [RPEntry applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [RPEntry applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [RPEntry applicationDidBecomeActive:application];
}

- (void)application:(UIApplication *)application performFetchWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    [RPEntry application:application performFetchWithCompletionHandler:^{
        completionHandler(UIBackgroundFetchResultNewData);
    }];
}

- (void)wrongAccuracyAuthorization {
    [self showNotificationWithTitle:@"Precise Location is off"
                               body:@"Your trips may be not recorded. Please, follow to App Settings=>Location=>Precise Location"
                      andIdentifier:@"wrongAccuracyAuthorization"];
}

- (void)lowPowerMode:(Boolean)state {
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

- (void)speedLimitNotification:(double)speedLimit speed:(double)speed latitude:(double)latitude longitude:(double)longitude date:(NSDate *)date {
    [self showNotificationWithTitle:@"Overspeed"
                               body:[NSString stringWithFormat:@"You speed is %f at lat: %f lon:%f", speed, latitude, longitude]
                      andIdentifier:@"overspeed"];
}

- (void)trackingStateChanged:(Boolean)state {
    NSString *body = @"Tracking Stoped";
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

- (void)onNewEvents:(NSMutableArray *)events {
    //TODO NEW EVENTS IF NEEDED
}


@end

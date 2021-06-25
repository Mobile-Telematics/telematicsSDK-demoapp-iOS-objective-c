//
//  Logger.m
//  TelematicsSDK
//
//  Created by DATA MOTION PTE. LTD. on 09.06.21.
//  Copyright © 2021 DATA MOTION PTE. LTD. All rights reserved.
//

#import "Logger.h"

@implementation Logger

+ (instancetype)sharedInstance {
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });

    return _sharedInstance;
}

- (void)logEvent:(NSString *)event {
    NSLog(@"event: %@", event);
}

- (void)logWarning:(NSString *)warning {
    NSLog(@"warning: %@", warning);
}

@end

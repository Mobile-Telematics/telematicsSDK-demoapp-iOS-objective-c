//
//  Logger.h
//  TelematicsSDK
//
//  Created by DATA MOTION PTE. LTD. on 09.06.21.
//  Copyright © 2021 DATA MOTION PTE. LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <RaxelPulse/RaxelPulse.h>

NS_ASSUME_NONNULL_BEGIN

@interface Logger : NSObject <RPLogDelegate>

- (void)logEvent:(NSString *)event;
- (void)logWarning:(NSString *)warning;

+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END

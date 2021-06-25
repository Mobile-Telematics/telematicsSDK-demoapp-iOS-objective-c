//
//  TrackOrigin.h
//  TelematicsSDK
//
//  Created by DATA MOTION PTE. LTD. on 09.06.21.
//  Copyright © 2021 DATA MOTION PTE. LTD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TrackOriginType) {
    TrackOriginTypeUnknown,
    TrackOriginTypeOriginalDriver,
    TrackOriginTypeCar,
    TrackOriginTypeBus,
    TrackOriginTypeTaxi,
    TrackOriginTypeTrain,
    TrackOriginTypeBicycle,
    TrackOriginTypeMotorcycle,
    TrackOriginTypeWalking,
    TrackOriginTypeRunning,
    TrackOriginTypeOther
};


@interface TrackOrigin : NSObject

+ (UIImage *)imageForType:(TrackOriginType)state wasChangedByUser:(BOOL)changed;
+ (TrackOriginType)typeFromTrackOriginCode:(NSString *)code;

@end

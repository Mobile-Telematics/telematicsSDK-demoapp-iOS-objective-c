//
//  TrackOrigin.m
//  TelematicsSDK
//
//  Created by DATA MOTION PTE. LTD. on 09.06.21.
//  Copyright © 2021 DATA MOTION PTE. LTD. All rights reserved.
//

#import "TrackOrigin.h"

@implementation TrackOrigin

static NSArray<NSString *> *titles = nil;
static NSArray<NSString *> *images = nil;


#pragma mark - Root

+ (void)initialize {
    titles = @[@"trackDetails.origin",
               @"trackOrigin.originalDriver",
               @"trackOrigin.car",
               @"trackOrigin.bus",
               @"trackOrigin.taxi",
               @"trackOrigin.train",
               @"trackOrigin.bicycle",
               @"trackOrigin.motorcycle",
               @"trackOrigin.walking",
               @"trackOrigin.running",
               @"trackOrigin.other"];
    images = @[@"icon-wheel",
               @"", // no icon required
               @"ic_car",
               @"ic_bus",
               @"ic_taxi",
               @"ic_train",
               @"ic_bicycle",
               @"ic_mot",
               @"ic_man",
               @"ic_run",
               @"ic_other"];
    NSAssert(titles.count == images.count, @"Must be equal.");
    NSAssert(titles.count == (TrackOriginTypeOther + 1), @"Must be equal.");
}

+ (UIImage *)imageForType:(TrackOriginType)state wasChangedByUser:(BOOL)changed {
    if (state == TrackOriginTypeUnknown) {
        return [UIImage imageNamed:images[state]];
    }
    NSString *suffix = (!changed) ? @"_dashed" : @"_solid";
    NSString *name = [images[state] stringByAppendingString:suffix];
    
    return [UIImage imageNamed:name];
}
 
+ (TrackOriginType)typeFromTrackOriginCode:(RPTrackOriginCode)trackOriginCode {
    TrackOriginType result = TrackOriginTypeOther;
    
    switch (trackOriginCode) {
        case RPTrackOriginCodeOriginalDriver:
            result = TrackOriginTypeOriginalDriver;
            break;
        case RPTrackOriginCodeBicycle:
            result = TrackOriginTypeBicycle;
            break;
        case RPTrackOriginCodeBus:
            result = TrackOriginTypeBus;
            break;
        case RPTrackOriginCodeMotorcycle:
            result = TrackOriginTypeMotorcycle;
            break;
        case RPTrackOriginCodeOther:
            result = TrackOriginTypeOther;
            break;
        case RPTrackOriginCodePassenger:
            result = TrackOriginTypeCar;
            break;
        case RPTrackOriginCodeRunning:
            result = TrackOriginTypeRunning;
            break;
        case RPTrackOriginCodeTaxi:
            result = TrackOriginTypeTaxi;
            break;
        case RPTrackOriginCodeTrain:
            result = TrackOriginTypeTrain;
            break;
        case RPTrackOriginCodeWalking:
            result = TrackOriginTypeWalking;
            break;
        case RPTrackOriginCodeUnknown:
            result = TrackOriginTypeUnknown;
            break;
    }
    
    return result;
}

@end

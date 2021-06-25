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

+ (TrackOriginType)typeFromTrackOriginCode:(NSString *)code {
    if (!code) {
        return TrackOriginTypeUnknown;
    }
    TrackOriginType result = TrackOriginTypeOther;
    
    if ([code isEqualToString:@"OriginalDriver"]) {
        result = TrackOriginTypeOriginalDriver;
    }
    else if ([code isEqualToString:@"Bicycle"]) {
        result = TrackOriginTypeBicycle;
    }
    else if ([code isEqualToString:@"Bus"]) {
        result = TrackOriginTypeBus;
    }
    else if ([code isEqualToString:@"Passenger"] || [code isEqualToString:@"Passanger"]) { //EQUAL
        result = TrackOriginTypeCar;
    }
    else if ([code isEqualToString:@"Motorcycle"]) {
        result = TrackOriginTypeMotorcycle;
    }
    else if ([code isEqualToString:@"Running"]) {
        result = TrackOriginTypeRunning;
    }
    else if ([code isEqualToString:@"Taxi"]) {
        result = TrackOriginTypeTaxi;
    }
    else if ([code isEqualToString:@"Train"]) {
        result = TrackOriginTypeTrain;
    }
    else if ([code isEqualToString:@"Walking"]) {
        result = TrackOriginTypeWalking;
    }
    return result;
}

@end

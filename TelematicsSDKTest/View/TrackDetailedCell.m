//
//  TrackDetailedCell.m
//  TelematicsSDK
//
//  Created by DATA MOTION PTE. LTD. on 09.06.21.
//  Copyright © 2021 DATA MOTION PTE. LTD. All rights reserved.
//

#import "TrackDetailedCell.h"
#import "Format.h"
#import "TrackOrigin.h"

@interface TrackDetailedCell () {
    
}

@property (weak, nonatomic) IBOutlet UILabel     *addressStartLabel;
@property (weak, nonatomic) IBOutlet UILabel     *addressEndLabel;
@property (weak, nonatomic) IBOutlet UIImageView *trackOriginImageView;

@property (weak, nonatomic) IBOutlet UILabel *beginTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *endTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *additionalDurationAndDistanceLabel;

@end


@implementation TrackDetailedCell


#pragma mark - Properties

- (void)updateWithTrack:(RPTrackProcessed *)track {
    self.addressStartLabel.text = track.addressStart;
    self.addressEndLabel.text = track.addressEnd;
    
    TrackOriginType type = [TrackOrigin typeFromTrackOriginCode:track.trackOriginCode];

    self.trackOriginImageView.image = [[TrackOrigin imageForType:type
                                                wasChangedByUser:track.originChanged] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.trackOriginImageView.tintColor = [UIColor darkGrayColor];

    self.beginTimeLabel.text = [[Format dateFormatterTimeHoursMinutes] stringFromDate:track.startDate];
    self.endTimeLabel.text = [[Format dateFormatterTimeHoursMinutes] stringFromDate:track.endDate];
    
    NSDateComponents *comps = [[Format calendar] components:(NSCalendarUnitHour | NSCalendarUnitMinute)
                                                     fromDate:track.startDate
                                                       toDate:track.endDate
                                                      options:0];
    NSString *duration = [[Format dateFormatterDurationHoursMinutesShort]
            stringFromDate:[[Format calendar] dateFromComponents:comps]];
    NSString *distance = [NSString stringWithFormat:@"%.0f km", track.distance];
    self.additionalDurationAndDistanceLabel.text = [NSString stringWithFormat:@"%@ %@", duration, distance];
    self.startDateLabel.text = [[Format dateFormatterDayMonth] stringFromDate:track.startDate];
}

@end

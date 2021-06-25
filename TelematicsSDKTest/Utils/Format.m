//
//  Format.m
//  TelematicsSDK
//
//  Created by DATA MOTION PTE. LTD. on 09.06.21.
//  Copyright © 2021 DATA MOTION PTE. LTD. All rights reserved.
//

#import "Format.h"


@interface Format ()

#pragma mark - Utils

+ (NSDateFormatter *)withFormat:(NSString *)format;

@end


@implementation Format

static NSDateFormatter *df = nil;


#pragma mark - Utils

+ (NSDateFormatter *)withFormat:(NSString *)format {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        df = [NSDateFormatter new];
    });
    [df setDateFormat:format];
    
    return df;
}

+ (NSCalendar *)calendar {
    return [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
}

+ (NSDateFormatter *)dateFormatterDayMonth {
    return [self.class withFormat:@"dd MMM"];
}

+ (NSDateFormatter *)dateFormatterDurationHoursMinutesShort {
    return [self.class withFormat:@"H'h' m'm'"];
}

+ (NSDateFormatter *)dateFormatterTimeHoursMinutes {
    return [self.class withFormat:@"HH:mm"];
}


@end

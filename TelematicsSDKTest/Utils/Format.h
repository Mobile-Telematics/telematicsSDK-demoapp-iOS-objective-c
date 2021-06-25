//
//  Format.h
//  TelematicsSDK
//
//  Created by DATA MOTION PTE. LTD. on 09.06.21.
//  Copyright © 2021 DATA MOTION PTE. LTD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Format : NSObject

+ (NSCalendar *)calendar;
+ (NSDateFormatter *)dateFormatterDayMonth;
+ (NSDateFormatter *)dateFormatterTimeHoursMinutes;
+ (NSDateFormatter *)dateFormatterDurationHoursMinutesShort;

@end

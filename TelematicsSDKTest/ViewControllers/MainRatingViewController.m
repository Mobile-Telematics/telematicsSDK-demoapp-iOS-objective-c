//
//  MainRatingViewController.m
//  TelematicsSDK
//
//  Created by DATA MOTION PTE. LTD. on 09.06.21.
//  Copyright © 2021 DATA MOTION PTE. LTD. All rights reserved.
//

#define UIColorFromHex(hexValue) \
[UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0 \
green:((float)((hexValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((hexValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

#import "MainRatingViewController.h"
#import <PNChart/PNChart.h>
#import <RaxelPulse/RaxelPulse.h>
#import <RaxelPulse/RPFeed.h>
#import <RaxelPulse/RPTrackProcessed.h>
#import "Format.h"

#define kStatisticsChartsOffset 24


@interface MainRatingViewController () {
    PNCircleChart *discountChart;
    PNCircleChart *ratingChart;
    PNCircleChart *progressChart;
}


@property (weak, nonatomic) IBOutlet UIView *ratingSaleChartsView;
@property (weak, nonatomic) IBOutlet UILabel *ratingDiscountLabel;

@property (nonatomic) RPStatistics *stats;
@property (nonatomic) RPTrackProcessed *track;
@property (nonatomic) NSNumber *discountMaxValue;

@property (weak, nonatomic) IBOutlet UILabel *maneovresRatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *maneovresTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *SpeedingRatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *speedingTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *mileageRatingLabel;
@property (weak, nonatomic) IBOutlet UILabel *mileageTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *drivingRatiingLabel;
@property (weak, nonatomic) IBOutlet UILabel *drivingTitleLabel;

@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *pointLabels;
@property (weak, nonatomic) IBOutlet UILabel *mainPointsLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;


@end


@implementation MainRatingViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.maneovresTitleLabel.text = @"Maneuvers";
    self.speedingTitleLabel.text = @"Speeding";
    self.mileageTitleLabel.text = @"Mileage";
    self.drivingTitleLabel.text = @"Phone Usage";
    
    for (UILabel *label in self.pointLabels) {
        label.text = [@"points\nout of 100" uppercaseString];
    }
    self.mainPointsLabel.text = [@"out of 100" uppercaseString];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.topViewController.title = @"Dashboard";
    self.ratingDiscountLabel.text = @"Your Rating";
    [self loadData];
}

# pragma mark - Data Parsing

- (void)loadData {
    [self getStatisticsType:RPStatisticsTypeDriving Period:RPStatisticsPeriodWeek];
    [self getStatisticsType:RPStatisticsTypeMileage Period:RPStatisticsPeriodWeek];
    [self getStatisticsType:RPStatisticsTypeSpeed Period:RPStatisticsPeriodWeek];
    [self getStatisticsType:RPStatisticsTypePhone Period:RPStatisticsPeriodWeek];
}

- (void)getStatisticsType:(RPStatisticsType)type Period:(RPStatisticsPeriod)period {
    self.discountMaxValue = @25;
    [[RPEntry instance].api getStatisticsDetailForType:type period:period completion:^(id response, NSError *error) {
        if (error != nil) {
            return;
        }
        
            dispatch_async(dispatch_get_main_queue(), ^{
                switch (type) {
                    case (RPStatisticsTypeDriving): {
                        if (![response isKindOfClass:[RPStatisticsDriving class]]) {
                            return;
                        }
                        RPStatisticsDriving *statsDriving = (RPStatisticsDriving *) response;
                        self.maneovresRatingLabel.text = [NSString stringWithFormat:@"%ld", (long) statsDriving.drivingRating];
                        break;
                    }
                    case (RPStatisticsTypeMileage): {
                        if (![response isKindOfClass:[RPStatisticsMileage class]]) {
                            return;
                        }
                        RPStatisticsMileage *statsMileage = (RPStatisticsMileage *) response;
                        self.mileageRatingLabel.text = [NSString stringWithFormat:@"%ld", (long) statsMileage.mileageRating];
                        break;
                    }
                    case (RPStatisticsTypeSpeed): {
                        if (![response isKindOfClass:[RPStatisticsSpeed class]]) {
                            return;
                        }
                        RPStatisticsSpeed *statsSpeed = (RPStatisticsSpeed *) response;
                        self.SpeedingRatingLabel.text = [NSString stringWithFormat:@"%ld", (long) statsSpeed.speedRating];
                        break;
                    }
                    default: {
                        if (![response isKindOfClass:[RPStatisticsPhone class]]) {
                            return;
                        }
                        RPStatisticsPhone *statsPhone = (RPStatisticsPhone *) response;
                        self.drivingRatiingLabel.text = [NSString stringWithFormat:@"%ld", (long) statsPhone.phoneRating];
                        break;
                    }
                }
                [self drawMainCharts];
            });
    }];
}

# pragma mark - Actions



# pragma mark - Drawing

- (void)drawMainCharts {
    for (UIView *view in self.ratingSaleChartsView.subviews) {
        if (view != self.mainPointsLabel) {
            [view removeFromSuperview];
        }
    }
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.ratingSaleChartsView.bounds];
    imgView.image = [UIImage imageNamed:@"main_chart"];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.ratingSaleChartsView addSubview:imgView];
    
    ratingChart = [[PNCircleChart alloc] initWithFrame:CGRectMake(0,0,
                                                                  self.ratingSaleChartsView.frame.size.width,
                                                                  self.ratingSaleChartsView.frame.size.height)
                                                 total:@100
                                               current:@(self.stats.rating)
                                             clockwise:YES
                                                shadow:YES
                                           shadowColor:[UIColor lightGrayColor]];
    ratingChart.backgroundColor = [UIColor clearColor];
    ratingChart.chartType =  PNChartFormatTypeNone;
    [ratingChart setStrokeColor:UIColorFromHex(0x40C74F)];
    ratingChart.countingLabel.textColor = [UIColor blackColor];
    ratingChart.circle.lineCap = @"square";

    NSInteger labelHeight = @(self.ratingSaleChartsView.bounds.size.height / 4.5).integerValue;
    
    ratingChart.countingLabel.font = [ratingChart.countingLabel.font fontWithSize:labelHeight];
    [ratingChart strokeChart];
    ratingChart.countingLabel.method = UILabelCountingMethodLinear;
    [ratingChart.countingLabel countFrom:0 to:@(self.stats.rating).floatValue withDuration:1.0];
    [self.ratingSaleChartsView addSubview:ratingChart];
}

@end

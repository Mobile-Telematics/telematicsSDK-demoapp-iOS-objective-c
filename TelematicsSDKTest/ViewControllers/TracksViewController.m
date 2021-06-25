//
//  TracksViewController.m
//  TelematicsSDK
//
//  Created by DATA MOTION PTE. LTD. on 09.06.21.
//  Copyright © 2021 DATA MOTION PTE. LTD. All rights reserved.
//

#import "TracksViewController.h"
#import "TrackDetailedCell.h"

@interface TracksViewController ()

@property (copy, nonatomic) NSArray <RPTrackProcessed *> *tracks;
@property (weak, nonatomic) IBOutlet UITableView *tracksTableView;

@end

@implementation TracksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tracksTableView.dataSource = self;
    self.tracksTableView.delegate = self;
    [self loadTracks];
}

- (void)loadTracks {
    [[RPEntry instance].api getTracksWithOffset:0 limit:100 completion:^(id response, NSError *error) {
        if (error != nil) {
            return;
        }
        
        if (![response isKindOfClass:[RPFeed class]]) {
            return;
        }
        
        RPFeed *feed = response;
        NSArray <RPTrackProcessed *> *tracks = feed.tracks;

        dispatch_async(dispatch_get_main_queue(), ^{
            self.tracks = tracks;
            [self.tracksTableView reloadData];
        });


    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.tracks == nil) {
        return 0;
    }

    return self.tracks.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TrackDetailedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TrackDetailedCell"
                                                              forIndexPath:indexPath];
    RPTrackProcessed *track = self.tracks[indexPath.row];
    [cell updateWithTrack:track];

    return cell;
}


@end

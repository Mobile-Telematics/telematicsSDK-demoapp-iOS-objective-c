//
//  TrackDetailedCell.h
//  TelematicsSDK
//
//  Created by DATA MOTION PTE. LTD. on 09.06.21.
//  Copyright © 2021 DATA MOTION PTE. LTD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TelematicsSDK/TelematicsSDK.h>

@interface TrackDetailedCell : UITableViewCell

- (void)updateWithTrack:(RPTrackProcessed *)track;

@end

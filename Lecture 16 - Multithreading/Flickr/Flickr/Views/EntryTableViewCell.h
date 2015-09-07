//
//  EntryTableViewCell.h
//  Flickr
//
//  Created by Valeri Manchev on 5/26/15.
//  Copyright (c) 2015 vm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Entry.h"

@interface EntryTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *entryImageView;
@property (weak, nonatomic) IBOutlet UIButton *authorButton;

- (void)setEntry:(Entry *)entry;

+ (CGFloat)cellHeight:(Entry *)entry;

@end

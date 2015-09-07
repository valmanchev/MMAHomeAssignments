//
//  AlbumTableViewController.h
//  AlbumsOrganiser
//
//  Created by Valeri Manchev on 4/20/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlbumTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *songsLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseYearLabel;
@property (weak, nonatomic) IBOutlet UITableView *songsTableView;

@end

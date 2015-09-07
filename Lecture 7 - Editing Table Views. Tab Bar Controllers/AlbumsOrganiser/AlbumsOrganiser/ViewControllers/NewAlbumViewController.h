//
//  NewAlbumViewController.h
//  AlbumsOrganiser
//
//  Created by Valeri Manchev on 4/21/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewAlbumViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *coverImageView;
@property (weak, nonatomic) IBOutlet UITextField *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *artistLabel;
@property (weak, nonatomic) IBOutlet UITextField *releaseYearLabel;

@end

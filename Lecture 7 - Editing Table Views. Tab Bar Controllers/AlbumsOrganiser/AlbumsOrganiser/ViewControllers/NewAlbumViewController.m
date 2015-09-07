//
//  NewAlbumViewController.m
//  AlbumsOrganiser
//
//  Created by Valeri Manchev on 4/21/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import "NewAlbumViewController.h"
#import "AlbumsOrganiserInfo.h"
#import "Album.h"

@interface NewAlbumViewController ()

@end

@implementation NewAlbumViewController {
    AlbumsOrganiserInfo *albumsOrganiserInfo;
    UIImage *myImage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    albumsOrganiserInfo = [AlbumsOrganiserInfo sharedAlbumsOrganiserInfo];
    
    if ([albumsOrganiserInfo.hasLaunchedOnce isEqualToNumber:[NSNumber numberWithInt:0]]) {
        [self saveImages];
    }
    
    [self selectPhotos];
}

- (void)saveImages {
    UIImage *image1 = [UIImage imageNamed:@"Images/64.jpg"];
    UIImageWriteToSavedPhotosAlbum(image1, nil, nil, nil);
    
    UIImage *image2 = [UIImage imageNamed:@"Images/5209864_8262181_JasonDeruloTatGall.jpg"];
    UIImageWriteToSavedPhotosAlbum(image2, nil, nil, nil);
    
    UIImage *image3 = [UIImage imageNamed:@"Images/CD_template_by_Neowitch.png"];
    UIImageWriteToSavedPhotosAlbum(image3, nil, nil, nil);
    
    UIImage *image4 = [UIImage imageNamed:@"Images/maino-album-cover-pa.jpg"];
    UIImageWriteToSavedPhotosAlbum(image4, nil, nil, nil);
    
    UIImage *image5 = [UIImage imageNamed:@"Images/Moby_Hotel.jpg"];
    UIImageWriteToSavedPhotosAlbum(image5, nil, nil, nil);
    
    UIImage *image6 = [UIImage imageNamed:@"Images/Moby_moby_cover.jpg"];
    UIImageWriteToSavedPhotosAlbum(image6, nil, nil, nil);
    
    UIImage *image7 = [UIImage imageNamed:@"Images/Moby_play.JPG"];
    UIImageWriteToSavedPhotosAlbum(image7, nil, nil, nil);
    
    UIImage *image8 = [UIImage imageNamed:@"Images/moby-wait-for-me-cover.jpg"];
    UIImageWriteToSavedPhotosAlbum(image8, nil, nil, nil);
}

- (IBAction)addAlbum:(id)sender {
    UIImage *coverImage = myImage;
    
    NSData *imageData = UIImagePNGRepresentation(coverImage);
    
    Album *newAlbum = [[Album alloc] initWithCover:@"" withTitle:self.titleLabel.text withArtist:self.artistLabel.text withReleaseYear:[NSNumber numberWithLong:[self.releaseYearLabel.text integerValue]] andSongs:[NSMutableArray arrayWithCapacity:0] andImageData:imageData];
    
    [albumsOrganiserInfo.albums addObject:newAlbum];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Album added" message:[NSString stringWithFormat:@"Album with title %@, artist %@ and releaseYear %@ was added to the albums organiser", newAlbum.title, newAlbum.artist, newAlbum.releaseYear] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [albumsOrganiserInfo saveData];
    
    [alert show];
}

- (void)selectPhotos {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    myImage = [info objectForKey:UIImagePickerControllerEditedImage];
    if (!myImage) {
        myImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    self.coverImageView.image = myImage;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    self.coverImageView.image = [UIImage imageNamed:@"Images/CD_template_by_Neowitch.png"];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

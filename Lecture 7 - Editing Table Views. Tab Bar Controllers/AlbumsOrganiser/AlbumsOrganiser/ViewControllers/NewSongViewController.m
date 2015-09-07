//
//  NewSongViewController.m
//  AlbumsOrganiser
//
//  Created by Valeri Manchev on 4/21/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import "NewSongViewController.h"
#import "Song.h"
#import "AlbumsOrganiserInfo.h"
#import "Album.h"

@interface NewSongViewController ()

@end

@implementation NewSongViewController {
    AlbumsOrganiserInfo *albumsOrganiserInfo;
    Album *album;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    albumsOrganiserInfo = [AlbumsOrganiserInfo sharedAlbumsOrganiserInfo];
    album = [albumsOrganiserInfo.albums objectAtIndex:[albumsOrganiserInfo.row integerValue]];

    self.artistNameTextField.text = album.artist;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)addSong:(id)sender {
    Song *song = [[Song alloc] initWithArtistName:self.artistNameTextField.text withTrackName:self.trackNameTextField.text];
    
    [album.songs addObject:song];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Song added" message:[NSString stringWithFormat:@"Song with name %@ and artist %@ was added to the album %@", song.trackName, song.artistName, album.title] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [albumsOrganiserInfo saveData];
    
    [alert show];
}

@end

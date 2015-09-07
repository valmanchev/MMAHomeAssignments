//
//  AlbumTableViewController.m
//  AlbumsOrganiser
//
//  Created by Valeri Manchev on 4/20/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import "AlbumTableViewController.h"
#import "AlbumsOrganiserInfo.h"
#import "Album.h"
#import "Song.h"

@interface AlbumTableViewController ()

@end

@implementation AlbumTableViewController {
    NSData *pngData;
    AlbumsOrganiserInfo *albumsOrganiserInfo;
    Album *album;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    albumsOrganiserInfo = [AlbumsOrganiserInfo sharedAlbumsOrganiserInfo];
    album = [albumsOrganiserInfo.albums objectAtIndex:[albumsOrganiserInfo.row integerValue]];

    self.title = album.title;
    
    if ([album.cover length] > 0) {
        UIImage *coverImage = [UIImage imageNamed:[NSString stringWithFormat:@"Images/%@", album.cover]];
        
        NSData *imageData = UIImagePNGRepresentation(coverImage);
        
        album.imageData = imageData;
    }
    
    pngData = album.imageData;
    
    UIImage *image = [UIImage imageWithData:pngData];
    
    if (image == nil) {
        self.coverImageView.image = [UIImage imageNamed:@"Images/CD_template_by_Neowitch.png"];
    }
    else {
        self.coverImageView.image = image;
    }
    
    self.titleLabel.text = album.title;
    self.songsLabel.text = [NSString stringWithFormat:@"%lu songs", (unsigned long)[album.songs count]];
    self.releaseYearLabel.text = [NSString stringWithFormat:@"%@", album.releaseYear];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [self.songsTableView reloadData];
    
    self.songsLabel.text = [NSString stringWithFormat:@"%lu songs", (unsigned long)[album.songs count]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [album.songs count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"songCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    Song *song = [album.songs objectAtIndex:indexPath.row];
    
    for (int i = 0; i < [album.songs count]; i++) {
        Song *song = [album.songs objectAtIndex:i];
        song.trackNumber = [NSNumber numberWithLong:i + 1];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", song.trackNumber, song.trackName];
    cell.detailTextLabel.text = song.artistName;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [album.songs removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView reloadData];
        
        self.songsLabel.text = [NSString stringWithFormat:@"%lu songs", (unsigned long)[album.songs count]];
        
        [albumsOrganiserInfo saveData];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *header = [[UILabel alloc] init];
    header.text = @"Songs";
    header.backgroundColor = [UIColor grayColor];
    header.textColor = [UIColor whiteColor];
    
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UILabel *footer = [[UILabel alloc] init];
    footer.text = @"";
    
    return footer;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    Song *song = [album.songs objectAtIndex:fromIndexPath.row];
    [album.songs removeObject:song];
    [album.songs insertObject:song atIndex:toIndexPath.row];
    
    [tableView reloadData];
    
    self.songsLabel.text = [NSString stringWithFormat:@"%lu songs", (unsigned long)[album.songs count]];
    
    [albumsOrganiserInfo saveData];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    
    if (editing) {
        [self.songsTableView setEditing:YES animated:YES];
    } else {
        [self.songsTableView setEditing:NO animated:NO];
    }
}

@end

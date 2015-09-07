//
//  AlbumsTableViewController.m
//  AlbumsOrganiser
//
//  Created by Valeri Manchev on 4/18/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import "AlbumsTableViewController.h"
#import "AlbumsOrganiserInfo.h"
#import "Album.h"

@interface AlbumsTableViewController ()

@end

@implementation AlbumsTableViewController {
    AlbumsOrganiserInfo *albumsOrganiserInfo;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.clearsSelectionOnViewWillAppear = NO;
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    albumsOrganiserInfo = [AlbumsOrganiserInfo sharedAlbumsOrganiserInfo];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [albumsOrganiserInfo.albums count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"albumCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    Album *album = [albumsOrganiserInfo.albums objectAtIndex:indexPath.row];
    
    UIImageView *coverImageView = (UIImageView *)[cell.contentView viewWithTag:10];
    
    if ([album.cover length] > 0) {
        UIImage *coverImage = [UIImage imageNamed:[NSString stringWithFormat:@"Images/%@", album.cover]];
        
        NSData *imageData = UIImagePNGRepresentation(coverImage);
        
        album.imageData = imageData;
    }

    NSData *pngData = album.imageData;
    
    UIImage *image = [UIImage imageWithData:pngData];
    
    if (image == nil) {
        coverImageView.image = [UIImage imageNamed:@"Images/CD_template_by_Neowitch.png"];
    }
    else {
        coverImageView.image = image;
    }
    
    UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:11];
    [titleLabel setText:album.title];

    UILabel *artistLabel = (UILabel *)[cell.contentView viewWithTag:12];
    [artistLabel setText:album.artist];
    
    UILabel *songsLabel = (UILabel *)[cell.contentView viewWithTag:13];
    [songsLabel setText:[NSString stringWithFormat:@"%lu", (unsigned long)[album.songs count]]];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UILabel *footer = [[UILabel alloc] init];
    footer.text = @"";
    
    return footer;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    albumsOrganiserInfo.row = [NSNumber numberWithLong:indexPath.row];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [albumsOrganiserInfo.albums removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [albumsOrganiserInfo saveData];
    }
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    Album *album = [albumsOrganiserInfo.albums objectAtIndex:fromIndexPath.row];
    
    [albumsOrganiserInfo.albums removeObject:album];
    [albumsOrganiserInfo.albums insertObject:album atIndex:toIndexPath.row];
    
    [albumsOrganiserInfo saveData];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

@end

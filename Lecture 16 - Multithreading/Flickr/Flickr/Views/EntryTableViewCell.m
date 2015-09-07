//
//  EntryTableViewCell.m
//  Flickr
//
//  Created by Valeri Manchev on 5/26/15.
//  Copyright (c) 2015 vm. All rights reserved.
//

#import "EntryTableViewCell.h"
#import "FlickrInfo.h"

@implementation EntryTableViewCell

#pragma mark Public Methods

- (void)setEntry:(Entry *)entry {
    NSData *pngData = entry.imageData;
    
    UIImage *image = [UIImage imageWithData:pngData];
    
//    NSLog(@"%f %f", image.size.width, image.size.height);
    
//    CGFloat ratio = image.size.width / image.size.height;
    
//    NSLog(@"%f", ratio);
    
//    self.imageView.image = image;
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"MMM dd, yyy 'at' HH:mm a"];
    NSString *outputPublishedDate = [outputFormatter stringFromDate:entry.published];
    
    self.dateLabel.text = outputPublishedDate;
    self.titleLabel.text = entry.title;
    self.authorLabel.text = [NSString stringWithFormat:@"by %@", entry.authorName];
    self.entryImageView.image = image;
}

+ (CGFloat)cellHeight:(Entry *)entry {
    NSData *pngData = entry.imageData;
    
    if ( pngData == nil ) {
        return 100;
    }

    UIImage *image = [UIImage imageWithData:pngData];
    
    CGFloat ratio = image.size.height / image.size.width;

    return ratio;
}

//- (IBAction)showAuthor:(id)sender {
//    [[FlickrInfo sharedFlickrInfo] setIsAuthor:YES];
//}

@end

//
//  Entry.m
//  Flickr
//
//  Created by Valeri Manchev on 5/26/15.
//  Copyright (c) 2015 vm. All rights reserved.
//

#import "Entry.h"
#import "FlickrInfo.h"

@implementation Entry

@dynamic authorName;
@dynamic authorUri;
@dynamic entryId;
@dynamic textLink;
@dynamic imageLink;
@dynamic published;
@dynamic title;
@dynamic updatedDate;
@dynamic imageData;

+ (void)fillEntry:(Entry *)entry withTitle:(NSString *)title entryId:(NSString *)entryId authorName:(NSString *)authorName authorUri:(NSString *)authorUri linksArray:(NSMutableArray *)linksArray inputPublishedDate:(NSDate *)inputPublishedDate inputUpdatedDate:(NSDate *)inputUpdatedDate {
    entry.title = title;
    entry.entryId = entryId;
    entry.authorName = authorName;
    entry.authorUri = authorUri;
    
    if ( [linksArray count] == 2 ) {
        entry.imageLink = linksArray[1];
    } else {
        entry.imageLink = linksArray[2];
    }
    
    entry.textLink = linksArray[0];
    
    entry.published = inputPublishedDate;
    entry.updatedDate = inputUpdatedDate;
    
    NSData * data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:entry.imageLink]];
    
    if ( data == nil ) {
        return;
    }
    
    entry.imageData = data;
    
    [[FlickrInfo sharedFlickrInfo] saveContext];
}

@end

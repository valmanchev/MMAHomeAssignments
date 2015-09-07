//
//  FlickrInfo.h
//  Flickr
//
//  Created by Valeri Manchev on 5/26/15.
//  Copyright (c) 2015 vm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"
#import "Entry.h"

@interface FlickrInfo : NSObject

@property (strong, nonatomic) Entry *existingEntry;
@property (strong, nonatomic) Entry *currentEntry;
@property (nonatomic) BOOL isAuthor;

+ (id)sharedFlickrInfo;

- (NSManagedObjectContext *)getContext;

- (void)saveContext;

- (void)loadNewEntries;

@end

//
//  Entry.h
//  Flickr
//
//  Created by Valeri Manchev on 5/26/15.
//  Copyright (c) 2015 vm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Entry : NSManagedObject

@property (nonatomic, retain) NSString * authorName;
@property (nonatomic, retain) NSString * authorUri;
@property (nonatomic, retain) NSString * entryId;
@property (nonatomic, retain) NSString * textLink;
@property (nonatomic, retain) NSString * imageLink;
@property (nonatomic, retain) NSDate * published;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * updatedDate;
@property (nonatomic, retain) NSData * imageData;

+ (void)fillEntry:(Entry *)entry withTitle:(NSString *)title entryId:(NSString *)entryId authorName:(NSString *)authorName authorUri:(NSString *)authorUri linksArray:(NSMutableArray *)linksArray inputPublishedDate:(NSDate *)inputPublishedDate inputUpdatedDate:(NSDate *)inputUpdatedDate;

@end

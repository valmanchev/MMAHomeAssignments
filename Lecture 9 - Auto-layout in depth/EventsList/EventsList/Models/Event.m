//
//  Event.m
//  EventsList
//
//  Created by Valeri Manchev on 4/25/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import "Event.h"

@implementation Event

#pragma mark instancetype Methods

- (instancetype)initWithTitle:(NSString *)title withImage:(NSString *)image withRelatedPerson:(NSString *)relatedPerson withInfo:(NSString *)info withImageData:(NSData *)imageData andDate:(NSString *)date {
    
    self = [self init];
    
    if ( self ) {
        self.title = title;
        self.image = image;
        self.relatedPerson = relatedPerson;
        self.info = info;
        self.imageData = imageData;
        self.date = date;
    }
    
    return self;
}

#pragma mark <NSCoding>

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.image forKey:@"image"];
    [aCoder encodeObject:self.relatedPerson forKey:@"relatedPerson"];
    [aCoder encodeObject:self.info forKey:@"info"];
    [aCoder encodeObject:self.imageData forKey:@"imageData"];
    [aCoder encodeObject:self.date forKey:@"date"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [self init];
    
    self.title = [aDecoder decodeObjectForKey:@"title"];
    self.image = [aDecoder decodeObjectForKey:@"image"];
    self.relatedPerson = [aDecoder decodeObjectForKey:@"relatedPerson"];
    self.info = [aDecoder decodeObjectForKey:@"info"];
    self.imageData = [aDecoder decodeObjectForKey:@"imageData"];
    self.date = [aDecoder decodeObjectForKey:@"date"];
    
    return self;
}

@end

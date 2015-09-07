//
//  Album.m
//  AlbumsOrganiser
//
//  Created by Valeri Manchev on 4/18/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import "Album.h"

@implementation Album

- (instancetype)initWithCover:(NSString *)cover withTitle:(NSString *)title withArtist:(NSString *)artist withReleaseYear:(NSNumber *)releaseYear andSongs:(NSMutableArray *)songs andImageData:(NSData *)imageData {
    self = [self init];
    if (self) {
        self.cover = cover;
        self.title = title;
        self.artist = artist;
        self.releaseYear = releaseYear;
        self.songs = songs;
        self.imageData = imageData;
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.cover forKey:@"cover"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.artist forKey:@"artist"];
    [aCoder encodeObject:self.releaseYear forKey:@"releaseYear"];
    [aCoder encodeObject:self.songs forKey:@"songs"];
    [aCoder encodeObject:self.imageData forKey:@"imageData"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [self init];
    self.cover = [aDecoder decodeObjectForKey:@"cover"];
    self.title = [aDecoder decodeObjectForKey:@"title"];
    self.artist = [aDecoder decodeObjectForKey:@"artist"];
    self.releaseYear = [aDecoder decodeObjectForKey:@"releaseYear"];
    self.songs = [aDecoder decodeObjectForKey:@"songs"];
    self.imageData = [aDecoder decodeObjectForKey:@"imageData"];
    
    return self;
}

@end

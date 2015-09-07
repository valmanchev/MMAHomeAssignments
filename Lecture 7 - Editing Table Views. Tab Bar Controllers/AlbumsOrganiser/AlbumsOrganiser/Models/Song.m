//
//  Song.m
//  AlbumsOrganiser
//
//  Created by Valeri Manchev on 4/18/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import "Song.h"

@implementation Song

- (instancetype)initWithArtistName:(NSString *)artistName withTrackName:(NSString *)trackName {
    self = [self init];
    if (self) {
        self.trackNumber = [NSNumber numberWithLong:0];
        self.artistName = artistName;
        self.trackName = trackName;
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.artistName forKey:@"artistName"];
    [aCoder encodeObject:self.trackName forKey:@"trackName"];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [self init];
    self.artistName = [aDecoder decodeObjectForKey:@"artistName"];
    self.trackName = [aDecoder decodeObjectForKey:@"trackName"];
    
    return self;
}

@end

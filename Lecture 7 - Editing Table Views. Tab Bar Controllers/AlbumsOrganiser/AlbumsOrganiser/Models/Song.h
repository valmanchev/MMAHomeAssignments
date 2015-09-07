//
//  Song.h
//  AlbumsOrganiser
//
//  Created by Valeri Manchev on 4/18/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Song : NSObject <NSCoding>

@property (strong, nonatomic) NSNumber *trackNumber;
@property (strong, nonatomic) NSString *artistName;
@property (strong, nonatomic) NSString *trackName;

- (instancetype)initWithArtistName:(NSString *)artistName withTrackName:(NSString *)trackName;

@end

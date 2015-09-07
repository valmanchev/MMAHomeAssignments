//
//  Album.h
//  AlbumsOrganiser
//
//  Created by Valeri Manchev on 4/18/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Album : NSObject <NSCoding>

@property (strong, nonatomic) NSString *cover;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *artist;
@property (strong, nonatomic) NSNumber *releaseYear;
@property (strong, nonatomic) NSMutableArray *songs;
@property (strong, nonatomic) NSData *imageData;

- (instancetype)initWithCover:(NSString *)cover withTitle:(NSString *)title withArtist:(NSString *)artist withReleaseYear:(NSNumber *)releaseYear andSongs:(NSMutableArray *)songs andImageData:(NSData *)imageData;

@end

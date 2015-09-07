//
//  AlbumsOrganiserInfo.m
//  AlbumsOrganiser
//
//  Created by Valeri Manchev on 4/18/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import "AlbumsOrganiserInfo.h"
#import "Song.h"
#import "Album.h"

@implementation AlbumsOrganiserInfo

+ (id)sharedAlbumsOrganiserInfo {
    static AlbumsOrganiserInfo *sharedAlbumsOrganiserInfo = nil;
    @synchronized(self) {
        if (sharedAlbumsOrganiserInfo == nil)
            sharedAlbumsOrganiserInfo = [[self alloc] init];
    }
    
    return sharedAlbumsOrganiserInfo;
}

- (instancetype)init {
    
    self = [super init];
    
    if ( self ) {
        
        self.albums = [NSMutableArray arrayWithCapacity:0];
        
        [self loadData];
        
        if ([self.albums count] < 2) {
            [self generateAlbumsWithSongs];
            [self saveData];
        }
    }
    
    return self;
}

- (void)generateAlbumsWithSongs {
    
    Song *hotelIntroSong = [[Song alloc] initWithArtistName:@"Moby" withTrackName:@"Hotel Intro"];
    Song *rainingAgainSong = [[Song alloc] initWithArtistName:@"Moby" withTrackName:@"Raining Again"];
    Song *beautifulSong = [[Song alloc] initWithArtistName:@"Moby" withTrackName:@"Beautiful"];
    Song *liftMeUpSong = [[Song alloc] initWithArtistName:@"Moby" withTrackName:@"Lift Me Up"];
    Song *whereYouEndSong = [[Song alloc] initWithArtistName:@"Moby" withTrackName:@"Where You End"];
    
    NSMutableArray *hotelAlbumSongs = [NSMutableArray arrayWithObjects:hotelIntroSong, rainingAgainSong, beautifulSong, liftMeUpSong, whereYouEndSong, nil];
    
    Album *hotelAlbum = [[Album alloc] initWithCover:@"Moby_Hotel.jpg" withTitle:@"Hotel" withArtist:@"Moby" withReleaseYear:[NSNumber numberWithInt:2005] andSongs:hotelAlbumSongs andImageData:[NSData data]];
    
    Song *honeySong = [[Song alloc] initWithArtistName:@"Moby" withTrackName:@"Honey"];
    Song *findMyBabySong = [[Song alloc] initWithArtistName:@"Moby" withTrackName:@"Find My Baby"];
    Song *porcelainSong = [[Song alloc] initWithArtistName:@"Moby" withTrackName:@"Porcelain"];
    Song *southSideSong = [[Song alloc] initWithArtistName:@"Moby" withTrackName:@"South Side"];
    Song *rushingSong = [[Song alloc] initWithArtistName:@"Moby" withTrackName:@"Rushing"];
    
    NSMutableArray *playAlbumSongs = [NSMutableArray arrayWithObjects:honeySong, findMyBabySong, porcelainSong, southSideSong, rushingSong, nil];
    
    Album *playAlbum = [[Album alloc] initWithCover:@"Moby_play.JPG" withTitle:@"Play" withArtist:@"Moby" withReleaseYear:[NSNumber numberWithInt:1999] andSongs:playAlbumSongs andImageData:[NSData data]];
    
    self.albums = [NSMutableArray arrayWithObjects:hotelAlbum, playAlbum, nil];    
}

- (void) saveData {
    
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    if (self.albums != nil) {
        
        // save the albums array
        [dataDict setObject:self.albums forKey:@"albums"];
    }
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *dataDictPath = [documentsDirectoryPath stringByAppendingPathComponent:@"appData.plist"];
    
    [NSKeyedArchiver archiveRootObject:dataDict toFile:dataDictPath];
}

- (void) loadData {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *dataDictPath = [documentsDirectoryPath stringByAppendingPathComponent:@"appData.plist"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:dataDictPath]) {
        
        NSData *data = [NSData dataWithContentsOfFile:dataDictPath];
        NSDictionary *savedData = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        if ([savedData objectForKey:@"albums"] != nil) {
            self.albums = [[NSMutableArray alloc] initWithArray:[savedData objectForKey:@"albums"]];
        }
    }
}

@end

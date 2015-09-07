//
//  AlbumsOrganiserInfo.h
//  AlbumsOrganiser
//
//  Created by Valeri Manchev on 4/18/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Album.h"

@interface AlbumsOrganiserInfo : NSObject

@property (strong, nonatomic) NSMutableArray *albums;
@property (strong, nonatomic) NSNumber *row;
@property (strong, nonatomic) NSNumber *hasLaunchedOnce;
@property (strong, nonatomic) NSNumber *coverImageIndex;

+ (id)sharedAlbumsOrganiserInfo;

- (void) loadData;

- (void) saveData;

@end

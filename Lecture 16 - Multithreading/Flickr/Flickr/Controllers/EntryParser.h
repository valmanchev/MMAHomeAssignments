//
//  EntryParser.h
//  Flickr
//
//  Created by Valeri Manchev on 5/26/15.
//  Copyright (c) 2015 vm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EntryParser : NSObject

@property (nonatomic, strong) NSMutableArray * entryArray;

- (id)initWithArray:(NSMutableArray *)entryArray;

- (void)parseXMLFile;


@end

//
//  EntryParser.m
//  Flickr
//
//  Created by Valeri Manchev on 5/26/15.
//  Copyright (c) 2015 vm. All rights reserved.
//

#import "EntryParser.h"
#import "Entry.h"
#import "FlickrInfo.h"
#import <CoreData/CoreData.h>

@interface EntryParser()

@property (nonatomic, strong) NSXMLParser * parser;
@property (nonatomic, strong) NSString * element;

@property (nonatomic, strong) NSString * currentTitle;
@property (nonatomic, strong) NSString * currentId;
@property (nonatomic, strong) NSString * currentPublished;
@property (nonatomic, strong) NSString * currentUpdated;
@property (nonatomic, strong) NSString * currentContent;
@property (nonatomic, strong) NSString * currentLink;
@property (nonatomic, strong) NSString *currentAuthor;

@end

@implementation EntryParser

- (id)initWithArray:(NSMutableArray *)entryArray {
    self = [super init];
    if ( self ) {
        self.entryArray = entryArray;
    }
    
    return self;
}

- (void)parseXMLFile {
    self.parser = [[NSXMLParser alloc] initWithData:[[FlickrInfo sharedFlickrInfo] data]];
    
    self.parser.delegate = self;
    
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    self.element = elementName;
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if ( [self.element isEqualToString:@"title"] ) {
        self.currentTitle = string;
    } else if ( [self.element isEqualToString:@"id"] ) {
        self.currentId = string;
    } else if ( [self.element isEqualToString:@"published"] ) {
        self.currentPublished = string;
    } else if ( [self.element isEqualToString:@"updated"] ) {
        self.currentUpdated = string;
    } else if ( [self.element isEqualToString:@"content"] ) {
        self.currentContent = string;
    } else if ( [self.element isEqualToString:@"author"] ) {
        self.currentAuthor = string;
    } else if ( [self.element isEqualToString:@"content"] ) {
        self.currentContent = string;
    } else if ( [self.element isEqualToString:@"link"] ) {
        self.currentLink = string;
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ( [elementName isEqualToString:@"entry"] ) {
        Entry *entry = [NSEntityDescription insertNewObjectForEntityForName:@"Entry" inManagedObjectContext:[[FlickrInfo sharedFlickrInfo] getContext]];
        
        entry.title = self.currentTitle;
        
        [[FlickrInfo sharedFlickrInfo] saveContext];
    }
    
    self.element = nil;
}

@end

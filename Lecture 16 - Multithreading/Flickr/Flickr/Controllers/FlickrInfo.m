//
//  FlickrInfo.m
//  Flickr
//
//  Created by Valeri Manchev on 5/26/15.
//  Copyright (c) 2015 vm. All rights reserved.
//

#import "FlickrInfo.h"
#import "XMLDictionary.h"

@implementation FlickrInfo

#pragma mark Class Methods

+ (id)sharedFlickrInfo {
    static FlickrInfo *sharedFlickrInfo = nil;
    
    @synchronized(self) {
        if ( sharedFlickrInfo == nil )
            sharedFlickrInfo = [[self alloc] init];
    }
    
    return sharedFlickrInfo;
}

#pragma mark - Private methods

- (NSDictionary *)loadNewEntriesToDictionary {
    NSURL *URL = [[NSURL alloc] initWithString:@"https://api.flickr.com/services/feeds/photos_public.gne"];
    NSString *xmlString = [[NSString alloc] initWithContentsOfURL:URL encoding:NSUTF8StringEncoding error:NULL];
    NSDictionary *xmlDoc = [NSDictionary dictionaryWithXMLString:xmlString];
    
    return xmlDoc;
}

#pragma mark - Public methods

- (void)saveContext {
    NSError *saveError = nil;
    
    if ( ![[self getContext] save:&saveError] )
    {
        NSLog(@"Save did not complete successfully. Error: %@", [saveError localizedDescription]);
    }
}

- (NSManagedObjectContext *)getContext {
    NSManagedObjectContext *context = nil;
    
    id delegate = [[UIApplication sharedApplication] delegate];
    
    if ( [delegate performSelector:@selector(managedObjectContext)] ) {
        context = [delegate managedObjectContext];
    }
    
    return context;
}

- (NSFetchRequest *)entryRequest {
    NSFetchRequest *entryRequest = [[NSFetchRequest alloc]initWithEntityName:@"Entry"];
    return entryRequest;
}

- (void)loadNewEntries {
    for (NSString* entryKey in [self loadNewEntriesToDictionary]) {
        if ( [entryKey isEqualToString:@"entry"] ) {
            id entries = [[self loadNewEntriesToDictionary] objectForKey:entryKey];
            
//            NSLog(@"%@", entries);
            
            for (NSDictionary *entry in entries) {
                NSMutableArray *linksArray = [[NSMutableArray alloc] initWithCapacity:0];
                
                NSString *title = [entry objectForKey:@"title"];
                NSString *published = [entry objectForKey:@"published"];
                NSString *updated = [entry objectForKey:@"updated"];
                NSString *entryId = [entry objectForKey:@"id"];
                
                NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
                [inputFormatter setDateFormat:@"yyy-MM-dd'T'HH:mm:ssz"];
                NSDate *inputPublishedDate = [inputFormatter dateFromString:published];
                NSDate *inputUpdatedDate = [inputFormatter dateFromString:updated];
                
                NSDictionary *author = [entry objectForKey:@"author"];
                
                NSString *authorName = [author objectForKey:@"name"];
                NSString *authorUri = [author objectForKey:@"uri"];
                
                NSDictionary *links = [entry objectForKey:@"link"];
                
                for (NSDictionary *link in links) {
                    NSString *href = [link objectForKey:@"_href"];
                    
                    [linksArray addObject:href];
                }
                
                NSError *error = nil;
                
                NSArray *entriesArray = [[[FlickrInfo sharedFlickrInfo] getContext] executeFetchRequest:[self entryRequest] error:&error];
                
                [[FlickrInfo sharedFlickrInfo] setExistingEntry:nil];
                
                if (error != nil) {
                    NSLog(@"Error: %@", [error localizedDescription]);
                } else {
                    for (Entry *entryObject in entriesArray) {
                        if ( [entryObject.entryId isEqualToString:entryId] ) {
                            if ( entryObject.updatedDate != inputUpdatedDate ) {
                                [[self entryRequest] setPredicate:[NSPredicate predicateWithFormat:@"entryId like[cd] %@", entryId]];
                                
                                NSArray *existingEntryArray = [[[FlickrInfo sharedFlickrInfo] getContext] executeFetchRequest:[self entryRequest] error:&error];
                                
                                Entry *existingEntry = existingEntryArray[0];
                                
                                [Entry fillEntry:existingEntry withTitle:title entryId:entryId authorName:authorName authorUri:authorUri linksArray:linksArray inputPublishedDate:inputPublishedDate inputUpdatedDate:inputUpdatedDate];
                            }
                            
                            [[FlickrInfo sharedFlickrInfo] setExistingEntry:entryObject];
                            
                            break;
                        }
                    }
                    
                    if ( [[FlickrInfo sharedFlickrInfo] existingEntry] == nil ) {
                        Entry *newEntry = [NSEntityDescription insertNewObjectForEntityForName:@"Entry" inManagedObjectContext:[[FlickrInfo sharedFlickrInfo] getContext]];
                        
                        [Entry fillEntry:newEntry withTitle:title entryId:entryId authorName:authorName authorUri:authorUri linksArray:linksArray inputPublishedDate:inputPublishedDate inputUpdatedDate:inputUpdatedDate];
                    }
                }
            }
        }
    }
}

@end

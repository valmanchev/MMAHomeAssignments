//
//  Event.h
//  EventsList
//
//  Created by Valeri Manchev on 4/25/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Event : NSObject <NSCoding>

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSString *relatedPerson;
@property (strong, nonatomic) NSString *info;
@property (strong, nonatomic) NSString *date;

@property (strong, nonatomic) NSData *imageData;

/**
 *  Event
 *
 *  @param title         title for the Event
 *  @param image         image for this Event
 *  @param relatedPerson name of the related person for the Event
 *  @param info          info for the Event
 *  @param imageData     image for this Event
 *  @param date          date of the Event
 *
 *  @return an instance of type Event
 */
- (instancetype)initWithTitle:(NSString *)title withImage:(NSString *)image withRelatedPerson:(NSString *)relatedPerson withInfo:(NSString *)info withImageData:(NSData *)imageData andDate:(NSString *)date;

@end

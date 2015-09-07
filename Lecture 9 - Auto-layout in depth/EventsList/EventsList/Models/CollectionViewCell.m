//
//  MyCell.m
//  EventsList
//
//  Created by Valeri Manchev on 4/26/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import "CollectionViewCell.h"
#import "Event.h"

@implementation CollectionViewCell

#pragma mark Public Methods

- (void)setEvent:(Event *)event {
    self.titleLabel.text = event.title;
    
    [self setEventImageToEvent:event];
    
    self.relatedPersonLabel.text = event.relatedPerson;
    self.hoursLabel.text = [self getDateFromEvent:event];
    
    NSArray *infoLines = [event.info componentsSeparatedByString:@"\n"];
    NSArray *infoFirstLineSentences = [infoLines[0] componentsSeparatedByString:@". "];
    
    self.infoLabel.text = infoFirstLineSentences[0];
}

#pragma mark Private Methods

- (void)setEventImageToEvent:(Event *)event {
    if ( [event.image length] > 0 ) {
        UIImage *eventImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@", event.image]];
        
        NSData *imageData = UIImagePNGRepresentation(eventImage);
        
        event.imageData = imageData;
    }
    
    NSData *pngData = event.imageData;
    
    UIImage *image = [UIImage imageWithData:pngData];
    
    if ( image == nil ) {
        self.eventImageView.image = [UIImage imageNamed:@"Images/no-image-half-landscape.png"];
    } else {
        self.eventImageView.image = image;
    }
}

- (NSString *)getDateFromEvent:(Event *)event {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd hh:mm:ss zzz"];
    NSDate *eventDate = [[NSDate alloc] init];
    eventDate = [dateFormat dateFromString:event.date];
    [dateFormat setDateFormat:@"hh:mm"];
    NSString *date = [dateFormat stringFromDate:eventDate];
    
    return date;
}

@end

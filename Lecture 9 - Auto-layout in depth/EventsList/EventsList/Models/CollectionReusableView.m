//
//  MyHeader.m
//  EventsList
//
//  Created by Valeri Manchev on 4/28/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import "CollectionReusableView.h"
#import "Event.h"

@implementation CollectionReusableView

#pragma mark Private Methods

- (NSString *)getDateFromEvent:(Event *)event {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd hh:mm:ss zzz"];
    NSDate *eventDate = [[NSDate alloc] init];
    eventDate = [dateFormat dateFromString:event.date];
    [dateFormat setDateFormat:@"EEE dd MMM"];
    NSString *date = [dateFormat stringFromDate:eventDate];
    
    return date;
}

#pragma mark Public Methods

- (void)setDateFromEvent:(Event *)event {
    self.dayLabel.text = [self getDateFromEvent:event];
}

@end

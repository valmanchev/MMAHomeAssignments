//
//  EventsListInfo.h
//  EventsList
//
//  Created by Valeri Manchev on 4/25/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Event.h"

@interface EventsListInfo : NSObject

@property (strong, nonatomic) NSMutableArray *events;
@property (strong, nonatomic) NSMutableArray *eventsByDates;

@property (strong, nonatomic) Event *selectedEvent;

@property (strong, nonatomic) NSNumber *itemsPerRow;

/**
 *  EventsListInfo
 *
 *  @return singleton instance of type EventsListInfo
 */
+ (id)sharedEventsListInfo;

/**
 *  Save the existing events to file
 */
- (void)saveData;

/**
 *  Add Event to existing events
 *
 *  @param event an instance of type Event
 */
- (void)addEvent:(Event *)event;

/**
 *  Remove Event from existing events
 *
 *  @param event an instance of type Event
 */
- (void)removeEvent:(Event *)event;

@end

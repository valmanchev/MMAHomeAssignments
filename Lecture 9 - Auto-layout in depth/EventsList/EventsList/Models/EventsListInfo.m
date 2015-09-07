//
//  EventsListInfo.m
//  EventsList
//
//  Created by Valeri Manchev on 4/25/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import "EventsListInfo.h"

@implementation EventsListInfo

#pragma mark instancetype Methods

- (instancetype)init {
    self = [super init];
    
    if ( self ) {
        self.events = [NSMutableArray arrayWithCapacity:0];
        
        [self loadData];
        [self generateEventsByDates];
        
        if ( [self.events count] < 4 ) {
            [self generateEvents];
            [self saveData];
        }
    }
    
    return self;
}

#pragma mark Class Methods

+ (id)sharedEventsListInfo {
    static EventsListInfo *sharedEventsListInfo = nil;
    
    @synchronized(self) {
        if ( sharedEventsListInfo == nil )
            sharedEventsListInfo = [[self alloc] init];
    }
    
    return sharedEventsListInfo;
}

#pragma mark Public Methods

- (void)saveData {
    NSMutableDictionary *dataDict = [[NSMutableDictionary alloc] initWithCapacity:0];
    
    if ( self.events != nil ) {
        
        // save the events array
        [dataDict setObject:self.events forKey:@"events"];
    }
    
    [NSKeyedArchiver archiveRootObject:dataDict toFile:[self dataDictPath]];
}

- (void)addEvent:(Event *)event {
    [self.events addObject:event];
    [self generateEventsByDates];
}

- (void)removeEvent:(Event *)event {
    [self.events removeObject:event];
    [self generateEventsByDates];
}

#pragma mark Private Methods

- (void)generateEvents {
    Event *bedroom = [[Event alloc] initWithTitle:@"BEDROOM Beach GRAND OPENING 2015" withImage:@"Images/BEDROOM.jpg" withRelatedPerson:@"MASCOTA" withInfo:@"For reservations and more information:\n\n08888 60666, 0888 764422\n\nwww.bedroom.bg\nwww.facebook.com/bedroombeach\nwww.twitter.com/bedroomclub" withImageData:[NSData data] andDate:@"2015-05-29 07:30:00 +0000"];
    Event *absolventska = [[Event alloc] initWithTitle:@"Абсолвентска" withImage:@"Images/absolventska.jpg" withRelatedPerson:@"Венцислав Радков" withInfo:@"Заповядайте, да се изкъртим заедно!" withImageData:[NSData data] andDate:@"2015-05-29 08:00:00 +0000"];
    Event *airborn = [[Event alloc] initWithTitle:@"AIRBORN with DEEP DISH LIVE & BLOND:ISH" withImage:@"Images/AIRBORN.jpg" withRelatedPerson:@"AIRBORN" withInfo:@"*Deep Dish за първи път в България!\n\nСлед по-малко от два месеца, на 5 юни, в парка на летище София ще се проведе първото издание на AIRBORN, с подкрепата на SOLAR и HEINEKEN. За летящ старт на новороденото събитие пристига емблематичното дуо DEEP DISH (Dubfire & Sharam). Към тях ще се присъедини още едно магнетичното дуо, а именно двете нежни половинки на BLOND:ISH." withImageData:[NSData data] andDate:@"2015-06-05 07:00:00 +0000"];
    Event *white = [[Event alloc] initWithTitle:@"WHITE DEVILS" withImage:@"Images/WHITE.jpg" withRelatedPerson:@"DJ MASCOTA" withInfo:@"For Reservations: 08888 60666, 0888 764422\n\nwww.bedroom.bg\nwww.facebook.com/bedroomclub\nwww.twitter.com/bedroomclub" withImageData:[NSData data] andDate:@"2015-04-24 07:30:00 +0000"];
    
    self.events = [NSMutableArray arrayWithObjects:bedroom, absolventska, airborn, white, bedroom, absolventska, airborn, white, nil];
    
    [self generateEventsByDates];
}

- (NSString *)dataDictPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *dataDictPath = [documentsDirectoryPath stringByAppendingPathComponent:@"appData.plist"];
    return dataDictPath;
}

- (void)loadData {
    if ( [[NSFileManager defaultManager] fileExistsAtPath:[self dataDictPath]] ) {
        NSData *data = [NSData dataWithContentsOfFile:[self dataDictPath]];
        NSDictionary *savedData = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
        if ( [savedData objectForKey:@"events"] != nil ) {
            self.events = [[NSMutableArray alloc] initWithArray:[savedData objectForKey:@"events"]];
        }
    }
}

- (void)generateEventsByDates {
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    
    [self.events sortUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    self.eventsByDates = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *eventsByDate = [NSMutableArray arrayWithCapacity:0];
    
    for (int i = 0; i < [self.events count]; i++) {
        Event *currentEvent = [self.events objectAtIndex:i];
        
        if ( i == [self.events count] - 1 ) {
            [eventsByDate addObject:currentEvent];
            [self.eventsByDates addObject:eventsByDate];
            
            break;
        }
        
        Event *nextEvent = [self.events objectAtIndex:i + 1];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        
        NSString *currentEventDateString = [currentEvent.date substringToIndex:10];
        NSString *nextEventDateString = [nextEvent.date substringToIndex:10];
        
        NSDate *currentEventDate = [[NSDate alloc] init];
        NSDate *nextEventDate = [[NSDate alloc] init];
        
        currentEventDate = [dateFormat dateFromString:currentEventDateString];
        nextEventDate = [dateFormat dateFromString:nextEventDateString];
        
        NSString *currentDate = [dateFormat stringFromDate:currentEventDate];
        NSString *nextDate = [dateFormat stringFromDate:nextEventDate];
        
        if ( [currentDate isEqualToString:nextDate] ) {
            [eventsByDate addObject:currentEvent];
        } else {
            [eventsByDate addObject:currentEvent];
            [self.eventsByDates addObject:eventsByDate];
            
            eventsByDate = [NSMutableArray arrayWithCapacity:0];
        }
    }
}

@end

//
//  VacationsInfo.m
//  Vacations
//
//  Created by Valeri Manchev on 4/10/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import "VacationsInfo.h"

@implementation VacationsInfo {
    NSString *monasteryDescription;
    NSString *villaDescription;
    NSString *hotelDescription;
    NSArray *path;
    NSString *documentFolder;
    NSString *filePath;
}

+ (id)sharedVacationsInfo {
    static VacationsInfo *sharedVacationsInfo = nil;
    @synchronized(self) {
        if (sharedVacationsInfo == nil)
            sharedVacationsInfo = [[self alloc] init];
    }
    
    return sharedVacationsInfo;
}

- (instancetype)init {
    self = [super init];
    if ( self ) {
        self.availableVacations = [NSMutableArray arrayWithCapacity:0];
        
        [self generateVacationsFromPlist];
        
        if ([self.availableVacations count] < 3) {
            [self generateVacations];
        }
    }
    
    return self;
}

- (NSString *)loadFileWithName:(NSString *)name {
    NSString *pathForResource = [[NSBundle mainBundle] pathForResource:name ofType:@"txt"];
    NSString *result = [NSString stringWithContentsOfFile:pathForResource usedEncoding:nil error:nil];
    
    return result;
}

- (void)generateVacations {
    monasteryDescription = [self loadFileWithName:@"Monastery"];
    villaDescription = [self loadFileWithName:@"Villa"];
    hotelDescription = [self loadFileWithName:@"Hotel"];
    
    Vacation *monastery = [[Vacation alloc] initWithType:Monastery
                                                withName:@"St. Mina"
                                         withInformation:monasteryDescription
                                            withLocation:@"Sofia"
                                            withOpenDays:[NSMutableArray arrayWithObjects:@"Wednesday", @"Thursday", @"Friday", @"Saturday", @"Sunday", nil]
                                               withPrice:[NSNumber numberWithDouble:20]
                                               withImage:@"Haghpat-Nshan.jpg"
                                         withReviewCount:[NSNumber numberWithDouble:0]
                                                isBooked:[NSNumber numberWithDouble:0]];
    Vacation *villa = [[Vacation alloc] initWithType:Villa
                                            withName:@"Beklemeto"
                                     withInformation:villaDescription
                                        withLocation:@"Troyan"
                                        withOpenDays:[NSMutableArray arrayWithObjects:@"Friday", @"Saturday", @"Sunday", @"Monday", nil]
                                           withPrice:[NSNumber numberWithDouble:60]
                                           withImage:@"Villa-Canberra-lifestylehouse.jpg"
                                     withReviewCount:[NSNumber numberWithDouble:0]
                                            isBooked:[NSNumber numberWithDouble:0]];
    Vacation *hotel = [[Vacation alloc] initWithType:Hotel
                                            withName:@"Grand Hotel Velingrad"
                                     withInformation:hotelDescription
                                        withLocation:@"Velingrad"
                                        withOpenDays:[NSMutableArray arrayWithObjects:@"Sunday", @"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday", nil]
                                           withPrice:[NSNumber numberWithDouble:130]
                                           withImage:@"_500____college-hotelp1diapo1_718.jpg"
                                     withReviewCount:[NSNumber numberWithDouble:0]
                                            isBooked:[NSNumber numberWithDouble:0]];
    
    [self addVacation:monastery];
    [self addVacation:villa];
    [self addVacation:hotel];
}

- (void)addVacation:(Vacation *)vacation {
    [self.availableVacations addObject:vacation];
}

- (void)removeVacation:(Vacation *)vacation {
    [self.availableVacations removeObject:vacation];
    [self.bookedVacations removeObject:vacation];
}

- (void)bookVacation:(Vacation *)vacation {
    [self.bookedVacations addObject:vacation];
}

- (void)inactiveVacation:(Vacation *)vacation {
    [self.bookedVacations removeObject:vacation];
}

- (Vacation *)generateRandomVacation {
    
    // loading the descriptions of the vacations from text files
    monasteryDescription = [self loadFileWithName:@"Monastery"];
    villaDescription = [self loadFileWithName:@"Villa"];
    hotelDescription = [self loadFileWithName:@"Hotel"];
    
    // creating arrays with different information about vacations
    NSArray *vacationDescriptions = [NSArray arrayWithObjects:
                                     monasteryDescription,
                                     villaDescription,
                                     hotelDescription, nil];
    NSArray *vacationTypes = [NSArray arrayWithObjects:
                              @"Monastery",
                              @"Villa",
                              @"Hotel", nil];
    NSArray *vacationImages = [NSArray arrayWithObjects:
                               @"Haghpat-Nshan.jpg",
                               @"Villa-Canberra-lifestylehouse.jpg",
                               @"_500____college-hotelp1diapo1_718.jpg", nil];
    NSArray *vacationNames = [NSArray arrayWithObjects:
                              @"St. Mina",
                              @"Beklemeto",
                              @"Grand Hotel Velingrad", nil];
    NSArray *vacationLocations = [NSArray arrayWithObjects:
                                  @"Sofia",
                                  @"Troyan",
                                  @"Velingrad", nil];
    NSArray *weekdays = [NSArray arrayWithObjects:
                         @"Sunday",
                         @"Monday",
                         @"Tuesday",
                         @"Wednesday",
                         @"Thursday",
                         @"Friday",
                         @"Saturday", nil];
    
    NSUInteger randomVacationIndex = arc4random() % [vacationTypes count];
    NSUInteger randomVacationPrice = 20 + arc4random() % (200 - 20 + 1);
    NSMutableArray *openDays = [NSMutableArray arrayWithCapacity:0];

    for (int i = 0; i <= [weekdays count] - 1; i++) {
        BOOL isOpenDay = arc4random_uniform(2);
        if (isOpenDay) {
            NSString *openDay = [weekdays objectAtIndex:i];
            [openDays addObject:openDay];
        }
    }
    
    Vacation *randomVacation = [[Vacation alloc] initWithType:(int)randomVacationIndex
                                                     withName:vacationNames[randomVacationIndex]
                                              withInformation:vacationDescriptions[randomVacationIndex]
                                                 withLocation:vacationLocations[randomVacationIndex]
                                                 withOpenDays:openDays withPrice:[NSNumber numberWithInteger:(int)randomVacationPrice]
                                                    withImage:vacationImages[randomVacationIndex]
                                              withReviewCount:[NSNumber numberWithDouble:0]
                                                     isBooked:[NSNumber numberWithDouble:0]];
    
    return randomVacation;
}

- (NSString *)convertToString:(VacationType)whichType {
    NSString *result = nil;
    
    switch (whichType) {
        case Monastery:
            result = @"Monastery";
            break;
        case Villa:
            result = @"Villa";
            break;
        case Hotel:
            result = @"Hotel";
            break;
        default:
            break;
    }
    
    return result;
}

- (void)generateVacationsFromPlist {
    NSMutableArray *plistArray = [self loadArray];
    int vacationType;
    
    for (NSMutableArray *plistVacation in plistArray) {
        if ([plistVacation[1] isEqual:@"St. Mina"]) {
            vacationType = 0;
        }
        else if ([plistVacation[1] isEqual:@"Beklemeto"]) {
            vacationType = 1;
        }
        else {
            vacationType = 2;
        }
        
        Vacation *vacation = [[Vacation alloc] initWithType:vacationType
                                                   withName:[plistVacation objectAtIndex:1]
                                            withInformation:[plistVacation objectAtIndex:2]
                                               withLocation:[plistVacation objectAtIndex:3]
                                               withOpenDays:[plistVacation objectAtIndex:4]
                                                  withPrice:[plistVacation objectAtIndex:5]
                                                  withImage:[plistVacation objectAtIndex:6]
                                            withReviewCount:[plistVacation objectAtIndex:7]
                                                   isBooked:[plistVacation objectAtIndex:8]];
        
        [self.availableVacations addObject:vacation];
    }
}

- (void)saveArray:(NSMutableArray *)array {
    NSString *vacationDescription;
    NSMutableArray *vacationBook = [NSMutableArray arrayWithCapacity:0];
    NSString *vacationType;
    
    for (int i = 0; i <= [self.availableVacations count] - 1; i++) {
        Vacation *selectedVacation = [self.availableVacations objectAtIndex:i];
        
        if ([selectedVacation.name isEqual:@"St. Mina"]) {
            vacationDescription = monasteryDescription;
            vacationType = [self convertToString:Monastery];
        }
        else if ([selectedVacation.name isEqual:@"Beklemeto"]) {
            vacationDescription = villaDescription;
            vacationType = [self convertToString:Villa];
        }
        else {
            vacationDescription = hotelDescription;
            vacationType = [self convertToString:Hotel];
        }
        
        NSMutableArray *plistVacation = [NSMutableArray arrayWithObjects:
                                         vacationType,
                                         selectedVacation.name,
                                         vacationDescription,
                                         selectedVacation.location,
                                         selectedVacation.openDays,
                                         selectedVacation.price,
                                         selectedVacation.image,
                                         selectedVacation.reviewCount,
                                         selectedVacation.isBooked, nil];
        
        [vacationBook addObject:plistVacation];
    }
    
    [self generateFilePath];

    [vacationBook writeToFile:filePath atomically:YES];
}

- (void)generateFilePath {
    path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    documentFolder = [path objectAtIndex:0];
    filePath = [documentFolder stringByAppendingFormat:@"vacationBook.plist"];
}

- (NSMutableArray *)loadArray {
    [self generateFilePath];
    
    NSMutableArray *plistArray = [NSMutableArray arrayWithContentsOfFile:filePath];
    
    return plistArray;
}

@end

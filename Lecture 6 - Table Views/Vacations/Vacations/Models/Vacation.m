//
//  Vacation.m
//  Vacations
//
//  Created by Valeri Manchev on 4/10/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import "Vacation.h"

@implementation Vacation

- (instancetype)initWithType:(VacationType)type
                    withName:(NSString *)name
             withInformation:(NSString *)info
                withLocation:(NSString *)location
                withOpenDays:(NSMutableArray *)openDays
                   withPrice:(NSNumber *)price
                   withImage:(NSString *)image
             withReviewCount:(NSNumber *)reviewCount
                    isBooked:(NSNumber *)isBooked {
    
    self = [self init];
    if (self) {
        self.type = type;
        self.name = name;
        self.info = info;
        self.location = location;
        self.openDays = openDays;
        self.price = price;
        self.reviewCount = reviewCount;
        self.image = image;
        self.isBooked = isBooked;
    }
    
    return self;
}

@end

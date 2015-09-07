//
//  Vacation.h
//  Vacations
//
//  Created by Valeri Manchev on 4/10/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    Monastery,
    Villa,
    Hotel
} VacationType;

@interface Vacation : NSObject

@property (nonatomic) VacationType type;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *image;
@property (strong, nonatomic) NSString *info;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSMutableArray *openDays;
@property (strong, nonatomic) NSNumber *price;
@property (strong, nonatomic) NSNumber *reviewCount;
@property (strong, nonatomic) NSNumber *isBooked;

- (instancetype)initWithType:(VacationType)type withName:(NSString *)name withInformation:(NSString *)info withLocation:(NSString *)location withOpenDays:(NSMutableArray *)openDays withPrice:(NSNumber *)price withImage:(NSString *)image withReviewCount:(NSNumber *)reviewCount isBooked:(NSNumber *)isBooked;

@end

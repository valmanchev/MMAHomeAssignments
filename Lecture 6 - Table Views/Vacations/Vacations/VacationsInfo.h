//
//  VacationsInfo.h
//  Vacations
//
//  Created by Valeri Manchev on 4/10/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vacation.h"

@interface VacationsInfo : NSObject

@property (strong, nonatomic) NSMutableArray *availableVacations;
@property (strong, nonatomic) NSMutableArray *bookedVacations;
@property (nonatomic) VacationType chosenType;

+ (id)sharedVacationsInfo;

- (Vacation *)generateRandomVacation;

- (void)addVacation:(Vacation *)vacation;
- (void)removeVacation:(Vacation *)vacation;
- (void)bookVacation:(Vacation *)vacation;
- (void)inactiveVacation:(Vacation *)vacation;
- (void)saveArray:(NSMutableArray *)array;

- (NSString *)convertToString:(VacationType)whichType;

@end

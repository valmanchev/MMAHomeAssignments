//
//  BrokerDelegate.h
//  Vacations
//
//  Created by Valeri Manchev on 4/14/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vacation.h"

@protocol BrokerDelegate <NSObject>

- (void)goOnVacation:(Vacation *)selectedVacation;

- (BOOL)isVacation:(Vacation *)vacation openForDate:(NSDate *)date;

- (void)reviewVacation:(Vacation *)vacation;

@end

//
//  VacationViewController.m
//  Vacations
//
//  Created by Valeri Manchev on 4/11/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import "VacationViewController.h"
#import "VacationsInfo.h"

@interface VacationViewController () <BrokerDelegate>

@end

@implementation VacationViewController {
    Vacation *vacation;
    VacationsInfo *vacationsInfo;
    NSString *weekday;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    vacationsInfo = [VacationsInfo sharedVacationsInfo];
    
    self.brokerDelegate = self;
    self.title = @"Vacation Detail";
    self.vacationType.text = [vacationsInfo convertToString:vacationsInfo.chosenType];
    
    for (long i = [vacationsInfo.availableVacations count] - 1; i >= 0; i--) {
        vacation = [vacationsInfo.availableVacations objectAtIndex:i];
        
        if ([[vacationsInfo convertToString:vacation.type] isEqualToString:[vacationsInfo convertToString:vacationsInfo.chosenType]]) {
            
            [self.brokerDelegate reviewVacation:vacation];
            
            self.vacationName.text = vacation.name;
            self.vacationPrice.text = [NSString stringWithFormat:@"$%@", vacation.price];
            self.vacationDescription.text = vacation.info;
            self.vacationImage.image = [UIImage imageNamed:vacation.image];
            if ([vacation.reviewCount integerValue] > 1) {
                self.reviewCountLabel.text = [NSString stringWithFormat:@"%@ views", vacation.reviewCount];
            }
            else {
                self.reviewCountLabel.text = [NSString stringWithFormat:@"%@ view", vacation.reviewCount];
            }
            break;
        }
    }
    
    if ([vacation.isBooked isEqualToNumber:[NSNumber numberWithInt:0]]) {
        [self.bookButton setTitle:@"Book Vacation" forState:UIControlStateNormal];
    }
    else {
        [self.bookButton setTitle:@"Unbook Vacation" forState:UIControlStateNormal];
    }
}

- (IBAction)bookVacation:(id)sender {
    [self.brokerDelegate goOnVacation:vacation];
}

- (void)reviewVacation:(Vacation *)selectedVacation {
    selectedVacation.reviewCount = [NSNumber numberWithLong:[selectedVacation.reviewCount integerValue] + 1];
    
    NSLog(@"reviewCount: %@", selectedVacation.reviewCount);
    
    [vacationsInfo saveArray:vacationsInfo.availableVacations];
}

- (BOOL)isVacation:(Vacation *)selectedVacation openForDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEEE"];
    weekday = [formatter stringFromDate:date];
    
    for (int i = 0; i <= [selectedVacation.openDays count] - 1; i++) {
        if ([[selectedVacation.openDays objectAtIndex:i] isEqual:weekday]) {
            return YES;
        }
    }
    
    return NO;
}

- (void)goOnVacation:(Vacation *)selectedVacation {
    UIAlertView *alert;
    NSString *openDays;
    
    if ([self.brokerDelegate isVacation:selectedVacation openForDate:[NSDate date]]) {
        if ([selectedVacation.isBooked isEqualToNumber:[NSNumber numberWithInt:0]]) {
            selectedVacation.isBooked = [NSNumber numberWithInt:1];
        }
        else {
            selectedVacation.isBooked = [NSNumber numberWithInt:0];
        }
        
        if ([selectedVacation.isBooked isEqualToNumber:[NSNumber numberWithInt:0]]) {
            openDays = [vacation.openDays componentsJoinedByString:@", "];
            [self.bookButton setTitle:@"Book Vacation" forState:UIControlStateNormal];
            alert = [[UIAlertView alloc] initWithTitle:@"CHILL AT HOME" message:[NSString stringWithFormat:@"You Have Successfully Unbooked %@ On %@!", vacation.name, weekday] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        }
        else {
            openDays = [vacation.openDays componentsJoinedByString:@", "];
            [self.bookButton setTitle:@"Unbook Vacation" forState:UIControlStateNormal];
            alert = [[UIAlertView alloc] initWithTitle:@"Bon Voyage" message:[NSString stringWithFormat:@"You Have Successfully Booked %@ On %@!", vacation.name, weekday] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        }
    }
    else {
        openDays = [vacation.openDays componentsJoinedByString:@", "];
        alert = [[UIAlertView alloc] initWithTitle:@"KEEP CALM\nand\nCHILL AT HOME" message:[NSString stringWithFormat:@"%@ Is Not Opened On %@!\nIt is open on %@", vacation.name, weekday, openDays] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    }
    
    [alert show];
    
    [vacationsInfo saveArray:vacationsInfo.availableVacations];
}

@end

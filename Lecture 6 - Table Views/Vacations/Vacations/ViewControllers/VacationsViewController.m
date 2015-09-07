//
//  VacationsViewController.m
//  Vacations
//
//  Created by Valeri Manchev on 4/11/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import "VacationsViewController.h"
#import "VacationsInfo.h"

@implementation VacationsViewController {
    VacationsInfo *vacationsInfo;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    vacationsInfo = [VacationsInfo sharedVacationsInfo];
    Vacation *vacation = [vacationsInfo generateRandomVacation];
    [vacationsInfo addVacation:vacation];
    [vacationsInfo saveArray:vacationsInfo.availableVacations];
}

- (IBAction)chooseType:(id)sender {
    if ([[sender currentTitle] isEqualToString:@"Monastery"]) {
        vacationsInfo.chosenType = Monastery;
    }
    else if ([[sender currentTitle] isEqualToString:@"Villa"]) {
        vacationsInfo.chosenType = Villa;
    }
    else {
        vacationsInfo.chosenType = Hotel;
    }
}

@end

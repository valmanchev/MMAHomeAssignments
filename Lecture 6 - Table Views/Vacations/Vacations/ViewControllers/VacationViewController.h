//
//  VacationViewController.h
//  Vacations
//
//  Created by Valeri Manchev on 4/11/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import "ViewController.h"
#import "BrokerDelegate.h"

@interface VacationViewController : ViewController

@property (weak, nonatomic) IBOutlet UILabel *vacationName;
@property (weak, nonatomic) IBOutlet UILabel *vacationPrice;
@property (weak, nonatomic) IBOutlet UILabel *vacationType;
@property (weak, nonatomic) IBOutlet UITextView *vacationDescription;
@property (weak, nonatomic) IBOutlet UIImageView *vacationImage;
@property (weak, nonatomic) IBOutlet UIButton *bookButton;
@property (weak, nonatomic) id <BrokerDelegate> brokerDelegate;
@property (weak, nonatomic) IBOutlet UILabel *reviewCountLabel;

@end

//
//  DetailApartmentViewController.m
//  RentApartments
//
//  Created by Valeri Manchev on 5/17/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import "DetailApartmentViewController.h"
#import "RentApartmentsInfo.h"
#import "Apartment.h"

@interface DetailApartmentViewController ()

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextView *detailInfoTextView;

@end

@implementation DetailApartmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    Apartment *apartment = [[RentApartmentsInfo sharedRentApartmentsInfo] apartment];
    
    NSData *pngData = apartment.image;
    
    UIImage *image = [UIImage imageWithData:pngData];
    
    if ( image == nil ) {
        self.imageView.image = [UIImage imageNamed:@"Images/1.jpg"];
    } else {
        self.imageView.image = image;
    }
    
    if ( [apartment.type isEqual:@1] ) {
        self.typeLabel.text = @"Single";
    } else {
        self.typeLabel.text = [NSString stringWithFormat:@"%@Rooms", apartment.type];
    }
    
    self.nameLabel.text = apartment.name;
    self.detailInfoTextView.text = apartment.detailInformation;
    self.locationLabel.text = apartment.location;
    self.priceLabel.text = [NSString stringWithFormat:@"$%@", apartment.price];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

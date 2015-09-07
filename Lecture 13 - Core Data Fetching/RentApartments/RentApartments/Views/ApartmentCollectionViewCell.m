//
//  ApartmentCollectionViewCell.m
//  RentApartments
//
//  Created by Valeri Manchev on 5/17/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import "ApartmentCollectionViewCell.h"

@implementation ApartmentCollectionViewCell

#pragma mark Public Methods

- (void)setApartment:(Apartment *)apartment {
    NSData *pngData = apartment.image;
    
    if ( pngData == nil ) {
        self.imageView.image = [UIImage imageNamed:@"Images/1.jpg"];
    } else {
        self.imageView.image = [UIImage imageWithData:pngData];
    }
    
    if ( [apartment.type isEqual:@1] ) {
        self.typeLabel.text = @"Single";
    } else {
        self.typeLabel.text = [NSString stringWithFormat:@"%@Rooms", apartment.type];
    }
    
    self.locationLabel.text = apartment.location;
    self.priceLabel.text = [NSString stringWithFormat:@"$%@", apartment.price];
}

@end

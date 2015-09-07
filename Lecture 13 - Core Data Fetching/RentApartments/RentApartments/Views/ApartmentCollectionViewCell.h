//
//  ApartmentCollectionViewCell.h
//  RentApartments
//
//  Created by Valeri Manchev on 5/17/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Apartment.h"

@interface ApartmentCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

- (void)setApartment:(Apartment *)apartment;

@end

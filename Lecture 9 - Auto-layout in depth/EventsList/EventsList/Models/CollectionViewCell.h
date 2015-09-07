//
//  MyCell.h
//  EventsList
//
//  Created by Valeri Manchev on 4/26/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface CollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *eventImageView;
@property (weak, nonatomic) IBOutlet UILabel *relatedPersonLabel;
@property (weak, nonatomic) IBOutlet UILabel *hoursLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

/**
 *  Fill the CollectionViewCell with information about the Event
 *
 *  @param event an instance of type Event
 */
- (void)setEvent:(Event *)event;

@end

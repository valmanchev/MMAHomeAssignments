//
//  MyHeader.h
//  EventsList
//
//  Created by Valeri Manchev on 4/28/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"

@interface CollectionReusableView : UICollectionReusableView

@property (weak, nonatomic) IBOutlet UILabel *dayLabel;

/**
 *  Set the header of CollectionView section with the Day in a proper formatter way ( “Mon 22 Dec” ).
 *
 *  @param event an instance of type Event
 */
- (void)setDateFromEvent:(Event *)event;

@end

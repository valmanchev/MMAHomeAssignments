//
//  Comment.h
//  RentApartments
//
//  Created by Valeri Manchev on 5/18/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Apartment, User;

@interface Comment : NSManagedObject

@property (nonatomic, retain) NSString * textMessage;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) User *author;
@property (nonatomic, retain) Apartment *apartment;

@end

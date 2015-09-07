//
//  RentApartmentsInfo.h
//  RentApartments
//
//  Created by Valeri Manchev on 5/16/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Apartment.h"

@interface RentApartmentsInfo : NSObject

@property (strong, nonatomic) User *existingUser;
@property (strong, nonatomic) Apartment *apartment;
@property (strong, nonatomic) NSNumber *hasLaunchedOnce;
@property (strong, nonatomic) NSPredicate *finalPredicate;

+ (id)sharedRentApartmentsInfo;

- (void)generateRandomApartment;

- (NSManagedObjectContext *)getContext;

- (void)saveContext;

@end

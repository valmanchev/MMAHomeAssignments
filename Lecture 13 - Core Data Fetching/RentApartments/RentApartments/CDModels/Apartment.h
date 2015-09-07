//
//  Apartment.h
//  RentApartments
//
//  Created by Valeri Manchev on 5/18/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comment;

@interface Apartment : NSManagedObject

@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSNumber * type;
@property (nonatomic, retain) NSString * location;
@property (nonatomic, retain) NSDecimalNumber * price;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * detailInformation;
@property (nonatomic, retain) NSSet *comments;

@end

@interface Apartment (CoreDataGeneratedAccessors)

- (void)addCommentsObject:(Comment *)value;
- (void)removeCommentsObject:(Comment *)value;
- (void)addComments:(NSSet *)values;
- (void)removeComments:(NSSet *)values;

@end

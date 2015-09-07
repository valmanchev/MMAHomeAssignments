//
//  RentApartmentsInfo.m
//  RentApartments
//
//  Created by Valeri Manchev on 5/16/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import "RentApartmentsInfo.h"
#import "Apartment.h"
#import <UIKit/UIKit.h>

@implementation RentApartmentsInfo

- (instancetype)init {
    self = [super init];
    
    if ( self ) {
        [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(onTick) userInfo:nil repeats:YES];
    }
    
    return self;
}

#pragma mark Class Methods

+ (id)sharedRentApartmentsInfo {
    static RentApartmentsInfo *sharedRentApartmentsInfo = nil;
    
    @synchronized(self) {
        if ( sharedRentApartmentsInfo == nil )
            sharedRentApartmentsInfo = [[self alloc] init];
    }
    
    return sharedRentApartmentsInfo;
}

#pragma mark - Private methods

- (void)onTick {
    [self generateRandomApartment];
    [self updateRandomApartment];
    [self deleteRandomApartment];
    
    NSLog(@"onTick");
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Predicate" object:nil];
}

- (void)deleteRandomApartment {
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Apartment"];
    
    NSError *error = nil;
    
    NSArray *apartments = [[self getContext] executeFetchRequest:request error:&error];
    
    if ( error != nil ) {
        NSLog(@"Error: %@", [error localizedDescription]);
    } else {
        NSUInteger randomApartmentIndex = arc4random() % [apartments count];
        
        Apartment *apartment = apartments[randomApartmentIndex];
        
        [[self getContext] deleteObject:apartment];
        
        [self saveContext];
    }
}

- (void)updateRandomApartment {
    NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"Apartment"];
    
    NSError *error = nil;
    
    NSArray *apartments = [[self getContext] executeFetchRequest:request error:&error];
    
    if ( error != nil ) {
        NSLog(@"Error: %@", [error localizedDescription]);
    } else {
        NSUInteger randomApartmentIndex = arc4random() % [apartments count];
        
        Apartment *apartment = apartments[randomApartmentIndex];
        
        NSUInteger randomPrice = arc4random_uniform(101) + 200;
        
        apartment.price = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lu", (unsigned long)randomPrice]];
        
        [self saveContext];
    }
}

#pragma mark - Public methods

- (void)saveContext {
    NSError *saveError = nil;
    
    if ( ![[self getContext] save:&saveError] )
    {
        NSLog(@"Save did not complete successfully. Error: %@", [saveError localizedDescription]);
    }
}

- (void)generateRandomApartment {
    // creating arrays with different information about apartment
    NSArray *images = [NSArray arrayWithObjects:
                       @"Images/1.jpg",
                       @"Images/2.jpg",
                       @"Images/3.jpg",
                       @"Images/4.jpg",
                       @"Images/5.jpg",
                       @"Images/6.jpg",
                       @"Images/7.jpg",
                       @"Images/8.jpg",
                       @"Images/9.jpg",
                       @"Images/10.jpg", nil];
    
    NSArray *locations = [NSArray arrayWithObjects:
                          @"Sofia Studentski grad",
                          @"Sofia Mladost 1",
                          @"Sofia Mladost 2",
                          @"Sofia Mladost 3",
                          @"Sofia Levski",
                          @"Sofia Suhata reka",
                          @"Varna Asparuhovo",
                          @"Varna Izgrev",
                          @"Ruse Rodina 1",
                          @"Ruse Rodina 2", nil];
    
    NSUInteger randomImageIndex = arc4random() % [images count];
    NSUInteger randomLocationIndex = arc4random() % [locations count];
    
    NSUInteger randomType = arc4random_uniform(5) + 1;
    NSUInteger randomPrice = arc4random_uniform(101) + 200;
    
    Apartment *apartment = [NSEntityDescription insertNewObjectForEntityForName:@"Apartment" inManagedObjectContext:[self getContext]];
    
    UIImage *image = [UIImage imageNamed:images[randomImageIndex]];
    
    NSData *data = UIImagePNGRepresentation(image);
    
    apartment.name = @"Apartment";
    apartment.detailInformation = [NSString stringWithFormat:@"Perfect %@ rooms/room apartment just for you! Located in %@. Only for %@ per month!", [NSNumber numberWithUnsignedInteger:randomType], locations[randomLocationIndex], [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lu", (unsigned long)randomPrice]]];
    apartment.image = data;
    apartment.type = [NSNumber numberWithUnsignedInteger:randomType];
    apartment.location = locations[randomLocationIndex];
    apartment.price = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%lu", (unsigned long)randomPrice]];
    
    [self saveContext];
}

- (NSManagedObjectContext *)getContext {
    NSManagedObjectContext *context = nil;
    
    id delegate = [[UIApplication sharedApplication] delegate];
    
    if ( [delegate performSelector:@selector(managedObjectContext)] ) {
        context = [delegate managedObjectContext];
    }
    
    return context;
}

@end

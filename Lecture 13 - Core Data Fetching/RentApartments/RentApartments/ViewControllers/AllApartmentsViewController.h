//
//  AllApartmentsViewController.h
//  RentApartments
//
//  Created by Valeri Manchev on 5/19/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AllApartmentsViewController : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end

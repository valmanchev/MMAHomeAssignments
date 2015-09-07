//
//  AllApartmentsViewController.m
//  RentApartments
//
//  Created by Valeri Manchev on 5/19/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import "AllApartmentsViewController.h"
#import "AppDelegate.h"
#import "ApartmentCollectionViewCell.h"
#import "RentApartmentsInfo.h"

@interface AllApartmentsViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation AllApartmentsViewController

static NSString * const reuseIdentifier = @"ApartmentCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    self.fetchedResultsController = nil;
    
    [self reloadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:@"Predicate" object:nil];
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    
    layout.itemSize = CGSizeMake((self.view.frame.size.width - 2) / 2, 200);
}

- (void)viewDidUnload {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Predicate" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated {    
    [self.collectionView reloadData];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    
    return [sectionInfo numberOfObjects];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ApartmentCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(ApartmentCollectionViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Apartment *apartment = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    [cell setApartment:apartment];
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    
    if ( _fetchedResultsController != nil ) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    // Edit the entity name as appropriate.
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Apartment" inManagedObjectContext:[appDelegate managedObjectContext]];
    
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"type" ascending:NO];
    
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[appDelegate managedObjectContext] sectionNameKeyPath:nil cacheName:nil];
    
    aFetchedResultsController.delegate = self;
    
    self.fetchedResultsController = aFetchedResultsController;
    
    NSPredicate *filterPrediate = [[RentApartmentsInfo sharedRentApartmentsInfo] finalPredicate];
    
    if( filterPrediate ){
        [fetchRequest setPredicate:filterPrediate];
    }
    
    NSError *error = nil;
    if ( ![self.fetchedResultsController performFetch:&error] ) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        
        abort();
    }
    
    return _fetchedResultsController;
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.collectionView reloadData];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.collectionView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]];
            
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.collectionView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]];
            
            break;
            
        default:
            return;
    }
}

#pragma mark - Private methods

-(void)reloadData
{
    NSError *error = nil;
    
    self.fetchedResultsController = nil;
    
    if ( ![self.fetchedResultsController performFetch:&error] ) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    } else {
        [self.collectionView reloadData];
    }
}

#pragma mark <UIContentContainer>

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    
    layout.itemSize = CGSizeMake((size.width - 2) / 2, 200);
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    Apartment *apartment = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    [[RentApartmentsInfo sharedRentApartmentsInfo] setApartment:apartment];
}

@end

//
//  EntriesViewController.m
//  Flickr
//
//  Created by Valeri Manchev on 5/26/15.
//  Copyright (c) 2015 vm. All rights reserved.
//

#import "EntriesViewController.h"
#import "AppDelegate.h"
#import "EntryTableViewCell.h"
#import "FlickrInfo.h"

@interface EntriesViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation EntriesViewController

static NSString * const reuseIdentifier = @"EntryCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:refreshControl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//#pragma mark - IBAction methods
//
//- (IBAction)refreshData:(id)sender {
//    dispatch_async(dispatch_get_global_queue(0,0), ^{
//        [[FlickrInfo sharedFlickrInfo] loadNewEntries];
//    });
//}

#pragma mark - Private methods

- (void)refresh:(UIRefreshControl *)refreshControl {
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        [[FlickrInfo sharedFlickrInfo] loadNewEntries];
        
        [refreshControl endRefreshing];
    });
}

#pragma mark <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    
//    if ( [sectionInfo numberOfObjects] >= 50 ) {
//        return 50;
//    }
    
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EntryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(EntryTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    Entry *entry = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    [cell setEntry:entry];
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
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Entry" inManagedObjectContext:[appDelegate managedObjectContext]];
    
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    [fetchRequest setFetchLimit:50];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"published" ascending:NO];
    
    NSArray *sortDescriptors = @[sortDescriptor];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:[appDelegate managedObjectContext] sectionNameKeyPath:nil cacheName:nil];
    
    aFetchedResultsController.delegate = self;
    
    self.fetchedResultsController = aFetchedResultsController;
    
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
    [self.tableView reloadData];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        default:
            return;
    }
}

#pragma mark <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Entry *entry = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    [[FlickrInfo sharedFlickrInfo] setCurrentEntry:entry];
    
    [[FlickrInfo sharedFlickrInfo] setIsAuthor:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    Entry *entry = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    CGFloat ratio = [EntryTableViewCell cellHeight:entry];
    
    CGFloat height = tableView.frame.size.width * ratio;
    
    return height;
}

@end

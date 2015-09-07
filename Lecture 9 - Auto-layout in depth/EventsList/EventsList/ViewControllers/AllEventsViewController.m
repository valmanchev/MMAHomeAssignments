//
//  AllEventsViewController.m
//  EventsList
//
//  Created by Valeri Manchev on 4/25/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import "AllEventsViewController.h"
#import "EventsListInfo.h"
#import "Event.h"
#import "CollectionViewCell.h"
#import "CollectionReusableView.h"

@interface AllEventsViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation AllEventsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [[EventsListInfo sharedEventsListInfo] setItemsPerRow:[NSNumber numberWithInt:2]];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.collectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return [[[EventsListInfo sharedEventsListInfo] eventsByDates] count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {    
    return [[[[EventsListInfo sharedEventsListInfo] eventsByDates] objectAtIndex:section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CustomIdentifier";
    
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    NSMutableArray *events = [[[EventsListInfo sharedEventsListInfo] eventsByDates] objectAtIndex:indexPath.section];
    
    Event *event = [events objectAtIndex:(int)indexPath.row];
    
    [cell setEvent:event];
        
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = nil;
    
    if ( kind == UICollectionElementKindSectionHeader ) {
        CollectionReusableView *myHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MyHeader" forIndexPath:indexPath];
        
        NSMutableArray *events = [[[EventsListInfo sharedEventsListInfo] eventsByDates] objectAtIndex:indexPath.section];
        
        Event *event = [events objectAtIndex:(int)indexPath.row];
        
        [myHeader setDateFromEvent:event];
        
        reusableview = myHeader;
    }
    
    return reusableview;
}

#pragma mark IBActions

- (IBAction)showItemsPerRow:(id)sender {
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;

    if ( [sender tag] == 2 ) {
        layout.itemSize = CGSizeMake((self.view.frame.size.width) / 2, 160);
        
        [[EventsListInfo sharedEventsListInfo] setItemsPerRow:[NSNumber numberWithInt:2]];
    } else {
        layout.itemSize = CGSizeMake((self.view.frame.size.width) / 3, 160);
        
        [[EventsListInfo sharedEventsListInfo] setItemsPerRow:[NSNumber numberWithInt:3]];
    }
}

#pragma mark <UIContentContainer>

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    
    if ( [[[EventsListInfo sharedEventsListInfo] itemsPerRow] isEqualToNumber:[NSNumber numberWithInt:2]] ) {
        layout.itemSize = CGSizeMake((size.width) / 2, 160);
    } else {
        layout.itemSize = CGSizeMake((size.width) / 3, 160);
    }
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {    
    NSMutableArray *events = [[[EventsListInfo sharedEventsListInfo] eventsByDates] objectAtIndex:indexPath.section];
    
    [[EventsListInfo sharedEventsListInfo] setSelectedEvent:[events objectAtIndex:indexPath.row]];
}

@end

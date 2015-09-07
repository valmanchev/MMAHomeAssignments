//
//  CommentsViewController.m
//  RentApartments
//
//  Created by Valeri Manchev on 5/18/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import "CommentsViewController.h"
#import "Apartment.h"
#import "Comment.h"
#import "RentApartmentsInfo.h"

@interface CommentsViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation CommentsViewController {
    NSArray *comments;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    Apartment *apartment = [[RentApartmentsInfo sharedRentApartmentsInfo] apartment];
    
    comments = [NSArray arrayWithArray:[apartment.comments allObjects]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:@"CreatedNewComment" object:nil];
}

- (void)viewDidUnload:(BOOL)animated {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"CreatedNewComment" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods

-(void)reloadData
{
    Apartment *apartment = [[RentApartmentsInfo sharedRentApartmentsInfo] apartment];
    
    comments = [NSArray arrayWithArray:[apartment.comments allObjects]];

    [self.tableView reloadData];
}

#pragma mark <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [comments count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"CommentCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    Comment *comment = [comments objectAtIndex:indexPath.row];
    
    User *user = comment.author;
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@: %@", user.userName, comment.textMessage];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"dd-MM-yyyy";
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", [format stringFromDate:comment.date]];
    
    return cell;
}

@end

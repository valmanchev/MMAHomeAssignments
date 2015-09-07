//
//  DetailEventViewController.m
//  EventsList
//
//  Created by Valeri Manchev on 4/26/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import "DetailEventViewController.h"
#import "EventsListInfo.h"
#import "Event.h"

@interface DetailEventViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation DetailEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Event *event = [[EventsListInfo sharedEventsListInfo] selectedEvent];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd hh:mm:ss zzz"];
    NSDate *eventDate = [[NSDate alloc] init];
    eventDate = [dateFormat dateFromString:event.date];
    [dateFormat setDateFormat:@"EEE dd MMM hh:mm"];
    NSString *date = [dateFormat stringFromDate:eventDate];
    
    NSData *pngData = event.imageData;
    
    UIImage *image = [UIImage imageWithData:pngData];
    
    UIView *contentView = self.contentView;
    
    UILabel *titleLabel = [[UILabel alloc]init];
    [titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    titleLabel.text = event.title;
    titleLabel.numberOfLines = 2;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel *relatedPersonLabel = [[UILabel alloc]init];
    [relatedPersonLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    relatedPersonLabel.text = event.relatedPerson;
    relatedPersonLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel *dateLabel = [[UILabel alloc]init];
    [dateLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    dateLabel.text = date;
    dateLabel.textAlignment = NSTextAlignmentCenter;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    [imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [imageView setFrame:CGRectMake(10, 10, 220, 220)];
    
    UITextView *descriptionTextView = [[UITextView alloc] init];
    descriptionTextView.text = event.info;
    [descriptionTextView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [contentView addSubview:titleLabel];
    [contentView addSubview:relatedPersonLabel];
    [contentView addSubview:dateLabel];
    [contentView addSubview:imageView];
    [contentView addSubview:descriptionTextView];
    
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(titleLabel, relatedPersonLabel, dateLabel, imageView, descriptionTextView);
    
    NSArray *verticalConstraints = [NSLayoutConstraint
                                    constraintsWithVisualFormat:@"V:|-[titleLabel]-(30)-[relatedPersonLabel]-(10)-[dateLabel]-(10)-[imageView(160)]-(10)-[descriptionTextView(160)]"
                                    options:0 metrics:nil
                                    views:viewsDictionary];
    
    NSArray *titleLabelConstraints = [NSLayoutConstraint
                                      constraintsWithVisualFormat:@"|-[titleLabel]-|"
                                      options:NSLayoutFormatAlignAllBaseline metrics:nil
                                      views:viewsDictionary];
    
    NSArray *relatedPersonLabelConstraints = [NSLayoutConstraint
                                              constraintsWithVisualFormat:@"|-[relatedPersonLabel]-|"
                                              options:NSLayoutFormatAlignAllBaseline metrics:nil
                                              views:viewsDictionary];
    
    NSArray *dateLabelConstraints = [NSLayoutConstraint
                                     constraintsWithVisualFormat:@"|-[dateLabel]-|"
                                     options:NSLayoutFormatAlignAllBaseline metrics:nil
                                     views:viewsDictionary];
    
    NSArray *imageViewConstraints = [NSLayoutConstraint
                                     constraintsWithVisualFormat:@"|-(0)-[imageView(320)]"
                                     options:0 metrics:nil
                                     views:viewsDictionary];
    
    NSArray *descriptionTextViewConstraints = [NSLayoutConstraint
                                               constraintsWithVisualFormat:@"|-[descriptionTextView]-|"
                                               options:0 metrics:nil
                                               views:viewsDictionary];
    
    [contentView addConstraints:verticalConstraints];
    [contentView addConstraints:titleLabelConstraints];
    [contentView addConstraints:relatedPersonLabelConstraints];
    [contentView addConstraints:dateLabelConstraints];
    [contentView addConstraints:imageViewConstraints];
    [contentView addConstraints:descriptionTextViewConstraints];
    
    [self.scrollView setContentSize:CGSizeMake(imageView.frame.size.width, 500)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

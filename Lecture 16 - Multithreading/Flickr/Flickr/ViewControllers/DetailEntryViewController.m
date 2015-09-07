//
//  DetailEntryViewController.m
//  Flickr
//
//  Created by Valeri Manchev on 5/26/15.
//  Copyright (c) 2015 vm. All rights reserved.
//

#import "DetailEntryViewController.h"
#import "FlickrInfo.h"
#import "Entry.h"

@interface DetailEntryViewController ()

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation DetailEntryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.activityIndicator startAnimating];
    
    Entry *entry = [[FlickrInfo sharedFlickrInfo] currentEntry];
    
    NSString *urlAddress;
    
    if ( [[FlickrInfo sharedFlickrInfo] isAuthor] == YES ) {
        urlAddress = entry.authorUri;
    } else {
        urlAddress = entry.textLink;
    }
    
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    
    dispatch_async(dispatch_get_global_queue(0,0), ^{
        [self.webView loadRequest:requestObj];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activityIndicator stopAnimating];
    self.activityIndicator.hidden = YES;
}

@end

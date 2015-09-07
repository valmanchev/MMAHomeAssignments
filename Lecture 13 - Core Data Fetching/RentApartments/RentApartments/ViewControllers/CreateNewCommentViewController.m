//
//  CreateNewCommentViewController.m
//  RentApartments
//
//  Created by Valeri Manchev on 5/18/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import "CreateNewCommentViewController.h"
#import "Comment.h"
#import "User.h"
#import "Apartment.h"
#import "RentApartmentsInfo.h"

@interface CreateNewCommentViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textMessageTextField;

@end

@implementation CreateNewCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    // verify the text field you wanna validate
    if ( textField == self.textMessageTextField ) {
        
        // do not allow the first character to be space | do not allow more than one space
        if ( [string isEqualToString:@" "] ) {
            if ( !textField.text.length )
                return NO;
            if ( [[textField.text stringByReplacingCharactersInRange:range withString:string] rangeOfString:@"  "].length )
                return NO;
        }
        
        // allow backspace
        if ( [textField.text stringByReplacingCharactersInRange:range withString:string].length < textField.text.length ) {
            return YES;
        }
        
        // in case you need to limit the max number of characters
        if ( [textField.text stringByReplacingCharactersInRange:range withString:string].length > 30 ) {
            return NO;
        }
        
        // limit the input to only the stuff in this character set, so no emoji or cirylic or any other insane characters
        NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890.!? "];
        
        if ( [string rangeOfCharacterFromSet:set].location == NSNotFound ) {
            return NO;
        }
        
        return YES;
    }
    
    return YES;
}

#pragma mark - IBActions

- (IBAction)createNewComment:(id)sender {
    if ( [self.textMessageTextField.text isEqualToString:@""] ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Fill the field!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    } else {
        User *user = [[RentApartmentsInfo sharedRentApartmentsInfo] existingUser];
        
        Apartment *apartment = [[RentApartmentsInfo sharedRentApartmentsInfo] apartment];
        
        Comment *comment = [NSEntityDescription insertNewObjectForEntityForName:@"Comment" inManagedObjectContext:[[RentApartmentsInfo sharedRentApartmentsInfo] getContext]];
        
        comment.textMessage = self.textMessageTextField.text;
        comment.date = [NSDate date];
        comment.author = user;
        
        [apartment addCommentsObject:comment];
        
        [[RentApartmentsInfo sharedRentApartmentsInfo] saveContext];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CreatedNewComment" object:nil];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)cancelCreatingNewComment:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

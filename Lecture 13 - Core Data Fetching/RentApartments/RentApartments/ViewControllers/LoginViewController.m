//
//  LoginViewController.m
//  RentApartments
//
//  Created by Valeri Manchev on 5/16/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import "LoginViewController.h"
#import "User.h"
#import "CreateNewUserViewController.h"
#import "RentApartmentsInfo.h"
#import <CoreData/CoreData.h>

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ( [[[RentApartmentsInfo sharedRentApartmentsInfo] hasLaunchedOnce] isEqualToNumber:[NSNumber numberWithInt:0]] ) {
        for (int i = 0; i < 60; i++) {
            [[RentApartmentsInfo sharedRentApartmentsInfo] generateRandomApartment];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // verify the text field you wanna validate
    if ( textField == self.userNameTextField || textField == self.passwordTextField ) {
        // allow backspace
        if ( [textField.text stringByReplacingCharactersInRange:range withString:string].length < textField.text.length ) {
            return YES;
        }
        
        // in case you need to limit the max number of characters
        if ( [textField.text stringByReplacingCharactersInRange:range withString:string].length > 30 ) {
            return NO;
        }
        
        // limit the input to only the stuff in this character set, so no emoji or cirylic or any other insane characters
        NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890._"];
        
        if ( [string rangeOfCharacterFromSet:set].location == NSNotFound ) {
            return NO;
        }
        
        return YES;
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - IBActions

- (IBAction)login:(id)sender {
    if ( [self.userNameTextField.text isEqualToString:@""] || [self.passwordTextField.text isEqualToString:@""] ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Fill all fields!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [[RentApartmentsInfo sharedRentApartmentsInfo] setExistingUser:nil];
        
        [alert show];
    } else {
        NSFetchRequest *request = [[NSFetchRequest alloc]initWithEntityName:@"User"];
        
        NSError *error = nil;
        
        NSArray *users = [[[RentApartmentsInfo sharedRentApartmentsInfo] getContext] executeFetchRequest:request error:&error];
        
        [[RentApartmentsInfo sharedRentApartmentsInfo] setExistingUser:nil];
        
        if (error != nil) {
            NSLog(@"Error: %@", [error localizedDescription]);
        } else {
            for (User *user in users) {
                if ( [user.userName isEqualToString:self.userNameTextField.text] ) {
                    if ( [user.password isEqualToString:self.passwordTextField.text] ) {
                        [[RentApartmentsInfo sharedRentApartmentsInfo] setExistingUser:user];
                        
                        break;
                    }
                }
            }
            
            if ( [[RentApartmentsInfo sharedRentApartmentsInfo] existingUser] == nil ) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wrong User!" message:@"The user is invalid!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
                
                [alert show];
            }
        }
    }
}

#pragma mark - Navigation

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ( [[RentApartmentsInfo sharedRentApartmentsInfo] existingUser] == nil && [identifier isEqualToString:@"segueToAllApartments"] ) {
        return NO;
    }
        
    return YES;
}

@end

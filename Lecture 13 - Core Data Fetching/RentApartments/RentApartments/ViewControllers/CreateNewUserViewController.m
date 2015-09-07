//
//  CreateNewUserViewController.m
//  RentApartments
//
//  Created by Valeri Manchev on 5/16/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import "CreateNewUserViewController.h"
#import "User.h"
#import "RentApartmentsInfo.h"

@interface CreateNewUserViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *nickTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;

@end

@implementation CreateNewUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.    
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
    if ( textField == self.userNameTextField || textField == self.passwordTextField || textField == self.nickTextField ) {
        
        // allow backspace
        if ( [textField.text stringByReplacingCharactersInRange:range withString:string].length < textField.text.length ) {
            return YES;
        }
        
        // in case you need to limit the max number of characters
        if ( [textField.text stringByReplacingCharactersInRange:range withString:string].length > 20 ) {
            return NO;
        }
        
        // limit the input to only the stuff in this character set, so no emoji or cirylic or any other insane characters
        NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890._"];
        
        if ( [string rangeOfCharacterFromSet:set].location == NSNotFound ) {
            return NO;
        }
        
        return YES;
    }
    
    // verify the text field you wanna validate
    if ( textField == self.firstNameTextField || textField == self.lastNameTextField ) {
        
        // allow backspace
        if ( [textField.text stringByReplacingCharactersInRange:range withString:string].length < textField.text.length ) {
            return YES;
        }
        
        // in case you need to limit the max number of characters
        if ( [textField.text stringByReplacingCharactersInRange:range withString:string].length > 30 ) {
            return NO;
        }
        
        // limit the input to only the stuff in this character set, so no emoji or cirylic or any other insane characters
        NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"];
        
        if ( [string rangeOfCharacterFromSet:set].location == NSNotFound ) {
            return NO;
        }
        
        return YES;
    }
    
    // verify the text field you wanna validate
    if ( textField == self.addressTextField ) {
        
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
        NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 "];
        
        if ( [string rangeOfCharacterFromSet:set].location == NSNotFound ) {
            return NO;
        }
        
        return YES;
    }
    
    // verify the text field you wanna validate
    if ( textField == self.ageTextField ) {
        
        // allow backspace
        if ( [textField.text stringByReplacingCharactersInRange:range withString:string].length < textField.text.length ) {
            return YES;
        }
        
        // in case you need to limit the max number of characters
        if ( [textField.text stringByReplacingCharactersInRange:range withString:string].length > 3 ) {
            return NO;
        }
        
        // limit the input to only the stuff in this character set, so no emoji or cirylic or any other insane characters
        NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"1234567890"];
        
        if ( [string rangeOfCharacterFromSet:set].location == NSNotFound ) {
            return NO;
        }
        
        return YES;
    }
    
    return YES;
}

#pragma mark - IBActions

- (IBAction)register:(id)sender {
    if ( [self.userNameTextField.text isEqualToString:@""] ||
        [self.passwordTextField.text isEqualToString:@""] ||
        [self.firstNameTextField.text isEqualToString:@""] ||
        [self.lastNameTextField.text isEqualToString:@""] ||
        [self.nickTextField.text isEqualToString:@""] ||
        [self.addressTextField.text isEqualToString:@""] ||
        [self.ageTextField.text isEqualToString:@""] ) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Fill all fields!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    } else {
        User *user = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:[[RentApartmentsInfo sharedRentApartmentsInfo] getContext]];
        
        user.userName = self.userNameTextField.text;
        user.password = self.passwordTextField.text;
        user.firstName = self.firstNameTextField.text;
        user.lastName = self.lastNameTextField.text;
        user.nick = self.nickTextField.text;
        user.address = self.addressTextField.text;
        user.age = [NSNumber numberWithLong:[self.ageTextField.text integerValue]];
        
        [[RentApartmentsInfo sharedRentApartmentsInfo] saveContext];
        
        [[RentApartmentsInfo sharedRentApartmentsInfo] setExistingUser:user];
    }
}

#pragma mark - Navigation

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    if ( [self.userNameTextField.text isEqualToString:@""] ||
        [self.passwordTextField.text isEqualToString:@""] ||
        [self.firstNameTextField.text isEqualToString:@""] ||
        [self.lastNameTextField.text isEqualToString:@""] ||
        [self.nickTextField.text isEqualToString:@""] ||
        [self.addressTextField.text isEqualToString:@""] ||
        [self.ageTextField.text isEqualToString:@""] ) {
        
        return NO;
    } else {
        return YES;
    }
}

@end

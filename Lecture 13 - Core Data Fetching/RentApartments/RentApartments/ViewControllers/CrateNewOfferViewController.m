//
//  CrateNewOfferViewController.m
//  RentApartments
//
//  Created by Valeri Manchev on 5/17/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import "CrateNewOfferViewController.h"
#import "Apartment.h"
#import "RentApartmentsInfo.h"

@interface CrateNewOfferViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITextField *typeTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;

@end

@implementation CrateNewOfferViewController

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
    if ( textField == self.typeTextField ) {
        
        // allow backspace
        if ( [textField.text stringByReplacingCharactersInRange:range withString:string].length < textField.text.length ) {
            return YES;
        }
        
        // in case you need to limit the max number of characters
        if ( [textField.text stringByReplacingCharactersInRange:range withString:string].length > 1 ) {
            return NO;
        }
        
        // limit the input to only the stuff in this character set, so no emoji or cirylic or any other insane characters
        NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"12345"];
        
        if ( [string rangeOfCharacterFromSet:set].location == NSNotFound ) {
            return NO;
        }
        
        return YES;
    }
    
    // verify the text field you wanna validate
    if ( textField == self.locationTextField ) {
        
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
    if ( textField == self.priceTextField ) {
        
        // allow backspace
        if ( [textField.text stringByReplacingCharactersInRange:range withString:string].length < textField.text.length ) {
            return YES;
        }
        
        // in case you need to limit the max number of characters
        if ( [textField.text stringByReplacingCharactersInRange:range withString:string].length > 30 ) {
            return NO;
        }
        
        // limit the input to only the stuff in this character set, so no emoji or cirylic or any other insane characters
        NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"1234567890."];
        
        if ( [string rangeOfCharacterFromSet:set].location == NSNotFound ) {
            return NO;
        }
        
        return YES;
    }
    
    return YES;
}

#pragma mark - IBActions

- (IBAction)createNewOffer:(id)sender {
    if ( [self.typeTextField.text isEqualToString:@""] || [self.locationTextField.text isEqualToString:@""] || [self.priceTextField.text isEqualToString:@""] ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Fill all fields!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    } else {
        Apartment *apartment = [NSEntityDescription insertNewObjectForEntityForName:@"Apartment" inManagedObjectContext:[[RentApartmentsInfo sharedRentApartmentsInfo] getContext]];
        
        apartment.image = UIImagePNGRepresentation(self.imageView.image);
        apartment.type = [NSNumber numberWithLong:[self.typeTextField.text integerValue]];
        apartment.location = self.locationTextField.text;
        apartment.price = [NSDecimalNumber decimalNumberWithString:self.priceTextField.text];
        
        [[RentApartmentsInfo sharedRentApartmentsInfo] saveContext];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (IBAction)cancelCreatingNewOffer:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)chooseImage:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark <UIImagePickerControllerDelegate>

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *myImage = [info objectForKey:UIImagePickerControllerEditedImage];
    
    if ( !myImage ) {
        myImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    self.imageView.image = myImage;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    self.imageView.image = [UIImage imageNamed:@"Images/no-image-half-landscape.png"];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

//
//  PopoverViewController.m
//  RentApartments
//
//  Created by Valeri Manchev on 5/19/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import "PopoverViewController.h"
#import "RentApartmentsInfo.h"

@interface PopoverViewController ()

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UISlider *priceFromSlider;
@property (weak, nonatomic) IBOutlet UILabel *priceFromLabel;
@property (weak, nonatomic) IBOutlet UISlider *priceToSlider;
@property (weak, nonatomic) IBOutlet UILabel *priceToLabel;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;

@end

@implementation PopoverViewController {
    NSArray *pickerData;
    NSPredicate *typePredicate;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    pickerData = @[ @[@"Single", @"2Rooms", @"3Rooms", @"4Rooms", @"5Rooms"] ];
    
    typePredicate = [NSPredicate predicateWithFormat:@"type = 1"];
    
    self.priceToLabel.text = [NSString stringWithFormat:@"$%g", floor(self.priceToSlider.value)];
    
    self.priceFromLabel.text = [NSString stringWithFormat:@"$%g", floor(self.priceFromSlider.value)];
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
    
    return YES;
}

#pragma mark - IBActions

- (IBAction)priceTo:(id)sender {
    self.priceToLabel.text = [NSString stringWithFormat:@"$%g", floor(self.priceToSlider.value)];
}

- (IBAction)priceFrom:(id)sender {
    self.priceFromLabel.text = [NSString stringWithFormat:@"$%g", floor(self.priceFromSlider.value)];
}

- (IBAction)search:(id)sender {
    if ( [self.locationTextField.text isEqualToString:@""] ) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error!" message:@"Fill the location!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    } else {
        NSPredicate *pricePredicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"(price >= %@) AND (price <= %@)", [self.priceFromLabel.text substringWithRange:NSMakeRange(1, 3)], [self.priceToLabel.text substringWithRange:NSMakeRange(1, 3)]]];
        
        NSPredicate *locationPredicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"location CONTAINS[c] '%@'", self.locationTextField.text]];
        
        NSPredicate *finalPredicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[typePredicate, pricePredicate, locationPredicate]];
        
        [[RentApartmentsInfo sharedRentApartmentsInfo] setFinalPredicate:finalPredicate];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Predicate" object:nil];
    }
}

- (IBAction)showAll:(id)sender {
    [[RentApartmentsInfo sharedRentApartmentsInfo] setFinalPredicate:nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Predicate" object:nil];
}

#pragma mark <UIPickerViewDataSource>

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return [pickerData count];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [pickerData[component] count];
}

#pragma mark <UIPickerViewDelegate>

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return pickerData[component][row];
}

// Catpure the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    typePredicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"type = %ld", row + 1]];
}

@end

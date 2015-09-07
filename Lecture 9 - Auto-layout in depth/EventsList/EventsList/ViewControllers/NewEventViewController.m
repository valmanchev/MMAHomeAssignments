//
//  NewEventViewController.m
//  EventsList
//
//  Created by Valeri Manchev on 4/27/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import "NewEventViewController.h"
#import "Event.h"
#import "EventsListInfo.h"

@interface NewEventViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *relatedPerson;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation NewEventViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self selectPhotos];
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(hideKeyBoard)];
    
    [self.view addGestureRecognizer:tapGesture];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark IBActions

- (IBAction)addEvent:(id)sender {
    UIImage *coverImage = self.imageView.image;
    
    NSData *imageData = UIImagePNGRepresentation(coverImage);
        
    //get datepicker date (NSDate *)
    NSDate *datePickerDate = [self.datePicker date];
    
    //create a date formatter
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    //set its format as the required output format
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss zzz"];
    
    //get the output date as string
    NSString *outputDateString = [formatter stringFromDate:datePickerDate];
    
    Event *event = [[Event alloc] initWithTitle:self.titleTextField.text withImage:@"" withRelatedPerson:self.relatedPerson.text withInfo:self.descriptionTextField.text withImageData:imageData andDate:outputDateString];
    
    [[EventsListInfo sharedEventsListInfo] addEvent:event];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Event added" message:[NSString stringWithFormat:@"Event with title %@ was added to the events list", event.title] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [[EventsListInfo sharedEventsListInfo] saveData];
    
    [alert show];
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark Private Methods

- (void)selectPhotos {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    // verify the text field you wanna validate
    if ( textField == self.titleTextField || textField == self.relatedPerson || textField == self.descriptionTextField ) {
        
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
        NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890. "];
        
        if ( [string rangeOfCharacterFromSet:set].location == NSNotFound ) {
            return NO;
        }
        
        return YES;
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ( [textField.text length] != 0 ) {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    } else {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    }
}

-(void)hideKeyBoard {
    [self.titleTextField resignFirstResponder];
    [self.relatedPerson resignFirstResponder];
    [self.descriptionTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    
    return YES;
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

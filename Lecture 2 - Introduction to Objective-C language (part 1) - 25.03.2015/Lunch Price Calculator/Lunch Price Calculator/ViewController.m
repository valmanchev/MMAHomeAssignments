//
//  ViewController.m
//  Lunch Price Calculator
//
//  Created by Valeri Manchev on 3/27/15.
//  Copyright (c) 2015 Valeri Manchev. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *literLabel;
@property (weak, nonatomic) IBOutlet UILabel *cocaColaQuantityLabel;
@property (weak, nonatomic) IBOutlet UILabel *soupCurrencyLabel;
@property (weak, nonatomic) IBOutlet UILabel *mainDishCurrencyLabel;
@property (weak, nonatomic) IBOutlet UILabel *desertCurrencyLabel;
@property (weak, nonatomic) IBOutlet UILabel *cocaColaCurrencyLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeDeliveryCurrencyLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceCurrencyLabel;
@property (weak, nonatomic) IBOutlet UITextField *soupQuantity;
@property (weak, nonatomic) IBOutlet UITextField *mainDishQuantity;
@property (weak, nonatomic) IBOutlet UITextField *desertQuantity;
@property (weak, nonatomic) IBOutlet UILabel *soupPrice;
@property (weak, nonatomic) IBOutlet UILabel *mainDishPrice;
@property (weak, nonatomic) IBOutlet UILabel *desertPrice;
@property (weak, nonatomic) IBOutlet UILabel *cocaColaPrice;
@property (weak, nonatomic) IBOutlet UISlider *cocaColaQuantity;
@property (weak, nonatomic) IBOutlet UISwitch *homeDelivery;
@property (weak, nonatomic) IBOutlet UILabel *homeDeliveryPrice;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)calculateTotalPrice {
    self.totalPrice.text = [[NSString stringWithFormat:@"%.2f",
                             [self.soupPrice.text doubleValue] +
                             [self.mainDishPrice.text doubleValue] +
                             [self.desertPrice.text doubleValue] +
                             [self.cocaColaPrice.text doubleValue] +
                             [self.homeDeliveryPrice.text doubleValue]] substringToIndex:4];
}

- (void)changeCurrencyLabelsWithCurrency:(NSString*)currency {
    self.soupCurrencyLabel.text = currency;
    self.mainDishCurrencyLabel.text = currency;
    self.desertCurrencyLabel.text = currency;
    self.cocaColaCurrencyLabel.text = currency;
    self.homeDeliveryCurrencyLabel.text = currency;
    self.totalPriceCurrencyLabel.text = currency;
}

- (void)calculateMealsPriceWithCurrencyConst:(double)currencyConst {
    self.soupPrice.text = [[NSString stringWithFormat:@"%.2f", [self.soupQuantity.text doubleValue] * 2 * currencyConst] substringToIndex:4];
    self.mainDishPrice.text = [[NSString stringWithFormat:@"%.2f", [self.mainDishQuantity.text doubleValue] * 4.5 * currencyConst] substringToIndex:4];
    self.desertPrice.text = [[NSString stringWithFormat:@"%.2f", [self.desertQuantity.text doubleValue] * 1.5 * currencyConst] substringToIndex:4];
    self.cocaColaPrice.text = [[NSString stringWithFormat:@"%.2f", self.cocaColaQuantity.value * 2 * currencyConst] substringToIndex:4];
}

- (void)calculateHomeDeliveryPrice {
    if ([self.homeDelivery isOn]) {
        if ([self.homeDeliveryCurrencyLabel.text isEqual: @"EUR"]) {
            self.homeDeliveryPrice.text = [[NSString stringWithFormat:@"%.2f", 10.0] substringToIndex:4];
        }
        else if ([self.homeDeliveryCurrencyLabel.text isEqual: @"BGN"]) {
            self.homeDeliveryPrice.text = [[NSString stringWithFormat:@"%.2f", 10 * 1.96] substringToIndex:4];
        }
        else {
            self.homeDeliveryPrice.text = [[NSString stringWithFormat:@"%.2f", 10 * 1.09] substringToIndex:4];
        }
    }
    else {
        self.homeDeliveryPrice.text = [NSString stringWithFormat:@"%.2f", 0.0];
    }
}

- (IBAction)dollarButton:(id)sender {
    [self changeCurrencyLabelsWithCurrency:@"$"];
    [self calculateMealsPriceWithCurrencyConst:1.09];
    [self calculateHomeDeliveryPrice];
    [self calculateTotalPrice];
}

- (IBAction)euroButton:(id)sender {
    [self changeCurrencyLabelsWithCurrency:@"EUR"];
    [self calculateMealsPriceWithCurrencyConst:1];
    [self calculateHomeDeliveryPrice];
    [self calculateTotalPrice];
}

- (IBAction)levButton:(id)sender {
    [self changeCurrencyLabelsWithCurrency:@"BGN"];
    [self calculateMealsPriceWithCurrencyConst:1.96];
    [self calculateHomeDeliveryPrice];
    [self calculateTotalPrice];
}

- (void)addMealQuantityandCalculateMealPriceWithQuantity:(int)quantity
                                     ValidationMinNumber:(int)validationMinNumber
                                     ValidationMaxNumber:(int)validationMaxNumber
                                   MealQuantityTextField:(UITextField*)mealQuantityTextField
                                       MealCurrencyLabel:(UILabel*)mealCurrencyLabel
                                          MealPriceLabel:(UILabel*)mealPriceLabel
                                                andPrice:(double)price {
    if ([mealQuantityTextField.text integerValue] >= validationMinNumber && [mealQuantityTextField.text integerValue] <= validationMaxNumber) {
        mealQuantityTextField.text = [NSString stringWithFormat:@"%ld", [mealQuantityTextField.text integerValue] + quantity];
        if ([mealCurrencyLabel.text isEqual: @"EUR"]) {
            mealPriceLabel.text = [[NSString stringWithFormat:@"%f", [mealQuantityTextField.text integerValue] * price] substringToIndex:4];
        }
        else if ([self.soupCurrencyLabel.text isEqual: @"BGN"]) {
            mealPriceLabel.text = [[NSString stringWithFormat:@"%f", [mealQuantityTextField.text integerValue] * price * 1.96] substringToIndex:4];
        }
        else {
            mealPriceLabel.text = [[NSString stringWithFormat:@"%f", [mealQuantityTextField.text integerValue] * price * 1.09] substringToIndex:4];
        }
    }
}

- (IBAction)soupPlusButton:(id)sender {
    [self addMealQuantityandCalculateMealPriceWithQuantity:1
                                       ValidationMinNumber:0
                                       ValidationMaxNumber:9
                                     MealQuantityTextField:self.soupQuantity
                                         MealCurrencyLabel:self.soupCurrencyLabel
                                            MealPriceLabel:self.soupPrice
                                                  andPrice:2.0];
}

- (IBAction)mainDishPlusButton:(id)sender {
    [self addMealQuantityandCalculateMealPriceWithQuantity:1
                                       ValidationMinNumber:0
                                       ValidationMaxNumber:9
                                     MealQuantityTextField:self.mainDishQuantity
                                         MealCurrencyLabel:self.mainDishCurrencyLabel
                                            MealPriceLabel:self.mainDishPrice
                                                  andPrice:4.5];
}

- (IBAction)desertPlusButton:(id)sender {
    [self addMealQuantityandCalculateMealPriceWithQuantity:1
                                       ValidationMinNumber:0
                                       ValidationMaxNumber:9
                                     MealQuantityTextField:self.desertQuantity
                                         MealCurrencyLabel:self.desertCurrencyLabel
                                            MealPriceLabel:self.desertPrice
                                                  andPrice:1.5];
}

- (IBAction)soupMinusButton:(id)sender {
    [self addMealQuantityandCalculateMealPriceWithQuantity:-1
                                       ValidationMinNumber:1
                                       ValidationMaxNumber:10
                                     MealQuantityTextField:self.soupQuantity
                                         MealCurrencyLabel:self.soupCurrencyLabel
                                            MealPriceLabel:self.soupPrice
                                                  andPrice:2.0];
}

- (IBAction)mainDishMinusButton:(id)sender {
    [self addMealQuantityandCalculateMealPriceWithQuantity:-1
                                       ValidationMinNumber:1
                                       ValidationMaxNumber:10
                                     MealQuantityTextField:self.mainDishQuantity
                                         MealCurrencyLabel:self.mainDishCurrencyLabel
                                            MealPriceLabel:self.mainDishPrice
                                                  andPrice:4.5];
}

- (IBAction)desertMinusButton:(id)sender {
    [self addMealQuantityandCalculateMealPriceWithQuantity:-1
                                       ValidationMinNumber:1
                                       ValidationMaxNumber:10
                                     MealQuantityTextField:self.desertQuantity
                                         MealCurrencyLabel:self.desertCurrencyLabel
                                            MealPriceLabel:self.desertPrice
                                                  andPrice:1.5];
}

- (IBAction)cocaColaQuantity:(id)sender {
    if ([self.cocaColaCurrencyLabel.text isEqual: @"EUR"]) {
        self.cocaColaPrice.text = [[NSString stringWithFormat:@"%.2f", self.cocaColaQuantity.value * 2] substringToIndex:4];
    }
    else if ([self.cocaColaCurrencyLabel.text isEqual: @"BGN"]) {
        self.cocaColaPrice.text = [[NSString stringWithFormat:@"%.2f", self.cocaColaQuantity.value * 2 * 1.96] substringToIndex:4];
    }
    else {
        self.cocaColaPrice.text = [[NSString stringWithFormat:@"%.2f", self.cocaColaQuantity.value * 2 * 1.09] substringToIndex:4];
    }

    self.cocaColaQuantityLabel.text = [NSString stringWithFormat:@"%.2f", self.cocaColaQuantity.value];
}

- (IBAction)homeDelivery:(id)sender {
    if ([self.homeDelivery isOn]) {
        if ([self.homeDeliveryCurrencyLabel.text isEqual: @"EUR"]) {
            self.homeDeliveryPrice.text = [[NSString stringWithFormat:@"%.2f", 10.0] substringToIndex:4];
        }
        else if ([self.homeDeliveryCurrencyLabel.text isEqual: @"BGN"]) {
            self.homeDeliveryPrice.text = [[NSString stringWithFormat:@"%.2f", 10 * 1.96] substringToIndex:4];
        }
        else {
            self.homeDeliveryPrice.text = [[NSString stringWithFormat:@"%.2f", 10 * 1.09] substringToIndex:4];
        }
    }
    else {
        self.homeDeliveryPrice.text = [[NSString stringWithFormat:@"%.2f", 0.0] substringToIndex:4];
    }
}

- (IBAction)calculateButton:(id)sender {
    [self calculateTotalPrice];
}

@end

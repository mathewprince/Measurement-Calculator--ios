//
//  ViewController.m
//  MeasurementCalculator
//
//  Created by Prince Mathew on 18/05/16.
//  Copyright © 2016 Prince Mathew. All rights reserved.
//

#import "ViewController.h"
#import "CalculatorModel.h"

@interface ViewController ()

@property (nonatomic) CalculatorModel *calculatorModel;

@end

@implementation ViewController

/**
 This method is called after the controller's view is loaded into memory.
 @param nil
 @return nil
 */
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    _calculatorModel = [[CalculatorModel alloc] init];
    
    self.inputMeasurement.delegate=self;
    self.convertsionPic.delegate=self;
    self.unitPicker.delegate=self;
    
    self.calculatorModel.strselectedType =@"Area";
    self.calculatorModel.strLeftUnit=@"Square KM";
    self.calculatorModel.strRightUnit=@"Square KM";
    
    _inputMeasurement.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
}

/**
 This method is called when the app receives a memory warning.
 @param nil
 @return nil
 */
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/**
 This method is called when the user taps the keyboard’s return button.
 @param inputMeasurement The text field whose return button was pressed.
 @return YES if the text field should implement its default behavior for the return button; otherwise, NO.
 */
- (BOOL) textFieldShouldReturn:(UITextField *)inputMeasurement{
  
    [_inputMeasurement becomeFirstResponder];
    
    // Check if the input is valid.
    NSString *strInputValue = self.inputMeasurement.text;
    if (![self isValidInput:strInputValue]) {
        self.convertedOutput.text=@"Invalid value";
    }
    // Call the convert method of calculatorModel.
    else {
        double inputValue = [strInputValue doubleValue];
        double result = [self.calculatorModel convertUnits :inputValue];
        self.convertedOutput.text = @(result).stringValue;
    }

    [_inputMeasurement resignFirstResponder];
    
    return false;
}


/**
 This method is called by the picker view when it needs the number of components.
 @param pickerView The picker view requesting the data.
 @return the number of components (or “columns”) that the picker view should display.
 */
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    // Convertion picker needsonly one coloumn.
    if (pickerView == self.convertsionPic) {
        return 1;
    }
    // Unit picker has two coloumns.
    if (pickerView == self.unitPicker) {
        return 2;
    }
    return 0;
}


/**
 This method is called by the picker view when it needs the number of rows for a specified component.
 @param pickerView The picker view requesting the data.
 @param component A zero-indexed number identifying a component of pickerView. Components are numbered left-to-right.
 @return the number of rows for the component.
 */
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    // Number of rows of Convertion Picker is equillant to the number of types.
    if (pickerView == self.convertsionPic) {
        return self.calculatorModel.paramArray.count;
    }
    // Number of rows pf Unit Picker is equillant to number of units.
    if (pickerView == self.unitPicker) {
        return [self.calculatorModel.measurementUnitsDictionary[self.calculatorModel.strselectedType] count];
    }
    return 0;
}


/**
 This method is called by the picker view when the user selects a row in a component.
 @param pickerView An object representing the picker view requesting the data.
 @param row A zero-indexed number identifying a row of component. Rows are numbered top-to-bottom.
 @param component A zero-indexed number identifying a component of pickerView. Components are numbered left-to-right.
 @return nothing
 */
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    NSString *strinputValue =  self.inputMeasurement.text;
    double inputValue = [strinputValue doubleValue];
    
    if (pickerView == self.convertsionPic) {
       self.calculatorModel.strselectedType = [self.calculatorModel.paramArray objectAtIndex:row];
        // Reload the unit picker according to the selection in converstion picker.
        [self.unitPicker reloadAllComponents];
    }
    
    // get the selected rows in the unit picker
    NSInteger leftRow = [self.unitPicker selectedRowInComponent:0];
    NSInteger righttRow = [self.unitPicker selectedRowInComponent:1];
    
    //get the 'from' unit and 'to' unit.
    self.calculatorModel.strLeftUnit = self.calculatorModel.measurementUnitsDictionary[self.calculatorModel.strselectedType][leftRow];
    self.calculatorModel.strRightUnit = self.calculatorModel.measurementUnitsDictionary[self.calculatorModel.strselectedType][righttRow];
    
    // validate the input and convert the input value to the required unit.
    if (![self isValidInput:strinputValue]) {
        self.convertedOutput.text=@"Invalid value";
    }
    else {
        double result = [self.calculatorModel convertUnits :inputValue];
        self.convertedOutput.text = @(result).stringValue;
    }
}


/**
 This method is called by the picker view when it needs the title to use for a given row in a given component.
 @param pickerView An object representing the picker view requesting the data.
 @param row A zero-indexed number identifying a row of component. Rows are numbered top-to-bottom.
 @param component A zero-indexed number identifying a component of pickerView. Components are numbered left-to-right.
 @return the string to use as the title of the indicated component row.
 */
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    // select the titles for the convertion picker using the row index
    if (pickerView == self.convertsionPic) {
        return [self.calculatorModel.paramArray objectAtIndex:row];
    }
    // select the titles for the unit picker from units dictionary using the row index.
    if (pickerView == self.unitPicker) {
        return self.calculatorModel.measurementUnitsDictionary[self.calculatorModel.strselectedType][row];
    }
    return 0;
}


/**
 This method is validates the input value given by the user.
 @param inputString the input value given by the user
 @return true if the input is valid else return false.
 */
- (BOOL)isValidInput:(NSString *)inputString{
    
    // Check if the inputis valid
    NSScanner *scanner = [NSScanner scannerWithString:inputString];
    BOOL isValid = [scanner scanDouble:NULL] && [scanner isAtEnd];
    
    return isValid;
}

@end

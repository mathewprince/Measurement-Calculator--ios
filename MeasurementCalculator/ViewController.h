//
//  ViewController.h
//  MeasurementCalculator
//
//  Created by Prince Mathew on 18/05/16.
//  Copyright © 2016 Prince Mathew. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController<UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UITextField *inputMeasurement;
@property (weak, nonatomic) IBOutlet UILabel *convertedOutput;

@property (weak, nonatomic) IBOutlet UIPickerView *convertsionPic;
@property (weak, nonatomic) IBOutlet UIPickerView *unitPicker;
@end


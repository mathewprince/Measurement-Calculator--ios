//
//  CalculatorModel.m
//  MeasurementCalculator
//
//  Created by Prince Mathew on 03/06/16.
//  Copyright © 2016 Prince Mathew. All rights reserved.
//

#import "CalculatorModel.h"

@implementation CalculatorModel
- (id)init {
    self = [super init];
    if (self) {
        self.paramArray = @[@"Area",@"Length",@"Temperature"];
        self.measurementUnitsDictionary = @{@"Area":@[@"Square KM",@"Square meter",@"Square foot"],
                                           @"Length":@[@"Meter",@"Kilometer",@"Mile",@"Foot"],
                                           @"Temperature":@[@"Celsius",@"Fahrenheit",@"Kelvin"]};
    }
    return self;
}

/**
 This method is called by the controller to convert the input value to given unit
 @param value the value to be converted
 @return the converted value.
 */
- (double) convertUnits:(double) value{
    
    double result=0;
    
    // Area
    if ([self.strselectedType isEqualToString:(@"Area")]) {
        result = [self convertAreaType:value];
    }
    // Length
    else if ([self.strselectedType isEqualToString:(@"Length")]) {
        result = [self convertLengthType:value];
    }
    // Temperature
    else if ([self.strselectedType isEqualToString:(@"Temperature")]) {
        result = [self convertTemperatureType:value];
    }
    else {
        NSLog(@"Invalid type");
    }
    
    return result;
}

/**
 This method is called to convert the input value to units of Area
 @param value the value to be converted
 @return the converted value.
 */
-(double) convertAreaType:(double) value{
    
    double result=0;
    
    // If both units are same then return input value.
    if ([self.strLeftUnit isEqualToString:self.strRightUnit]) {
        return value;
    }
    // Square Kilo meter
    if ([self.strLeftUnit isEqualToString:@"Square KM"]) {
        if ([self.strRightUnit isEqualToString:@"Square meter"]) {
            result = value*1000000;
        }
        else if ([self.strRightUnit isEqualToString:@"Square foot"]) {
            result = value*1.076e+7;
        }
    }
    // Square meter
    else if ([self.strLeftUnit isEqualToString:@"Square meter"]) {
        if([self.strRightUnit isEqualToString:@"Square KM"]){
            result = value/1000000;
        }
        else if([self.strRightUnit isEqualToString:@"Square foot"]) {
            result = value*10.7639;
        }
    }
    // Sqaure foot
    else if ([self.strLeftUnit isEqualToString:@"Square foot"]) {
        if([self.strRightUnit isEqualToString:@"Square KM"]){
            result = value/10764000;
        }
        else if ([self.strRightUnit isEqualToString:@"Square meter"]) {
            result = value/10.7639;
        }
    }
    
    return result;
}

/**
 This method is called to convert the input value to units of Length.
 @param value the value to be converted
 @return the converted value.
 */
-(double) convertLengthType:(double) value{
    
    double result=0;
    
    // If both units are same then return input value.
    if ([self.strLeftUnit isEqualToString:self.strRightUnit]) {
        return value;
    }
    // Meter
    if ([self.strLeftUnit isEqualToString:@"Meter"]) {
        if([self.strRightUnit isEqualToString:@"Kilometer"]) {
            result = value/1000;
        }
        else if ([self.strRightUnit isEqualToString:@"Foot"]) {
            result = value*3.28084;
        }
        else if ([self.strRightUnit isEqualToString:@"Mile"]) {
            result = value/1609.34;
        }
    }
    // Kilometer
    else if ([self.strLeftUnit isEqualToString:@"Kilometer"]) {
        if ([self.strRightUnit isEqualToString:@"Meter"]) {
            result = value*1000;
        }
        else if ([self.strRightUnit isEqualToString:@"Foot"]) {
            result = value*3280.84;
        }
        else if ([self.strRightUnit isEqualToString:@"Mile"]) {
            result = value/1.60934;
        }
    }
    // Mile
    else if ([self.strLeftUnit isEqualToString:@"Mile"]) {
        if ([self.strRightUnit isEqualToString:@"Meter"]) {
            result = value*1609.34;
        }
        else if ([self.strRightUnit isEqualToString:@"Kilometer"]) {
            result = value*1.60934;
        }
        else if ([self.strRightUnit isEqualToString:@"Foot"]) {
            result = value*5280;
        }
    }
    // Foot
    else if ([self.strLeftUnit isEqualToString:@"Foot"]) {
        if ([self.strRightUnit isEqualToString:@"Meter"]) {
            result = value/3.28084;
        }
        else if ([self.strRightUnit isEqualToString:@"Kilometer"]) {
            result = value/3280.84;
        }
        else if ([self.strRightUnit isEqualToString:@"Mile"]) {
            result = value/5280;
        }
    }
    
    return result;
}

/**
 This method is called to convert the input value to units of Temperature.
 @param value the value to be converted
 @return the converted value.
 */
-(double) convertTemperatureType:(double) value{
    
    double result=0;
    
    // If both units are same then return input value.
    if ([self.strLeftUnit isEqualToString:self.strRightUnit]) {
        return value;
    }
    // Celsius
    if ([self.strLeftUnit isEqualToString:@"Celsius"]) {
        if([self.strRightUnit isEqualToString:@"Fahrenheit"]) {
            result = value*1.8 + 32;
        }
        else if([self.strRightUnit isEqualToString:@"Kelvin"]) {
            result = value + 273.15;
        }
    }
    // Farenheit
    else if ([self.strLeftUnit isEqualToString:@"Fahrenheit"]) {
        if([self.strRightUnit isEqualToString:@"Celsius"]) {
            result = (value -32)/1.8;
        }
        else if([self.strRightUnit isEqualToString:@"Kelvin"]) {
            result = (value + 459.67)*5/9;
        }
    }
    // Kelvin
    else if ([self.strLeftUnit isEqualToString:@"Kelvin"]) {
        if ([self.strRightUnit isEqualToString:@"Celsius"]) {
            result = value-273.15;
        }
        else if ([self.strRightUnit isEqualToString:@"Fahrenheit"]) {
            result = (value*9/5)-459.67;
        }
    }
    
    return result;
}
@end

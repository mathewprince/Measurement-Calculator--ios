//
//  CalculatorModel.h
//  MeasurementCalculator
//
//  Created by Prince Mathew on 03/06/16.
//  Copyright © 2016 Prince Mathew. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CalculatorModel : NSObject

@property (nonatomic) NSArray *paramArray;
@property (nonatomic) NSDictionary *measurementUnitsDictionary;
@property (nonatomic) NSString *strLeftUnit;
@property (nonatomic) NSString *strRightUnit;
@property (nonatomic) NSString *strselectedType;
- (double) convertUnits:(double) value;
@end

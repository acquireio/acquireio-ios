//
//  HomeViewController.h
//  AcquireSDK
//
//  Created by Raju Jangid on 11/30/18.
//  Copyright © 2018 AcquireIO Inc. All rights reserved.
//

#import "HomeViewController.h"
#import "AppDelegate.h"

@interface HomeViewController (){
    int previousStepperValue;
    int totalNumber;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    
    
    
    NSArray *tabIcons = @[@"home", @"test", @"settings", @"help"];
    
    int t = 0;
    
    for (UITabBarItem *tabBarItem in self.tabBarController.tabBar.items) {
        //UITabBarItem *tabBarItem = [self.tabBarController.tabBar.items objectAtIndex:t];
        
        UIColor *themeColor = [UIColor colorWithRed: 0.349 green: 0.376 blue: 0.976 alpha: 1];
        
        NSString *selectImgName = [NSString stringWithFormat:@"%@_selected", [tabIcons objectAtIndex:t]];
        
        
        UIImage *unselectedImage = [UIImage imageNamed:[tabIcons objectAtIndex:t]];
        UIImage *selectedImage = [UIImage imageNamed:selectImgName];
        
        [tabBarItem setImage: [unselectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        [tabBarItem setSelectedImage: [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        
        [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:10.0f], NSFontAttributeName,  [UIColor grayColor], NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
        
        [tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:10.0f], NSFontAttributeName,  themeColor, NSForegroundColorAttributeName, themeColor, NSBackgroundColorAttributeName,nil] forState:UIControlStateSelected];
        t++;
    }
    
    
    
    [self hydrateDatasets];
    
    _myGraph.delegate = self;
    _myGraph.dataSource = self;
    
    /* This is commented out because the graph is created in the interface with this sample app. However, the code remains as an example for creating the graph using code.
     BEMSimpleLineGraphView *myGraph = [[BEMSimpleLineGraphView alloc] initWithFrame:CGRectMake(0, 60, 320, 250)];
     myGraph.delegate = self;
     myGraph.dataSource = self;
     [self.view addSubview:myGraph]; */
    
    // Create a gradient to apply to the bottom portion of the graph
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    size_t num_locations = 2;
    CGFloat locations[2] = { 0.0, 1.0 };
    CGFloat components[8] = {
        1.0, 1.0, 1.0, 1.0,
        1.0, 1.0, 1.0, 0.0
    };
    
    // Apply the gradient to the bottom portion of the graph
    self.myGraph.gradientBottom = CGGradientCreateWithColorComponents(colorspace, components, locations, num_locations);
    
    // Enable and disable various graph properties and axis displays
    self.myGraph.enableTouchReport = YES;
    self.myGraph.enablePopUpReport = YES;
    self.myGraph.enableYAxisLabel = YES;
    self.myGraph.autoScaleYAxis = YES;
    self.myGraph.alwaysDisplayDots = YES;
    self.myGraph.enableReferenceXAxisLines = YES;
    self.myGraph.enableReferenceYAxisLines = YES;
    self.myGraph.enableReferenceAxisFrame = YES;
    
    // Draw an average line
    self.myGraph.averageLine.enableAverageLine = YES;
    self.myGraph.averageLine.alpha = 0.6;
    self.myGraph.averageLine.color = [UIColor darkGrayColor];
    self.myGraph.averageLine.width = 2.5;
    self.myGraph.averageLine.dashPattern = @[@(2),@(2)];
    
    // Set the graph's animation style to draw, fade, or none
    self.myGraph.animationGraphStyle = BEMLineAnimationDraw;
    
    // Dash the y reference lines
    self.myGraph.lineDashPatternForReferenceYAxisLines = @[@(2),@(2)];
    
    // Show the y axis values with this format string
    self.myGraph.formatStringForValues = @"%.1f";
    
}

-(void)viewWillAppear:(BOOL)animated{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *accID = [[NSUserDefaults standardUserDefaults] objectForKey:@"ACQUIREIO_ACCOUNT_ID"];
        
        if(accID == nil){
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Set Account ID" message:@"Please enter your account uid:\n\nIf don't have acquire account please visit our website" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *signupAction = [UIAlertAction actionWithTitle:@"Sign Up with Acquire" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"https://app.acquire.io/signup"]];
                
            }];
            
            [alert addAction:signupAction];
            
            __block UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                //NSLog(@"text ==> %@", alert.textFields[0].text);
                NSString *accIDEntered = alert.textFields[0].text;
                accIDEntered = [accIDEntered stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
                
                if([accIDEntered length] == 5){
                    [[NSUserDefaults standardUserDefaults] setObject:accIDEntered forKey:@"ACQUIREIO_ACCOUNT_ID"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    
                    AppDelegate *app = (AppDelegate *)[UIApplication sharedApplication].delegate;
                    [app setupAcquireIO];
                }
                //return YES;
            }];
            
            saveAction.enabled = NO;
            [alert addAction:saveAction];
            [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
                textField.placeholder = @"Account uid:";
                [textField addTarget:self action:@selector(alertControllerTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
                
            }];
            [self presentViewController:alert animated:YES completion:nil];
        }
    });
}

-(void)alertControllerTextFieldDidChange:(UITextField *)sender{
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    if (alertController) {
        UITextField *someTextField = alertController.textFields.firstObject;
        UIAlertAction *saveAction = alertController.actions.lastObject;
        
        NSString *accIDEntered = someTextField.text;
        accIDEntered = [accIDEntered stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if([accIDEntered length] == 5){
            saveAction.enabled = YES;
        }else{
            saveAction.enabled = NO;
        }
    }
    
}


- (void)hydrateDatasets {
    // Reset the arrays of values (Y-Axis points) and dates (X-Axis points / labels)
    if (!self.arrayOfValues) self.arrayOfValues = [[NSMutableArray alloc] init];
    if (!self.arrayOfDates) self.arrayOfDates = [[NSMutableArray alloc] init];
    [self.arrayOfValues removeAllObjects];
    [self.arrayOfDates removeAllObjects];
    
    previousStepperValue = 30;
    totalNumber = 0;
    NSDate *baseDate = [NSDate date];
    BOOL showNullValue = NO;
    
    // Add objects to the array based on the stepper value
    for (int i = 0; i < 15; i++) {
        [self.arrayOfValues addObject:@([self getRandomFloat])]; // Random values for the graph
        if (i == 0) {
            [self.arrayOfDates addObject:baseDate]; // Dates for the X-Axis of the graph
        } else if (showNullValue && i == 4) {
            [self.arrayOfDates addObject:[self dateForGraphAfterDate:self.arrayOfDates[i-1]]]; // Dates for the X-Axis of the graph
            self.arrayOfValues[i] = @(BEMNullGraphValue);
        } else {
            [self.arrayOfDates addObject:[self dateForGraphAfterDate:self.arrayOfDates[i-1]]]; // Dates for the X-Axis of the graph
        }
        
        totalNumber = totalNumber + [[self.arrayOfValues objectAtIndex:i] intValue]; // All of the values added together
    }
}

- (int)getRandomFloat {
    int i1 = ceil(arc4random_uniform(1000));
    return i1;
}


- (NSDate *)dateForGraphAfterDate:(NSDate *)date {
    NSTimeInterval secondsInTwentyFourHours = 24 * 60 * 60;
    NSDate *newDate = [date dateByAddingTimeInterval:secondsInTwentyFourHours];
    return newDate;
}

- (NSString *)labelForDateAtIndex:(NSInteger)index {
    NSDate *date = self.arrayOfDates[index];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateFormat = @"MM/dd";
    NSString *label = [df stringFromDate:date];
    return label;
}

#pragma mark - SimpleLineGraph Data Source

- (NSInteger)numberOfPointsInLineGraph:(BEMSimpleLineGraphView *)graph {
    return (int)[self.arrayOfValues count];
}

- (CGFloat)lineGraph:(BEMSimpleLineGraphView *)graph valueForPointAtIndex:(NSInteger)index {
    return [[self.arrayOfValues objectAtIndex:index] doubleValue];
}

#pragma mark - SimpleLineGraph Delegate

- (NSInteger)numberOfGapsBetweenLabelsOnLineGraph:(BEMSimpleLineGraphView *)graph {
    return 2;
}

- (NSString *)lineGraph:(BEMSimpleLineGraphView *)graph labelOnXAxisForIndex:(NSInteger)index {
    
    NSString *label = [self labelForDateAtIndex:index];
    return [label stringByReplacingOccurrencesOfString:@" " withString:@"\n"];
}

- (void)lineGraph:(BEMSimpleLineGraphView *)graph didTouchGraphWithClosestIndex:(NSInteger)index {
 
}

- (void)lineGraph:(BEMSimpleLineGraphView *)graph didReleaseTouchFromGraphWithClosestIndex:(CGFloat)index {
}

- (void)lineGraphDidFinishLoading:(BEMSimpleLineGraphView *)graph {
    
}

/* - (void)lineGraphDidFinishDrawing:(BEMSimpleLineGraphView *)graph {
 // Use this method for tasks after the graph has finished drawing
 } */

- (NSString *)popUpSuffixForlineGraph:(BEMSimpleLineGraphView *)graph {
    return @" visitors";
}

//- (NSString *)popUpPrefixForlineGraph:(BEMSimpleLineGraphView *)graph {
//    return @"$ ";
//}

#pragma mark - Optional Datasource Customizations
/*
 This section holds a bunch of graph customizations that can be made.  They are commented out because they aren't required.  If you choose to uncomment some, they will override some of the other delegate and datasource methods above.
 
 */

//- (NSInteger)baseIndexForXAxisOnLineGraph:(BEMSimpleLineGraphView *)graph {
//    return 0;
//}
//
//- (NSInteger)incrementIndexForXAxisOnLineGraph:(BEMSimpleLineGraphView *)graph {
//    return 2;
//}

//- (NSArray *)incrementPositionsForXAxisOnLineGraph:(BEMSimpleLineGraphView *)graph {
//    NSMutableArray *positions = [NSMutableArray array];
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSInteger previousDay = -1;
//    for(int i = 0; i < self.arrayOfDates.count; i++) {
//        NSDate *date = self.arrayOfDates[i];
//        NSDateComponents * components = [calendar components:NSCalendarUnitDay fromDate:date];
//        NSInteger day = components.day;
//        if(day != previousDay) {
//            [positions addObject:@(i)];
//            previousDay = day;
//        }
//    }
//    return positions;
//
//}
//
//- (CGFloat)baseValueForYAxisOnLineGraph:(BEMSimpleLineGraphView *)graph {
//    NSNumber *minValue = [graph calculateMinimumPointValue];
//    //Let's round our value down to the nearest 100
//    double min = minValue.doubleValue;
//    double roundPrecision = 100;
//    double offset = roundPrecision / 2;
//    double roundedVal = round((min - offset) / roundPrecision) * roundPrecision;
//    return roundedVal;
//}
//
//- (CGFloat)incrementValueForYAxisOnLineGraph:(BEMSimpleLineGraphView *)graph {
//    NSNumber *minValue = [graph calculateMinimumPointValue];
//    NSNumber *maxValue = [graph calculateMaximumPointValue];
//    double range = maxValue.doubleValue - minValue.doubleValue;
//    float increment = 1.0;
//    if (range <  10) {
//        increment = 2;
//    } else if (range < 100) {
//        increment = 10;
//    } else if (range < 500) {
//        increment = 50;
//    } else if (range < 1000) {
//        increment = 100;
//    } else if (range < 5000) {
//        increment = 500;
//    } else {
//        increment = 1000;
//    }
//    return increment;
//}


@end

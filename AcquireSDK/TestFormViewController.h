//
//  TestPageContentViewController.h
//  AcquireSDK
//
//  Created by Raju Jangid on 12/3/18.
//  Copyright © 2018 AcquireIO Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestFormViewController : UIViewController
@property NSUInteger pageIndex;
- (IBAction)selectAgeGroup:(id)sender;
@property (strong, nonatomic) IBOutlet UISlider *ageSlider;
@property (strong, nonatomic) IBOutlet UILabel *ageGroupValue;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *email;

@end

NS_ASSUME_NONNULL_END

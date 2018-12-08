//
//  TestViewController.h
//  AcquireSDK
//
//  Created by Raju Jangid on 11/30/18.
//  Copyright © 2018 AcquireIO Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestViewController : UIViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (strong, nonatomic) UIPageViewController *pageViewController;
- (IBAction)changeSegment:(id)sender;

@end


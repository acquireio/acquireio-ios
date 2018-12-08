//
//  HelpViewController.h
//  AcquireSDK
//
//  Created by Raju Jangid on 12/4/18.
//  Copyright © 2018 AcquireIO Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HelpViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *accountIDView;
@property (strong, nonatomic) IBOutlet UILabel *accId_title;
@property (strong, nonatomic) IBOutlet UILabel *accId_value;

@property (strong, nonatomic) IBOutlet UIButton *sdkInitBtn;
@property (strong, nonatomic) IBOutlet UIButton *changeAccountIDBtn;
@property (strong, nonatomic) IBOutlet UIButton *audioCallBtn;
@property (strong, nonatomic) IBOutlet UIButton *videoBtn;
@property (strong, nonatomic) IBOutlet UIButton *logoutBtn;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;

- (IBAction)sdkInitTouched:(id)sender;
- (IBAction)changeAccountTouched:(id)sender;
- (IBAction)audioCallTouched:(id)sender;
- (IBAction)videoCallTouched:(id)sender;
- (IBAction)logoutTouched:(id)sender;


@end

NS_ASSUME_NONNULL_END

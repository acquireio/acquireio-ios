//
//  TestPaymentFormViewController.h
//  AcquireSDK
//
//  Created by Raju Jangid on 12/3/18.
//  Copyright © 2018 AcquireIO Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestPaymentFormViewController : UIViewController
@property NSUInteger pageIndex;
@property (strong, nonatomic) IBOutlet UITextField *cardNum;
@property (strong, nonatomic) IBOutlet UITextField *cvc;
@end

NS_ASSUME_NONNULL_END

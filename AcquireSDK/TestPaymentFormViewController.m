//
//  TestPaymentFormViewController.m
//  AcquireSDK
//
//  Created by Raju Jangid on 12/3/18.
//  Copyright © 2018 AcquireIO Inc. All rights reserved.
//

#import "TestPaymentFormViewController.h"
#import <AcquireIO/AcquireIO.h>

@interface TestPaymentFormViewController (){
    UIGestureRecognizer *tapper_any_payment_form;
}

@end

@implementation TestPaymentFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[AcquireIO support] addMaskedView:_cardNum];
    [[AcquireIO support] addMaskedView:_cvc];
    
    tapper_any_payment_form = [[UITapGestureRecognizer alloc]
                        initWithTarget:self action:@selector(handleSingleTap:)];
    tapper_any_payment_form.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapper_any_payment_form];
    
    UIImageView *icon1 = (UIImageView *)[self.view viewWithTag:21];
    UIImageView *icon2 = (UIImageView *)[self.view viewWithTag:22];
    UIImageView *icon3 = (UIImageView *)[self.view viewWithTag:23];
    UIImageView *icon4 = (UIImageView *)[self.view viewWithTag:24];
    UIImageView *icon5 = (UIImageView *)[self.view viewWithTag:25];
    UIImageView *icon6 = (UIImageView *)[self.view viewWithTag:26];
    
    icon1.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2f].CGColor;
    icon1.layer.borderWidth = 1.0f;
    icon1.layer.cornerRadius = 2.0f;
    
    icon2.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2f].CGColor;
    icon2.layer.borderWidth = 1.0f;
    icon2.layer.cornerRadius = 2.0f;
    
    icon3.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2f].CGColor;
    icon3.layer.borderWidth = 1.0f;
    icon3.layer.cornerRadius = 2.0f;
    
    icon4.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2f].CGColor;
    icon4.layer.borderWidth = 1.0f;
    icon4.layer.cornerRadius = 2.0f;
    
    icon5.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2f].CGColor;
    icon5.layer.borderWidth = 1.0f;
    icon5.layer.cornerRadius = 2.0f;
    
    icon6.layer.borderColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2f].CGColor;
    icon6.layer.borderWidth = 1.0f;
    icon6.layer.cornerRadius = 2.0f;
    
    
    UIButton *resetBtn = (UIButton *)[self.view viewWithTag:31];
    UIButton *saveBtn = (UIButton *)[self.view viewWithTag:32];
    
    resetBtn.backgroundColor = [UIColor whiteColor];
    resetBtn.layer.borderColor = [UIColor colorWithRed: 0.349 green: 0.376 blue: 0.976 alpha: 1].CGColor;
    resetBtn.layer.borderWidth = 1.0f;
    resetBtn.layer.cornerRadius = 18.0f;
    
    saveBtn.backgroundColor = [UIColor colorWithRed: 0.349 green: 0.376 blue: 0.976 alpha: 1];
    saveBtn.layer.borderColor = [UIColor colorWithRed: 0.349 green: 0.376 blue: 0.976 alpha: 1].CGColor;
    saveBtn.layer.borderWidth = 1.0f;
    saveBtn.layer.cornerRadius = 18.0f;
}

-(void)handleSingleTap:(UITapGestureRecognizer *) sender{
    [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

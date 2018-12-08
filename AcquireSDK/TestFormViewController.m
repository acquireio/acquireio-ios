//
//  TestPageContentViewController.m
//  AcquireSDK
//
//  Created by Raju Jangid on 12/3/18.
//  Copyright © 2018 AcquireIO Inc. All rights reserved.
//

#import "TestFormViewController.h"
#import <AcquireIO/AcquireIO.h>
@interface TestFormViewController (){
    NSArray *ageGroup;
    UIGestureRecognizer *tapper_any_form;
}

@end

@implementation TestFormViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    tapper_any_form = [[UITapGestureRecognizer alloc]
                               initWithTarget:self action:@selector(handleSingleTap:)];
    tapper_any_form.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapper_any_form];
    
    ageGroup = @[@"0 - 14 years", @"14 - 30 years", @"30 - 50 years", @"50 - 70 years", @"70+ years"];
    // Do any additional setup after loading the view.
    
    [[AcquireIO support] addMaskedView:_email];
    [[AcquireIO support] addMaskedView:_password];
    
    [self setValueForAgeGroup:_ageSlider.value];
}

-(void)handleSingleTap:(UITapGestureRecognizer *) sender{
    [self.view endEditing:YES];
}

-(void)setValueForAgeGroup:(NSInteger)val{
    _ageGroupValue.text = [NSString stringWithFormat:@"%@", ageGroup[val-1]];
}

- (IBAction)selectAgeGroup:(id)sender {
    float val = ((UISlider *)sender).value;
    
    NSInteger int_val = ceil(val);
    
    //NSLog(@"%ld", (long)int_val);
    
    [self setValueForAgeGroup:int_val];
    
    
}
@end

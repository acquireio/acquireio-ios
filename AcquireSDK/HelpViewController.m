//
//  HelpViewController.m
//  AcquireSDK
//
//  Created by Raju Jangid on 12/4/18.
//  Copyright © 2018 AcquireIO Inc. All rights reserved.
//

#import "HelpViewController.h"
#import "AppDelegate.h"
#import <AcquireIO/AcquireIO.h>

@interface HelpViewController ()

@end

@implementation HelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *accID = [[NSUserDefaults standardUserDefaults] objectForKey:@"ACQUIREIO_ACCOUNT_ID"];
    
    self.accountIDView.backgroundColor = [UIColor whiteColor];
    
    self.accountIDView.layer.cornerRadius = 5.0f;
     
     self.accountIDView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.accountIDView.bounds cornerRadius:self.accountIDView.layer.cornerRadius].CGPath;
     self.accountIDView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
     self.accountIDView.layer.shadowOpacity = 0.6;
     self.accountIDView.layer.shadowOffset = CGSizeZero;
     self.accountIDView.layer.shadowRadius = 5.0f;
     self.accountIDView.layer.masksToBounds = NO;
    
    self.accId_value.font = [UIFont boldSystemFontOfSize:32];
    self.accId_value.text = accID;
    
    self.sdkInitBtn.layer.cornerRadius = 3.0f;
    self.changeAccountIDBtn.layer.cornerRadius = 3.0f;
    self.audioCallBtn.layer.cornerRadius = 3.0f;
    self.videoBtn.layer.cornerRadius = 3.0f;
    self.logoutBtn.layer.cornerRadius = 3.0f;
    
}


-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    AcquireIOConnectionStatus status = [[AcquireIO support] getConnectionStatus];
    
    NSLog(@"AcquireIOConnectionStatus : %ld", (long)status);
    [self didChangeConnectionStatus:status];
}

-(void) didChangeConnectionStatus:(AcquireIOConnectionStatus)status{
    [self statusUpdate:status];
    
    //NSLog(@"didChangeConnectionStatus %ld", (long)status);
}

-(void)statusUpdate:(AcquireIOConnectionStatus)status{
    if(status == AcquireIOConnectionStatusConnecting){
        self.statusLabel.text = @"Connecting...";
        self.statusLabel.textColor = [UIColor colorWithRed: 0.945 green: 0.498 blue: 0.318 alpha: 1];
    }
    
    if(status == AcquireIOConnectionStatusConnected){
        self.statusLabel.text = @"Connecting...";
        self.statusLabel.textColor = [UIColor greenColor];
    }
    
    if(status == AcquireIOConnectionStatusSessionStarted){
        self.statusLabel.text = @"Connected";
        self.statusLabel.textColor = [UIColor colorWithRed: 0.267 green: 0.58 blue: 0.345 alpha: 1];
    }
    
    if(status == AcquireIOConnectionStatusDisconnected){
        self.statusLabel.text = @"Start Again";
        self.statusLabel.textColor = [UIColor blackColor];
    }
}

- (IBAction)sdkInitTouched:(id)sender {
    [[AcquireIO support] startSession];
    [[AcquireIO support] showSupport:self];
}

- (IBAction)changeAccountTouched:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Change Account ID" message:@"Please enter your account uid:" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Dismiss" style:UIAlertActionStyleCancel handler:nil]];
    
    __block UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Change" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        //NSLog(@"text ==> %@", alert.textFields[0].text);
        NSString *accIDEntered = alert.textFields[0].text;
        accIDEntered = [accIDEntered stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if([accIDEntered length] == 5){
            self.accId_value.text = accIDEntered;
            [[NSUserDefaults standardUserDefaults] setObject:accIDEntered forKey:@"ACQUIREIO_ACCOUNT_ID"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [self showAlert:@"Please close app and re-open it for initiate account session."];

        }
        
        //return YES;
    }];
    
    saveAction.enabled = NO;
    [alert addAction:saveAction];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Account uid:";
        textField.text = self.accId_value.text;
        [textField addTarget:self action:@selector(alertControllerTextFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
    }];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)audioCallTouched:(id)sender {
    [[AcquireIO support] showCallSupport:@"audio"];
}

- (IBAction)videoCallTouched:(id)sender {
    [[AcquireIO support] showCallSupport:@"video"];
}

- (IBAction)logoutTouched:(id)sender {
    
    [[AcquireIO support] logoutVisitor];
    
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

-(void) showAlert:(NSString *)message{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:message preferredStyle:(UIAlertControllerStyleAlert)];
    
    UIAlertAction *okBtn = [UIAlertAction actionWithTitle:@"OK" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * action) {
        
    }];
    
    [alert addAction:okBtn];
    
    [self presentViewController:alert animated:YES completion:^{
        
    }];
}

@end

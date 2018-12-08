//
//  SettingViewController.m
//  AcquireSDK
//
//  Created by Raju Jangid on 12/4/18.
//  Copyright © 2018 AcquireIO Inc. All rights reserved.
//

#import "SettingViewController.h"
#import <AcquireIO/AcquireIO.h>

@interface SettingViewController ()<AcquireIODelegate>{
    NSArray *optionsArray;
}

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    optionsArray = @[
                     @{
                         @"title": @"Screen Share Border",
                         @"description": @"Share your app screen with agent then show a one pixel red border to show visitor that your app screen is sharing with app support agent",
                         @"key": @"ScreenShareBorder"},
                     @{
                         @"title": @"Show Avatar",
                         @"description": @"Show avatar of agent or visitor in main chat messages screen and available support agents list",
                         @"key": @"ShowAvatar"},
                     @{
                         @"title": @"Show Chat Button",
                         @"description": @"Show chat button in right bottom on user's screen and its just hide button but chat functionality will not affect by this option.",
                         @"key": @"ShowChatButton"},
                     
                     @{
                         @"title": @"Show Video Button",
                         @"description": @"Show video button in top tab list on visitor's main chat messages screen and its just hide button but video functionality will not affect by this option.",
                         @"key": @"ShowVideoButton"},
                     
                     @{
                         @"title": @"Show Audio Button",
                         @"description": @"Show audio button in top tab list on visitor's main chat messages screen and its just hide button but audio functionality will not affect by this option.",
                         @"key": @"ShowAudioButton"},
                     
                     @{
                         @"title": @"ShowLocal Notification In-App",
                         @"description": @"Show in-app notifiction when app state is active state.",
                         @"key": @"ShowLocalNotificationInApp"},
                     @{
                         @"title": @"Show Local Notification Background State",
                         @"description": @"Show local notifiction when app is in background state.",
                         @"key": @"ShowLocalNotificationBackgroundState"},
                     
                     @{
                         @"title": @"Show Default Stop Button",
                         @"description": @"Share your app screen with agent then show sdk stop button, if you not implement your app button. that will show when your app screen is sharing with app support agent",
                         @"key": @"ShowDefaultStopButton"},
                     @{
                         @"title": @"Session Connect And Start Auto",
                         @"description": @"Session will be auto connect to server and start and no need to invoke any additional method for start session. If you set `SessionConnectAndStartAuto`: @NO then you must call [[AcquireIO support] startSession] method to start connection with server.",
                         @"key": @"SessionConnectAndStartAuto"}
                     
                     ];
    
    
    [[AcquireIO support] addDelegate:self];
    
    
}

-(void) didChangeConnectionStatus:(AcquireIOConnectionStatus)status{
    if(status == AcquireIOConnectionStatusSessionStarted){
        NSIndexSet *section = [NSIndexSet indexSetWithIndex:0];
        [self.optionTableView reloadSections:section withRowAnimation:UITableViewRowAnimationNone];
    }
    
    if(status == AcquireIOConnectionStatusDisconnected){
        NSIndexSet *section = [NSIndexSet indexSetWithIndex:0];
        [self.optionTableView reloadSections:section withRowAnimation:UITableViewRowAnimationNone];
    }
    
    //NSLog(@"didChangeConnectionStatus %ld", (long)status);
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 1;
    }
    return optionsArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"setting_uid"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"setting_uid"];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    if(indexPath.section == 0){
        cell.textLabel.text = @"";
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.accessoryView = nil;
        cell.textLabel.text = @"";
        cell.detailTextLabel.text = @"";
    }else{
        NSDictionary *option = [optionsArray objectAtIndex:indexPath.row];
        cell.textLabel.text = option[@"title"];
        cell.detailTextLabel.text = option[@"description"];
        cell.detailTextLabel.textColor = [UIColor grayColor];
        cell.detailTextLabel.numberOfLines = 0;
        
        UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
        cell.accessoryView = switchView;
        BOOL isOn = [[NSUserDefaults standardUserDefaults] boolForKey:option[@"key"]];
        //NSLog(@"%@ ==> %d", option[@"key"], isOn);
        [switchView setOn:isOn animated:YES];
        [switchView addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    }
    
    
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return 0;
    }
    
    NSDictionary *option = [optionsArray objectAtIndex:indexPath.row];
    
    CGFloat ht = [self getLabelHeight:option[@"description"]];
    return  ht+62;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return 130;
    }
    return 42;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return [self cobrowseCode];
    }
    return [self advanceSetting];
}

- (CGFloat)getLabelHeight:(NSString*)labelStr
{
    CGSize constraint = CGSizeMake(self.optionTableView.frame.size.width, CGFLOAT_MAX);
    CGSize size;
    
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [labelStr boundingRectWithSize:constraint
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.0]}
                                                  context:context].size;
    
    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    
    return size.height;
}

- (void)switchChanged:(id)sender {
    UISwitch *switchControl = sender;
    //NSLog( @"The switch is %@", switchControl.on ? @"ON" : @"OFF" );
    
    CGPoint buttonPosition = [switchControl convertPoint:CGPointZero toView:self.optionTableView];
    NSIndexPath *indexPath = [self.optionTableView indexPathForRowAtPoint:buttonPosition];
    
    if(indexPath){
        NSDictionary *option = [optionsArray objectAtIndex:indexPath.row];
        
        //NSLog(@"%@  ==> %@", option[@"key"], switchControl.on ? @"ON" : @"OFF");
        
        [[NSUserDefaults standardUserDefaults] setBool:switchControl.on forKey:option[@"key"]];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}


-(UIView *)cobrowseCode{
    
    UIView *cobrowseWrapperView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 90)];
    
    UIView *cobrowseView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, self.view.frame.size.width, 90)];
    
    cobrowseView.backgroundColor = [UIColor whiteColor];
    
    /*cobrowseView.layer.cornerRadius = 5.0f;
    
    cobrowseView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:cobrowseView.bounds cornerRadius:cobrowseView.layer.cornerRadius].CGPath;
    cobrowseView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    cobrowseView.layer.shadowOpacity = 0.6;
    cobrowseView.layer.shadowOffset = CGSizeZero;
    cobrowseView.layer.shadowRadius = 5.0f;
    cobrowseView.layer.masksToBounds = NO;*/
    
    UILabel *code_title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, cobrowseView.frame.size.width - 20, 24)];
    
    code_title.textColor = [UIColor colorWithRed: 0.349 green: 0.376 blue: 0.976 alpha: 1];
    code_title.text = @"Cobrowse Code";
    
    //code_title.backgroundColor = [UIColor yellowColor];
    
    [cobrowseView addSubview:code_title];
    
    UILabel *cobrowseCode = [[UILabel alloc] initWithFrame:CGRectMake(10, 36, cobrowseView.frame.size.width - 20, 42)];
    
    //code.backgroundColor = [UIColor yellowColor];
    
    cobrowseCode.font = [UIFont boldSystemFontOfSize:32];
    cobrowseCode.text = @"Wait...";
    
    AcquireIOConnectionStatus status = [[AcquireIO support] getConnectionStatus];
    if(status == AcquireIOConnectionStatusSessionStarted){
        NSInteger cb_code = [[AcquireIO support] getCobrowseCode];
        cobrowseCode.text = [NSString stringWithFormat:@"%ld", (long)cb_code];
    }
    
    [cobrowseView addSubview:cobrowseCode];
    
    [cobrowseWrapperView addSubview:cobrowseView];
    
    return cobrowseWrapperView;
}


-(UIView *)advanceSetting{
    UIView *advanceSettingWrapperView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 38)];
    
    advanceSettingWrapperView.backgroundColor = [UIColor whiteColor];
    
    CALayer *sLayer = [CALayer layer];
    sLayer.frame = CGRectMake(0, 41, advanceSettingWrapperView.frame.size.width, 1);
    sLayer.backgroundColor = [UIColor colorWithRed: 0.929 green: 0.922 blue: 0.91 alpha: 1].CGColor;
    
    [advanceSettingWrapperView.layer addSublayer:sLayer];
    
    UILabel *sect_title = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, advanceSettingWrapperView.frame.size.width - 20, 28)];
    
    sect_title.font = [UIFont systemFontOfSize:18.0f];
    sect_title.textColor = [UIColor colorWithRed: 0.349 green: 0.376 blue: 0.976 alpha: 1];
    sect_title.text = @"Advance Setting";
    
    //code_title.backgroundColor = [UIColor yellowColor];
    
    [advanceSettingWrapperView addSubview:sect_title];
    
    return advanceSettingWrapperView;
}
@end

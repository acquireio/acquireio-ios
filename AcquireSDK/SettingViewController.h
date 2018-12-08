//
//  SettingViewController.h
//  AcquireSDK
//
//  Created by Raju Jangid on 12/4/18.
//  Copyright © 2018 AcquireIO Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SettingViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *optionTableView;

@end

NS_ASSUME_NONNULL_END

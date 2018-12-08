//
//  AppDelegate.m
//  AcquireSDK
//
//  Created by Raju Jangid on 11/30/18.
//  Copyright © 2018 AcquireIO Inc. All rights reserved.
//

#import "AppDelegate.h"
#import <AcquireIO/AcquireIO.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSString *accountID = [[NSUserDefaults standardUserDefaults] objectForKey:@"ACQUIREIO_ACCOUNT_ID"];
    
    if(accountID){
        [self setupAcquireIO];
    }
    return YES;
}

-(void) setupAcquireIO{
    
    NSString *accountID = [[NSUserDefaults standardUserDefaults] objectForKey:@"ACQUIREIO_ACCOUNT_ID"];
    
    if(accountID){
        
        NSDictionary *themeDict = [@{@"ACQUIREIO_GLOBAL": @{
                                             @"THEME_COLOR"           : @""
                                             },
                                     @"ACQUIREIO_SYSTEM_BUTTON": @{
                                             @"BACKGROUND_COLOR": @"#ff0000",
                                             @"BUTTON_INSET_BOTTOM"   : @80,
                                             @"BUTTON_INSET_RIGHT"    : @0
                                             }
                                     } mutableCopy];
        id screenShareBorder = [[NSUserDefaults standardUserDefaults] objectForKey:@"ScreenShareBorder"];
        id showAvatar = [[NSUserDefaults standardUserDefaults] objectForKey:@"ShowAvatar"];
        id showChatButton = [[NSUserDefaults standardUserDefaults] objectForKey:@"ShowChatButton"];
        id showVideoButton = [[NSUserDefaults standardUserDefaults] objectForKey:@"ShowVideoButton"];
        id showAudioButton = [[NSUserDefaults standardUserDefaults] objectForKey:@"ShowAudioButton"];
        id showLocalNotificationInApp = [[NSUserDefaults standardUserDefaults] objectForKey:@"ShowLocalNotificationInApp"];
        id showLocalNotificationBackgroundState = [[NSUserDefaults standardUserDefaults] objectForKey:@"ShowLocalNotificationBackgroundState"];
        id showDefaultStopButton = [[NSUserDefaults standardUserDefaults] objectForKey:@"ShowDefaultStopButton"];
        id sessionConnectAndStartAuto = [[NSUserDefaults standardUserDefaults] objectForKey:@"SessionConnectAndStartAuto"];
        
        
        NSMutableDictionary *_option = [@{} mutableCopy];
        
        if(screenShareBorder != nil){
            _option[@"ScreenShareBorder"] = @([[NSUserDefaults standardUserDefaults] boolForKey:@"ScreenShareBorder"]);
        }
        
        if(showAvatar != nil){
            _option[@"ShowAvatar"] = @([[NSUserDefaults standardUserDefaults] boolForKey:@"ShowAvatar"]);
        }
        
        if(showChatButton != nil){
            _option[@"ShowChatButton"] = @([[NSUserDefaults standardUserDefaults] boolForKey:@"ShowChatButton"]);
        }
        
        if(showVideoButton != nil){
            _option[@"ShowVideoButton"] = @([[NSUserDefaults standardUserDefaults] boolForKey:@"ShowVideoButton"]);
        }
        
        if(showAudioButton != nil){
            _option[@"ShowAudioButton"] = @([[NSUserDefaults standardUserDefaults] boolForKey:@"ShowAudioButton"]);
        }
        
        if(showLocalNotificationInApp != nil){
            _option[@"ShowLocalNotificationInApp"] = @([[NSUserDefaults standardUserDefaults] boolForKey:@"ShowLocalNotificationInApp"]);
        }
        
        if(showLocalNotificationBackgroundState != nil){
            _option[@"ShowLocalNotificationBackgroundState"] = @([[NSUserDefaults standardUserDefaults] boolForKey:@"ShowLocalNotificationBackgroundState"]);
        }
        
        if(showDefaultStopButton != nil){
            _option[@"ShowDefaultStopButton"] = @([[NSUserDefaults standardUserDefaults] boolForKey:@"ShowDefaultStopButton"]);
        }
        
        if(sessionConnectAndStartAuto != nil){
            _option[@"SessionConnectAndStartAuto"] = @([[NSUserDefaults standardUserDefaults] boolForKey:@"SessionConnectAndStartAuto"]);
        }
        
        _option[@"ThemeOptions"] = themeDict;
        
        _option[@"ButtonImageName"] = @"chat.png";
        //_option[@"WebSocketServer"] = @"https://custom-server.acquire.io";
        
        NSLog(@"%@", _option);
        
        AcquireIOConfig *config = [AcquireIOConfig config];
        [config setDict:[_option copy]];
        
        
        
        //[[AcquireIO support] setVisitorHash:@"3a862e28ca43705ed42b36ab9d952c5f04c2c17d089beaf993537782dee727aa"];
        //[[AcquireIO support] setVisitor:@"Kavin Roberts" phone:nil andEmail:@"kavin.roberts@acquire.io"];
        
        [[AcquireIO support] setAccount:accountID withOptions:config];
        /*NSArray *custom_fields = @[
                                   @{@"n":@"zipcode", @"v": @"54321"},
                                   @{@"n":@"acbranch", @"v": @"XXX"},
                                   @{@"n":@"company", @"v": @"XYZ Company"}
                                   ];
        
        [[AcquireIO support] setVisitorExtraField:custom_fields];
         
         */
        
        [[AcquireIO support] maskKeyboard:YES];
      
        //[[AcquireIO support] startSession];
        
    }
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

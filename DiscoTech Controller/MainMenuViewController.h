//
//  MainMenuViewController.h
//  DiscoTech Controller
//
//  Created by Sagar Pandya on 1/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RootViewController.h"
#import "SettingsViewController.h"

@interface MainMenuViewController : UIViewController
{
    RootViewController *_rootViewController;
    SettingsViewController *_settingsViewController;
}

@property (retain) RootViewController *rootViewController;
@property (retain) SettingsViewController *settingsViewController;

- (IBAction)viewTapped:(id)sender;
- (IBAction)settingsTapped:(id)sender;

@end

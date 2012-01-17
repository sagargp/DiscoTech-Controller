//
//  SettingsViewController.h
//  DiscoTech Controller
//
//  Created by Sagar Pandya on 1/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController

- (IBAction)saveTapped:(id)sender;
- (IBAction)cancelTapped:(id)sender;

@property (retain, nonatomic) IBOutlet UITextField *hostnameField;

@end

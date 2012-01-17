//
//  SettingsViewController.m
//  DiscoTech Controller
//
//  Created by Sagar Pandya on 1/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SettingsViewController.h"
#import "SendUDP.h"

@implementation SettingsViewController
@synthesize hostnameField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ( [defaults stringForKey:@"hostname"] != nil)
    {
        [hostnameField setText:[defaults stringForKey:@"hostname"]];
    }
}

- (void)viewDidUnload
{
    [self setHostnameField:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)saveTapped:(id)sender
{
    SUDP_Close();
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[self hostnameField].text forKey:@"hostname"];
    [defaults synchronize];
    SUDP_Init([[self hostnameField].text cStringUsingEncoding:NSASCIIStringEncoding]);
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cancelTapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField
{
    [textField resignFirstResponder];
    return NO;
}

- (void)dealloc {
    [hostnameField release];
    [super dealloc];
}
@end

//
//  HomePageViewController.m
//  walmart-checkin
//
//  Created by Vasu Palanisamy on 10/23/12.
//  Copyright (c) 2012 com.walmart. All rights reserved.
//

#import "HomePageViewController.h"
#import "CheckinViewController.h"
#import "CheckinAppDelegate.h"

@interface HomePageViewController ()

@end

@implementation HomePageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (IBAction)logoutPressed:(UIBarButtonItem*)sender {
    NSLog(@"logout pressed....");
    CheckinAppDelegate *delegate =  [[UIApplication sharedApplication] delegate];
    //delegate.loggedIn = @"TRUE";
    NSLog(@"user logged in? %@", delegate.loggedIn);
    CheckinViewController *cvc = [self.storyboard instantiateInitialViewController];
    [self.navigationController presentViewController:cvc animated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

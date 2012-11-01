//
//  CheckinViewController.m
//  walmart-checkin
//
//  Created by Vasu Palanisamy on 10/21/12.
//  Copyright (c) 2012 com.walmart. All rights reserved.
//

#import "CheckinViewController.h"
#import "CheckinAppDelegate.h"
#import "RestClient.h"
@interface CheckinViewController ()
@property NSString* pictureUrl;
@end

@implementation CheckinViewController

@synthesize userName = _userName;
@synthesize password = _password;
@synthesize error = _error;
@synthesize tabBar = _tabBar;
@synthesize photo = _photo;
@synthesize custName = _custName;
@synthesize custEmail = _custEmail;
@synthesize pictureUrl = _pictureUrl;

//@synthesize webView = _webView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Default.jpg"]];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if(self.pictureUrl != nil) {
        self.photo.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:
                                                   [NSURL URLWithString: [[RestClient getHostName] stringByAppendingString:self.pictureUrl]]]];
    } else {
        self.photo.image = nil;
    }
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField {
    NSLog(@"caling textFieldShouldReturn");
    if(theTextField==self.userName){
        [self.password becomeFirstResponder];
    }
    return YES;
}

- (IBAction)loginPressed:(UIButton *)sender {
    RestClient *client = [[RestClient alloc] init];
    NSDictionary *json = [client authenticateUser:self.userName.text withPassword:self.password.text];
    if(json == nil)
    {
        CheckinAppDelegate *delegate =  [[UIApplication sharedApplication] delegate];
        delegate.loggedIn = @"FALSE";
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Authentication Unsuccessful"
                                                          message:@"The credentials entered are not correct. Please try again."
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
    } else {
        CheckinAppDelegate *delegate =  [[UIApplication sharedApplication] delegate];
        delegate.loggedIn = @"TRUE";
        delegate.profileId = [json objectForKey:@"id"];
        self.tabBar.title = @"Home";
        self.pictureUrl = [json objectForKey:@"pictureURL"];
        if([json objectForKey:@"pictureURL"] != [NSNull null]) {
            self.pictureUrl = [json objectForKey:@"pictureURL"];
            self.photo.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:
                                                       [NSURL URLWithString: [[RestClient getHostName] stringByAppendingString:[json objectForKey:@"pictureURL"]]]]];
        } else {
            self.photo.image = nil;
        }
        self.myAccount.hidden = NO;
        NSString *custNameLbl = [json objectForKey:@"firstName"];
        custNameLbl = [custNameLbl stringByAppendingString:@" "];
        custNameLbl = [custNameLbl stringByAppendingString:[json objectForKey:@"lastName"]];
        self.custName.text = custNameLbl;
        //NSString *custEmailLbl = @"Email: ";
        //custEmailLbl = [custEmailLbl stringByAppendingString:[json objectForKey:@"email"]];
        NSString *custEmailLbl = [json objectForKey:@"email"];

        self.custEmail.text = custEmailLbl;
        /*NSURLRequest *requestObj = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://mobile.walmart.com/m/votd?product_id=vod:21092673"]];
        [self.webView loadRequest:requestObj];*/
    }
    
}
- (IBAction)logoutPressed:(UIButton *)sender {
    self.error.text = @"";
    CheckinAppDelegate *delegate =  [[UIApplication sharedApplication] delegate];
    delegate.loggedIn = @"FALSE";
    delegate.profileId = @"";
    self.tabBar.title = @"Login";
    self.myAccount.hidden = YES;
    self.userName.text = @"";
    self.password.text = @"";
    [[self.tabBarController.viewControllers objectAtIndex:1] popToRootViewControllerAnimated:YES];
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    if(touch.phase==UITouchPhaseBegan){
        //find first response view
        for (UIView *view in [self.view subviews]) {
            if ([view isFirstResponder]) {
                [view resignFirstResponder];
                break;
            }
        }
    }
}

@end

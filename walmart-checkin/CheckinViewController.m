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

@end

@implementation CheckinViewController

@synthesize userName = _userName;
@synthesize password = _password;
@synthesize error = _error;
@synthesize tabBar = _tabBar;
@synthesize photo = _photo;
@synthesize custName = _custName;
@synthesize custEmail = _custEmail;

- (void)viewDidLoad
{
    [super viewDidLoad];
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
        self.tabBar.title = @"My Account";
        self.photo.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:
                                                   [NSURL URLWithString: [json objectForKey:@"pictureURL"]]]];
        self.myAccount.hidden = NO;
        NSString *custNameLbl = [json objectForKey:@"firstName"];
        custNameLbl = [custNameLbl stringByAppendingString:@" "];
        custNameLbl = [custNameLbl stringByAppendingString:[json objectForKey:@"lastName"]];
        self.custName.text = custNameLbl;
        NSString *custEmailLbl = @"Email: ";
        custEmailLbl = [custEmailLbl stringByAppendingString:[json objectForKey:@"email"]];
        self.custEmail.text = custEmailLbl;
    }
    
}
- (IBAction)logoutPressed:(UIButton *)sender {
    self.error.text = @"";
    CheckinAppDelegate *delegate =  [[UIApplication sharedApplication] delegate];
    delegate.loggedIn = @"FALSE";
    self.tabBar.title = @"Login";
    self.myAccount.hidden = YES;
    self.userName.text = @"";
    self.password.text = @"";
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

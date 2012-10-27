//
//  CheckinViewController.h
//  walmart-checkin
//
//  Created by Vasu Palanisamy on 10/21/12.
//  Copyright (c) 2012 com.walmart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckinViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UILabel *error;
@property (weak, nonatomic) IBOutlet UITabBarItem *tabBar;
@property (weak, nonatomic) IBOutlet UIImageView *photo;
@property (weak, nonatomic) IBOutlet UIView *myAccount;
@property (weak, nonatomic) IBOutlet UILabel *custName;

@property (weak, nonatomic) IBOutlet UILabel *custEmail;

@end

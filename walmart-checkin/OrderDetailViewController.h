//
//  OrderDetailViewController.h
//  walmart-checkin
//
//  Created by Vasu Palanisamy on 10/26/12.
//  Copyright (c) 2012 com.walmart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderDetailViewController : UIViewController
@property (weak, nonatomic) NSDictionary* order;
@property (weak, nonatomic) IBOutlet UILabel *orderNumber;
@property (weak, nonatomic) IBOutlet UILabel *purchaseDate;
@property (weak, nonatomic) IBOutlet UILabel *status;
@property (weak, nonatomic) IBOutlet UILabel *itemCount;

@property (weak, nonatomic) IBOutlet UILabel *orderTotal;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (weak, nonatomic) IBOutlet UILabel *itemDesc;
@end

//
//  OrderDetailViewController.m
//  walmart-checkin
//
//  Created by Vasu Palanisamy on 10/26/12.
//  Copyright (c) 2012 com.walmart. All rights reserved.
//

#import "OrderDetailViewController.h"

@interface OrderDetailViewController ()

@end

@implementation OrderDetailViewController
@synthesize orderNumber = _orderNumber;
@synthesize purchaseDate = _purchaseDate;
@synthesize status = _status;
@synthesize itemCount = _itemCount;
@synthesize orderTotal = _orderTotal;
@synthesize image = _image;
@synthesize itemDesc = _itemDesc;
@synthesize order = _order;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.orderNumber.text = [[NSString alloc] initWithFormat:@"%@",[self.order valueForKey:@"orderId"]];
    long long submittedDate = [[self.order valueForKey:@"submittedDate"] longLongValue]/1000;
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:submittedDate];
    NSLog(@"%@", date);
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy h:mm a"];
    NSString *dateString = [dateFormat stringFromDate:date];
    self.purchaseDate.text = dateString;
    self.status.text = [self.order valueForKey:@"status"];
    NSArray *lineItems = [self.order valueForKey:@"lineItems"];
    self.itemDesc.text = [[[lineItems objectAtIndex:0] valueForKey:@"sku"] valueForKey:@"description"];
    NSString *imagePath = [[[lineItems objectAtIndex:0] valueForKey:@"sku"] valueForKey:@"imageURL"];
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imagePath]]];
    self.image.image = img;
    self.itemCount.text = [[NSString alloc] initWithFormat:@"%u",lineItems.count];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

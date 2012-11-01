//
//  StoreAddressViewController.m
//  walmart-checkin
//
//  Created by Vasu Palanisamy on 10/28/12.
//  Copyright (c) 2012 com.walmart. All rights reserved.
//

#import "StoreAddressViewController.h"
#import "RestClient.h"

@interface StoreAddressViewController ()

@end

@implementation StoreAddressViewController
@synthesize addressLabel = _addressLabel;
@synthesize storeNameString = _storeNameString;
@synthesize addressString = _addresString;
@synthesize distanceString = _distanceString;
@synthesize durationString = _durationString;
@synthesize distanceLabel = _distanceLabel;
@synthesize durationLabel = _durationLabel;

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
    [self.navigationItem setHidesBackButton:YES animated:YES];
    self.storeName.text = self.storeNameString;
    self.addressLabel.text = self.addressString;
    self.distanceLabel.text = self.distanceString;
    self.durationLabel.text = self.durationString;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

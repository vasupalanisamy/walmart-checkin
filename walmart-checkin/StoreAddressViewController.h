//
//  StoreAddressViewController.h
//  walmart-checkin
//
//  Created by Vasu Palanisamy on 10/28/12.
//  Copyright (c) 2012 com.walmart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>    

@interface StoreAddressViewController : UIViewController <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *durationLabel;
@property (strong, nonatomic) NSString *storeNameString;
@property (strong, nonatomic) NSString *addressString;
@property (strong, nonatomic) NSString *distanceString;
@property (strong, nonatomic) NSString *durationString;
@end

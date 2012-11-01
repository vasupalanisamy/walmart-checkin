//
//  PictureViewController.h
//  walmart-checkin
//
//  Created by Vasu Palanisamy on 10/28/12.
//  Copyright (c) 2012 com.walmart. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface PictureViewController : UIViewController <UIImagePickerControllerDelegate, UIActionSheetDelegate, CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UILabel *checkinLabel;
@property (strong, nonatomic) NSDictionary *order;
@property (strong, nonatomic) CLLocationManager* locationManager;


@end

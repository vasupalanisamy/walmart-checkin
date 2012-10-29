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
@synthesize storeName = _storeName;
@synthesize address = _address;
@synthesize distanceMessage = _distanceMessage;
@synthesize order = _order;
@synthesize locationManager = _locationManager;

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
    self.storeName.text = [[self.order valueForKey:@"store"] valueForKey:@"name"];
    self.address.text = [[self.order valueForKey:@"store"] valueForKey:@"address"];
    if(self.locationManager == nil) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        self.locationManager.delegate = self;
        [self.locationManager startMonitoringSignificantLocationChanges];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    [self.locationManager stopMonitoringSignificantLocationChanges];
    NSLog(@"didUpdateToLocation latitude %@",[NSNumber numberWithDouble:newLocation.coordinate.latitude]);
    NSLog(@"didUpdateToLocation longitude %@",[NSNumber numberWithDouble:newLocation.coordinate.longitude]);
    NSString* origin = [[NSString alloc]initWithFormat:@"%@,%@",[NSNumber numberWithDouble:newLocation.coordinate.latitude],[NSNumber numberWithDouble:newLocation.coordinate.longitude]];
    NSString* destination = [[NSString alloc]initWithFormat:@"%@,%@",[[self.order valueForKey:@"store"] valueForKey:@"latitude"],[[self.order valueForKey:@"store"] valueForKey:@"longitute"]];
    //self.distanceMessage.text = [[NSString alloc]initWithFormat:@"Source - %@, Destination - %@",origin, destination];
    NSDictionary* directions = [RestClient findDistanceFromSource:origin toDestination:destination];
    if(directions != nil) {
        NSDictionary* distance = [[[[[directions valueForKey:@"rows"] objectAtIndex:0] valueForKey:@"elements"] objectAtIndex:0]valueForKey:@"distance"];
        NSDictionary* duration = [[[[[directions valueForKey:@"rows"] objectAtIndex:0] valueForKey:@"elements"] objectAtIndex:0]valueForKey:@"duration"];
        
        NSString* distanceAsString = [[[NSString alloc] initWithFormat:@"%@", [distance valueForKey:@"text"]] stringByReplacingOccurrencesOfString:@"mi" withString:@"miles"];
        self.distanceMessage.text = [[NSString alloc]initWithFormat:@"The store is located %@ from your current location and it will take approximately %@ to reach to the store",distanceAsString, [duration valueForKey:@"text"]];
    }
    
}

@end

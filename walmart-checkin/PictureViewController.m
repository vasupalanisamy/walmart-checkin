//
//  PictureViewController.m
//  walmart-checkin
//
//  Created by Vasu Palanisamy on 10/28/12.
//  Copyright (c) 2012 com.walmart. All rights reserved.
//

#import "PictureViewController.h"
#import "StoreAddressViewController.h"
#import "RestClient.h"

@interface PictureViewController ()
@property(nonatomic, assign) BOOL isUserUploadedPhto;
@property(strong, nonatomic) NSString* distance;
@property(strong, nonatomic) NSString* duration;
@property (strong, nonatomic) NSNumber* durationSecs;
@property (strong, nonatomic) CLLocation* currentLocation;

@end

@implementation PictureViewController
@synthesize picture = _picture;
@synthesize checkinLabel = _checkinLabel;
@synthesize isUserUploadedPhto = _isUserUploadedPhto;
@synthesize order = _order;
@synthesize locationManager = _locationManager;
@synthesize distance = _distance;
@synthesize duration = _duration;
@synthesize durationSecs = _durationSecs;
@synthesize currentLocation = _currentLocation;

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
    self.isUserUploadedPhto = NO;
    NSString *imagePath = [[self.order valueForKey:@"createdBy"] valueForKey:@"pictureURL"];
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[[RestClient getHostName] stringByAppendingString:imagePath]]]];
    self.picture.image = img;
    self.checkinLabel.text = [@"You are checking in to " stringByAppendingString:[[self.order valueForKey:@"store"] valueForKey:@"name"]];
    if(self.locationManager == nil) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        self.locationManager.delegate = self;
    }
    [self.locationManager startUpdatingLocation];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) prepareForSegue:(UIStoryboardPopoverSegue *)segue sender:(StoreAddressViewController*)sender
{
    StoreAddressViewController *storeController = (StoreAddressViewController *) segue.destinationViewController;
    /*storeController.addressString = [[NSString alloc]initWithFormat:@"You have successfully checked in to %@ located at %@. We are working on your order..The store is %@ away from your current location and it will take approximately %@ to reach the store. See you there..",[[self.order valueForKey:@"store"] valueForKey:@"name"], [[self.order valueForKey:@"store"] valueForKey:@"address"], self.distance, self.duration];*/
    storeController.storeNameString = [[self.order valueForKey:@"store"] valueForKey:@"name"];
    storeController.addressString = [[self.order valueForKey:@"store"] valueForKey:@"address"];
    storeController.distanceString = self.distance;
    storeController.durationString = self.duration;
    
    NSDictionary *orderDict = [[NSDictionary alloc] initWithObjectsAndKeys:[self.order valueForKey:@"orderId"],@"orderId",@"Checked-In",@"status", [NSString stringWithFormat:@"%f",self.currentLocation.coordinate.latitude], @"checkInLatitude", [NSString stringWithFormat:@"%f",self.currentLocation.coordinate.longitude], @"checkInLongiude", self.duration, @"durationText", self.durationSecs, @"duration", nil];
    [RestClient updateOrder:orderDict];
    NSString* fileName = [[NSString alloc]initWithFormat:@"%@.jpg",[[self.order valueForKey:@"createdBy"]valueForKey:@"id"]];
    if(self.isUserUploadedPhto) {
        [RestClient uploadPhoto:UIImageJPEGRepresentation(self.picture.image,0.0) usingfileName:fileName];
    }
}
- (IBAction)updatePictureAction:(UIButton*)sender {

    [[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Close" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo", @"Choose from library", nil]showInView:[self.view window]];
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    [self.locationManager stopUpdatingLocation];
    self.currentLocation = newLocation;
    NSLog(@"didUpdateToLocation latitude %@",[NSNumber numberWithDouble:newLocation.coordinate.latitude]);
    NSLog(@"didUpdateToLocation longitude %@",[NSNumber numberWithDouble:newLocation.coordinate.longitude]);
    NSString* origin = [[NSString alloc]initWithFormat:@"%@,%@",[NSNumber numberWithDouble:newLocation.coordinate.latitude],[NSNumber numberWithDouble:newLocation.coordinate.longitude]];
    NSString* destination = [[NSString alloc]initWithFormat:@"%@,%@",[[self.order valueForKey:@"store"] valueForKey:@"latitude"],[[self.order valueForKey:@"store"] valueForKey:@"longitute"]];
    //self.distanceMessage.text = [[NSString alloc]initWithFormat:@"Source - %@, Destination - %@",origin, destination];
    NSDictionary* directions = [RestClient findDistanceFromSource:origin toDestination:destination];
    if(directions != nil) {
        NSDictionary* distance = [[[[[directions valueForKey:@"rows"] objectAtIndex:0] valueForKey:@"elements"] objectAtIndex:0]valueForKey:@"distance"];
        self.distance = [[[NSString alloc] initWithFormat:@"%@", [distance valueForKey:@"text"]] stringByReplacingOccurrencesOfString:@"mi" withString:@""];
        NSDictionary* duration = [[[[[directions valueForKey:@"rows"] objectAtIndex:0] valueForKey:@"elements"] objectAtIndex:0]valueForKey:@"duration"];
        self.duration = [duration valueForKey:@"text"];
        self.durationSecs = [duration valueForKey:@"value"];
    }
    
}

-(void)actionSheet: (UIActionSheet*) actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch(buttonIndex){
            
        case 0:
            NSLog(@"Take Photo"); 
            self.isUserUploadedPhto = YES;
            [self takePhoto];
            break;
        case 1:
            NSLog(@"Choose from library");
            self.isUserUploadedPhto = YES;
            [self chooseFromLibrary];
            break;

    }
}

-(void) chooseFromLibrary{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.editing=YES;
    imagePickerController.delegate = (id)self;
    
    [self presentViewController:imagePickerController animated:YES completion:nil];    
}

-(void) takePhoto{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    
    imagePickerController.sourceType=UIImagePickerControllerSourceTypeCamera;
    imagePickerController.editing=YES;
    imagePickerController.delegate = (id)self;
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
    
}

-(void) imagePickerController: (UIImagePickerController * )picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //UIImage *scaledImage = [image resizedImageWithContentMode:(UIViewContentModeScaleAspectFill) bounds: CGSizeMake(photo.frame.size.width, photo.frame.size.height) interpolationQuality:kCGInterpolationHigh];
    //UIImage *croppedImage = [scaledImage croppedImage:CGRectMake((scaledImage.size.width-photo.frame.size.width/2), (scaledImage.size.height-photo.frame.size.height/2), photo.frame.size.width, photo.frame.size.height)];
    
    //show the photo on screen
    NSLog(@"didFinishPickingMediaWithInfo");
    self.picture.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    //[picker dismissModalViewControllerAnimated:NO];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end

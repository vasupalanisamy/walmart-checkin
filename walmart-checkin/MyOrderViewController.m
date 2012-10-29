//
//  MyOrderViewController.m
//  walmart-checkin
//
//  Created by Vasu Palanisamy on 10/24/12.
//  Copyright (c) 2012 com.walmart. All rights reserved.
//

#import "MyOrderViewController.h"
#import "CheckinAppDelegate.h"
#import "RestClient.h"
#import "OrderTableViewCell.h"
#import "OrderDetailViewController.h"
@interface MyOrderViewController ()

@end

@implementation MyOrderViewController

@synthesize orders = _orders;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)viewWillAppear:(BOOL)animated {
    CheckinAppDelegate *delegate =  [[UIApplication sharedApplication] delegate];
    if(delegate.loggedIn != @"TRUE") {
        [self.tabBarController setSelectedIndex:0];
        UIAlertView *message = [[UIAlertView alloc] initWithTitle:@""
                                                          message:@"Please signin to continue."
                                                         delegate:nil
                                                cancelButtonTitle:@"OK"
                                                otherButtonTitles:nil];
        [message show];
    } else {
        RestClient *client = [[RestClient alloc] init];
        self.orders = [client fetchOrders:delegate.profileId];
        NSLog(@"order id %@", [[self.orders objectAtIndex:0] objectForKey:@"orderId"]);
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.orders.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }*/
    static NSString *CellIdentifier = @"Cell";
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[OrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    NSArray *lineItems = [[self.orders objectAtIndex:indexPath.row] valueForKey:@"lineItems"];
    NSString *text = [NSString stringWithFormat:@"Order #%@", [[self.orders objectAtIndex:indexPath.row] valueForKey:@"orderId"]];
    cell.orderNumber.text = text;
    
    long long submittedDate = [[[self.orders objectAtIndex:indexPath.row] valueForKey:@"submittedDate"] longLongValue]/1000;
    NSDate *date = [[NSDate alloc] initWithTimeIntervalSince1970:submittedDate];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy h:mm a"];
    NSString *dateString = [dateFormat stringFromDate:date];
    cell.purchaseDate.text = dateString;
    
    cell.status.text = [[self.orders objectAtIndex:indexPath.row] valueForKey:@"status"];
    
    cell.noOfItems.text = [[NSString alloc] initWithFormat:@"%u",lineItems.count];
    
    cell.cellIdex = [[NSNumber alloc]initWithInt: indexPath.row];
    // Configure the cell...
    
    return cell;
}

- (UITableViewCellAccessoryType)tableView:(UITableView *)tv accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellAccessoryDetailDisclosureButton;
}

-(void) prepareForSegue:(UIStoryboardPopoverSegue *)segue sender:(OrderTableViewCell*)sender
{
    OrderDetailViewController *detail = (OrderDetailViewController *) segue.destinationViewController;
    detail.order = [self.orders objectAtIndex:[sender.cellIdex intValue]];
    //NSLog(@"i am here %@", detail);
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"hi %i",indexPath.row);
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end

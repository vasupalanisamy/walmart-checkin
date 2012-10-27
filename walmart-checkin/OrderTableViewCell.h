//
//  OrderTableViewCell.h
//  walmart-checkin
//
//  Created by Vasu Palanisamy on 10/26/12.
//  Copyright (c) 2012 com.walmart. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderNumber;
@property (weak, nonatomic) IBOutlet UILabel *purchaseDate;
@property (weak, nonatomic) IBOutlet UILabel *noOfItems;
@property (weak, nonatomic) IBOutlet UILabel *status;

@property (strong, nonatomic) NSNumber *cellIdex;

@end

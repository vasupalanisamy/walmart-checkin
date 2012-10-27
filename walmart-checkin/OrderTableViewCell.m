//
//  OrderTableViewCell.m
//  walmart-checkin
//
//  Created by Vasu Palanisamy on 10/26/12.
//  Copyright (c) 2012 com.walmart. All rights reserved.
//

#import "OrderTableViewCell.h"

@implementation OrderTableViewCell
@synthesize orderNumber, purchaseDate, noOfItems, status, cellIdex;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

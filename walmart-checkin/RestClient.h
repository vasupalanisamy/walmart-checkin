//
//  RestClient.h
//  walmart-checkin
//
//  Created by Vasu Palanisamy on 10/25/12.
//  Copyright (c) 2012 com.walmart. All rights reserved.
//

#import <Foundation/Foundation.h>
#define BASE_URL @"http://localhost:8080/hackday/rest"
#define LOGIN_URL @"/profile?email=%@&password=%@"
#define ORDERS_BY_PROFILE @"/order?profileId=%@"
#define ORDERS_BY_ORDERID @"/order?orderId=%@"
@interface RestClient : NSObject
- (NSDictionary*) authenticateUser: (NSString*) userName withPassword: (NSString*) password;
- (NSArray*) fetchOrders: (NSString*) profileId;
@end

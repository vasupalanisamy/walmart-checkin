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
#define GOOGLE_API @"http://maps.googleapis.com/maps/api/distancematrix/json?origins=%@&destinations=%@&mode=driving&language=en-US&sensor=false&units=imperial"
@interface RestClient : NSObject
- (NSDictionary*) authenticateUser: (NSString*) userName withPassword: (NSString*) password;
- (NSArray*) fetchOrders: (NSString*) profileId;
- (NSArray*) fetchOrdersUsingOrderId: (NSString*) orderId;
+ (NSDictionary*) findDistanceFromSource: (NSString*) source toDestination: (NSString*) destination;
@end

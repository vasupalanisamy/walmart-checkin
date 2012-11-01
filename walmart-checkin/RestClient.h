//
//  RestClient.h
//  walmart-checkin
//
//  Created by Vasu Palanisamy on 10/25/12.
//  Copyright (c) 2012 com.walmart. All rights reserved.
//

#import <Foundation/Foundation.h>
//#define HOST_PORT @"http://localhost:8080"
//#define BASE_URL @"http://localhost:8080/hackday/rest"
//#define HOST_PORT @"http://5.5.147.41:8080"
//#define BASE_URL @"http://5.5.147.41:8080/hackday/rest"
//#define HOST_PORT @"http://192.168.1.104:8080"
//#define BASE_URL @"http://192.168.1.104:8080/hackday/rest"
//#define HOST_PORT @"http://dvpalanisamy64.homeoffice.wal-mart.com:8080"
//#define BASE_URL @"http://dvpalanisamy64.homeoffice.wal-mart.com/hackday/rest"
#define LOGIN_URL @"/hackday/rest/profile?email=%@&password=%@"
#define ORDERS_BY_PROFILE @"/hackday/rest/order?profileId=%@"
#define ORDERS_BY_ORDERID @"/hackday/rest/order?orderId=%@"
#define UPDATE_ORDER @"/hackday/rest/order"
#define UPLOAD_PHOTO @"/hackday/rest/file/upload"
#define GOOGLE_API @"http://maps.googleapis.com/maps/api/distancematrix/json?origins=%@&destinations=%@&mode=driving&language=en-US&sensor=false&units=imperial"
@interface RestClient : NSObject
- (NSDictionary*) authenticateUser: (NSString*) userName withPassword: (NSString*) password;
- (NSArray*) fetchOrders: (NSString*) profileId;
- (NSArray*) fetchOrdersUsingOrderId: (NSString*) orderId;
+ (NSDictionary*) findDistanceFromSource: (NSString*) source toDestination: (NSString*) destination;
+ (void) updateOrder: (NSDictionary*) order;
+ (void) uploadPhoto: (NSData*) photo usingfileName:(NSString*) fileName;
+ (NSString*) getHostName;
+ (NSString*) getURL:(NSString*)relativeUrl;
@end

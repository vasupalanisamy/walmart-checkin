//
//  RestClient.m
//  walmart-checkin
//
//  Created by Vasu Palanisamy on 10/25/12.
//  Copyright (c) 2012 com.walmart. All rights reserved.
//

#import "RestClient.h"

@implementation RestClient
- (NSDictionary*) authenticateUser: (NSString*) userName withPassword: (NSString*) password {
    NSLog(@"authenticateUser URL - %@", [BASE_URL stringByAppendingString:LOGIN_URL]);
    NSString *url = [[NSString alloc] initWithFormat:[BASE_URL stringByAppendingString:LOGIN_URL],userName, password];
    NSDictionary *json = (NSDictionary*)[RestClient callGetAPI:url];
    if([json objectForKey:@"id"] == [NSNull null]){
        return nil;
    } else {
        return json;
    }
}

- (NSArray*) fetchOrders: (NSString*) profileId {
    NSLog(@"fetchOrders URL - %@", [BASE_URL stringByAppendingString:ORDERS_BY_PROFILE]);
    NSString *url = [[NSString alloc] initWithFormat:[BASE_URL stringByAppendingString:ORDERS_BY_PROFILE],profileId];
    NSArray *json = (NSArray*)[RestClient callGetAPI:url];
    return json;
}

- (NSArray*) fetchOrdersUsingOrderId: (NSString*) orderId {
    NSLog(@"fetchOrders URL - %@", [BASE_URL stringByAppendingString:ORDERS_BY_ORDERID]);
    NSString *url = [[NSString alloc] initWithFormat:[BASE_URL stringByAppendingString:ORDERS_BY_PROFILE],orderId];
    NSArray *json = (NSArray*)[RestClient callGetAPI:url];
    return json;
}

+ (NSDictionary*) findDistanceFromSource: (NSString*) source toDestination: (NSString*) destination {
    NSString *url = [[NSString alloc] initWithFormat:GOOGLE_API,source, destination];
    NSDictionary *json = (NSDictionary*)[self callGetAPI:url];
    NSLog(@"status - %@", [json objectForKey:@"status"]);
    NSString *status = [[NSString alloc]initWithFormat:@"%@", [json objectForKey:@"status"]];
    if([status isEqualToString:@"OK"]){
        return json;
    } else {
        return nil;
    }
}

+ (NSObject*) callGetAPI: (NSString*) url {
    NSURL *nsurl = [[NSURL alloc] initWithString:url];
    NSError *error = nil;
    //getting the data
    NSData *response = [NSData dataWithContentsOfURL:nsurl];
    NSObject *json = [NSJSONSerialization JSONObjectWithData:response options:0 error:&error];
    //json parse
    NSString *responseString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    NSLog(@"responseString - %@", responseString);
    return json;
}

@end

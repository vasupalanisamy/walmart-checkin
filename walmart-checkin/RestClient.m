//
//  RestClient.m
//  walmart-checkin
//
//  Created by Vasu Palanisamy on 10/25/12.
//  Copyright (c) 2012 com.walmart. All rights reserved.
//

#import "RestClient.h"
#import "SimplePost.h"

@implementation RestClient
- (NSDictionary*) authenticateUser: (NSString*) userName withPassword: (NSString*) password {
    NSString *url = [[NSString alloc] initWithFormat:[RestClient getURL:LOGIN_URL],userName, password];
    NSLog(@"authenticateUser URL - %@", url);
    NSDictionary *json = (NSDictionary*)[RestClient callGetAPI:url];
    if([json objectForKey:@"id"] == [NSNull null]){
        return nil;
    } else {
        return json;
    }
}

- (NSArray*) fetchOrders: (NSString*) profileId {
    NSString *url = [[NSString alloc] initWithFormat:[RestClient getURL:ORDERS_BY_PROFILE],profileId];
    NSLog(@"fetchOrders URL - %@", url);
    NSArray *json = (NSArray*)[RestClient callGetAPI:url];
    return json;
}

- (NSArray*) fetchOrdersUsingOrderId: (NSString*) orderId {
    NSString *url = [[NSString alloc] initWithFormat:[RestClient getURL:ORDERS_BY_ORDERID],orderId];
    NSLog(@"fetchOrdersUsingOrderIds URL - %@", url);
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

+ (void) updateOrder: (NSDictionary*) order {
    NSString *url = [RestClient getURL:UPDATE_ORDER];
    NSLog(@"updateOrder URL - %@", url);
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:order options:0 error:nil];
    NSString* jsonStr = [[NSString alloc] initWithData:jsonData
                                              encoding:NSUTF8StringEncoding];
    NSLog(@"%@", jsonStr);
    [RestClient postData:jsonData toUrl:url];
}
+ (void) postData:(NSData*)data toUrl:(NSString*)urlString {
    NSURL* url = [[NSURL alloc] initWithString:urlString];
    NSString* requestDataLengthString = [[NSString alloc] initWithFormat:@"%d", [data length]];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request setValue:requestDataLengthString forHTTPHeaderField:@"Content-Length"];
    [request setTimeoutInterval:30.0];
    NSURLResponse *response;
    NSError* error = nil;
    NSData* result = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    //NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
    //NSLog(@"stausCode - %d", httpResponse.statusCode);
    //response.
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

+ (void) uploadPhoto: (NSData*) photo usingfileName:(NSString*) fileName {
    NSDictionary *dictionary = [[NSDictionary alloc] initWithObjectsAndKeys: photo, @"file", nil];
    NSURL *url = [NSURL URLWithString:[RestClient getURL:UPLOAD_PHOTO]];
    NSLog(@"uploadPhoto URL - %@", url);
    NSMutableURLRequest *request = [SimplePost multipartRequestWithURL:url andDataDictionary:dictionary andFileName:fileName];
    NSURLResponse *response;
    NSError* error = nil;
    NSData* result = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
}

+ (NSString*) getHostName {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [@"http://" stringByAppendingString:[defaults objectForKey:@"host_name"]];
}

+ (NSString*) getURL:(NSString*)relativeUrl {
    NSString *url = [[self getHostName] stringByAppendingString:relativeUrl];
    return url;
}

@end

//
//  SimplePost.h
//  iReporter
//
//  Created by Vasu Palanisamy on 10/24/12.
//  Copyright (c) 2012 Marin Todorov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SimplePost : NSObject
+ (NSMutableURLRequest *) multipartRequestWithURL:(NSURL *)url andDataDictionary:(NSDictionary *) dictionary  andFileName:(NSString *) fileName;
+ (NSMutableURLRequest *) urlencodedRequestWithURL:(NSURL *)url andDataDictionary:(NSDictionary *) dictionary;
@end

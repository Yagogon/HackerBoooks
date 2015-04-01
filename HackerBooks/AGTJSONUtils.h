//
//  AGTJSONUtils.h
//  HackerBooks
//
//  Created by Yago de la Fuente on 30/3/15.
//  Copyright (c) 2015 com.cininika. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FIRST_EXECUTION @"firstExecution"
#define JSON_FILE @"books.json"

@interface AGTJSONUtils : NSObject

+(NSArray *) JSONBooks;

+(void) saveJSONWithArray: (NSArray *) array;

@end

//
//  AGTLocalFile.h
//  HackerBooks
//
//  Created by Yago de la Fuente on 1/4/15.
//  Copyright (c) 2015 com.cininika. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FIRST_EXECUTION @"firstExecution"

@class AGTBook;

@interface AGTLocalFile : NSObject <NSURLSessionDownloadDelegate>

+(void) saveDataWithURL: (NSURL *) url;

+(NSData *) dataWithURL: (NSURL *) url;

+(NSString *) localPathWithURL: (NSURL *) url;

+(NSURL *) localURL: (NSURL *) url;

-(void) saveData:(NSURL *)url completionBlock: (void (^)(NSArray * array)) completionBlock;

-(void) dataWithURL:(NSURL *)url completionBlock: (void (^)(NSData * data)) completionBlock;

@end

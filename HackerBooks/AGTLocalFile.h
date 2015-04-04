//
//  AGTLocalFile.h
//  HackerBooks
//
//  Created by Yago de la Fuente on 1/4/15.
//  Copyright (c) 2015 com.cininika. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AGTBook;

@interface AGTLocalFile : NSObject 

+(void) saveDataWithURL: (NSURL *) url;

+(NSData *) dataWithURL: (NSURL *) url;

+(NSString *) localPathWithURL: (NSURL *) url;

+(NSURL *) localURL: (NSURL *) url;

@end

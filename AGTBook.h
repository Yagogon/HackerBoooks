//
//  AGTBook.h
//  HackerBooks
//
//  Created by Yago de la Fuente on 21/3/15.
//  Copyright (c) 2015 com.cininika. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AGTBook : NSObject

@property (copy, nonatomic) NSString *title;
@property (strong, nonatomic) NSArray *authors;
@property (strong, nonatomic) NSArray *tags;
@property (strong, nonatomic) NSURL *photoURL;
@property (strong, nonatomic) NSURL *pdfURL;
@property (nonatomic) BOOL favorite;


-(id) initWithDict: (NSDictionary *) dict;

-(NSDictionary *) asJSONDictionary;

@end

//
//  AGTLibrary.h
//  HackerBooks
//
//  Created by Yago de la Fuente on 21/3/15.
//  Copyright (c) 2015 com.cininika. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AGTBook;

@interface AGTLibrary : NSObject

-(id) initWithArray: (NSArray *) anArray;

-(NSUInteger) booksCount;

// Número de tags, no puede existir duplicados
-(NSArray *) tags;

-(NSUInteger) tagsCount;

-(NSUInteger) bookCountForTag:(NSString *) tag;

-(NSArray *) booksForTag: (NSString *)tag;

-(AGTBook *) booksForTag:(NSString *) tag atIndex:(NSUInteger) index;

-(NSString *) tagWithSection: (NSUInteger) section;

-(void) updateFavoriteTag: (AGTBook *) book;

-(NSArray *) asJSONArray;

@end

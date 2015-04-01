//
//  AGTLibrary.m
//  HackerBooks
//
//  Created by Yago de la Fuente on 21/3/15.
//  Copyright (c) 2015 com.cininika. All rights reserved.
//

#import "AGTLibrary.h"
#import "AGTBook.h"
#import "Constants.h"

@interface AGTLibrary ()

@property (strong, nonatomic) NSMutableArray* allTags;
@property (strong, nonatomic) NSMutableDictionary* booksByTag;
@property int numberOfBooks;

@end
@implementation AGTLibrary

#pragma  mark - Init

-(id) initWithArray:(NSArray *)anArray {
    
    
    
    if (self = [super init]) {
        
        _allTags = [[NSMutableArray alloc] init];
        _booksByTag = [[NSMutableDictionary alloc] init];
        
        for (NSDictionary *dict in anArray) {
            
            AGTBook *book = [[AGTBook alloc] initWithDict:dict];
            
            for (NSString *tag in book.tags) {
                
                // Añadimos el libro al tag correspondiente
                NSString *trimTag = [tag stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                [self addBook: (book) withTag:trimTag];
                
                // Guardamos los tags no repetidos
                if (![self.allTags containsObject: trimTag]) {
                    [self.allTags addObject:trimTag];
                }
            }
            
            
        }
        
        [self.allTags sortUsingSelector:@selector(caseInsensitiveCompare:)];
        [self.allTags removeObject:FAVORITE_TAG_KEY];
        [self.allTags insertObject:FAVORITE_TAG_KEY atIndex:0];
    }
    
    return self;
}

#pragma mark - Utils

-(void) addBook:( AGTBook *)book withTag: (NSString *) tag{
    
    NSMutableArray *booksForTag = [self.booksByTag objectForKey:tag];
    
    if (!booksForTag) {
        booksForTag = [[NSMutableArray alloc] init];
        [self.booksByTag setObject:booksForTag forKey:tag];
    }
    
    if (![booksForTag containsObject:book]) {
        [booksForTag addObject:book];
        self.numberOfBooks++;
    }
}

-(void) updateFavoriteTag: (AGTBook *) book{
    
    NSMutableArray *booksForTag = [self.booksByTag objectForKey:FAVORITE_TAG_KEY];
    
    if (!booksForTag) {
        booksForTag = [[NSMutableArray alloc] init];
        [self.booksByTag setObject:booksForTag forKey:FAVORITE_TAG_KEY];
    }
    
    if (book.favorite) {
        [booksForTag addObject:book];
    } else {
        [booksForTag removeObject:book];
    }
    
}

#pragma mark - Datasource

-(NSUInteger)tagsCount {
    return [self.allTags count];
}

-(NSArray *) tags {
    return self.allTags;
}

-(NSUInteger) bookCountForTag:(NSString *) tag {
    return [[self booksForTag:tag] count];
}

-(NSArray *) booksForTag: (NSString *)tag {
    return [self.booksByTag objectForKey:tag];
}

-(AGTBook *) booksForTag:(NSString *) tag
                 atIndex:(NSUInteger) index {
    
    return [[self booksForTag:tag] objectAtIndex:index];
}

-(NSUInteger) booksCount{
    return self.numberOfBooks;
}

-(NSString *) tagWithSection: (NSUInteger) section {
    return [self.allTags objectAtIndex:section];
}

-(NSSet *) books{
    
    NSMutableSet *books = [[NSMutableSet alloc] init];
    
    for (NSArray *booksForTag in [self.booksByTag allValues]) {
        
        for (AGTBook *book in booksForTag) {
            [books addObject:book];
        }
    }
    
    return books;
}

#pragma mark - JSON

-(NSArray *) asJSONArray {
    
    NSMutableArray *libraryAsJSON = [[NSMutableArray alloc] init];
    
    for (AGTBook *book in [self books]) {
        [libraryAsJSON addObject:[book asJSONDictionary]];
    }
    
    return libraryAsJSON;
}




@end

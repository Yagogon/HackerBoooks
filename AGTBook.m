//
//  AGTBook.m
//  HackerBooks
//
//  Created by Yago de la Fuente on 21/3/15.
//  Copyright (c) 2015 com.cininika. All rights reserved.
//

#import "AGTBook.h"
#import "Constants.h"

@implementation AGTBook

-(id) initWithDict:(NSDictionary *)dict {
    
    if (self = [super init]) {
        
        _title = [dict objectForKey:TITLE_KEY];
        _authors = [[dict objectForKey:AUTHORS_KEY] componentsSeparatedByString:@","];
        _tags = [[dict objectForKey:TAGS_KEY] componentsSeparatedByString:@","];
        _photoURL = [NSURL URLWithString:[dict objectForKey:IMAGE_URL_KEY]];
        _pdfURL = [NSURL URLWithString:[dict objectForKey:PDF_URL_KEY]];
        _favorite = [[dict objectForKey:FAVORITE_KEY] boolValue];
    }
    
    return self;
}

-(void) setFavorite:(BOOL)favorite {
    
    _favorite = favorite;
    
    if (favorite) {
        _tags = [self.tags arrayByAddingObject:FAVORITE_TAG_KEY];
    } else {
        
        NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:self.tags];
        [mutableArray removeObject:FAVORITE_TAG_KEY];
        _tags = mutableArray;
    }
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    NSNotification *n = [NSNotification notificationWithName:FAVORITE_NOTIFICATION
                                                      object:self
                                                    userInfo:@{ BOOK_KEY : self}];
    
    [center postNotification:n];
}

-(NSDictionary *) asJSONDictionary {
    
    NSDictionary *JSONDictionary = @{TITLE_KEY : self.title,
                                     AUTHORS_KEY: [[self.authors valueForKey:@"description"] componentsJoinedByString:@","],
                                     TAGS_KEY : [[self.tags valueForKey:@"description"] componentsJoinedByString:@","],
                                     IMAGE_URL_KEY : [self.photoURL absoluteString],
                                     PDF_URL_KEY : [self.pdfURL absoluteString],
                                     FAVORITE_KEY: @(self.favorite)};
    
    return JSONDictionary;
}



@end

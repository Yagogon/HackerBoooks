#import "AGTBook.h"
#import "Constants.h"
#import "AGTTag.h"
#import "AGTPdf.h"
@import UIKit;

@interface AGTBook ()


// Private interface goes here.

@end

@implementation AGTBook

// Custom logic goes here.

+(instancetype) bookWithDict: (NSDictionary *) dict context: (NSManagedObjectContext *) context{
    
    AGTBook *book = [self insertInManagedObjectContext:context];
    
    book.authors = [dict objectForKey:AUTHORS_KEY];
    book.title = [dict objectForKey:TITLE_KEY];
    book.bookUrl = [dict objectForKey:IMAGE_URL_KEY];
    book.favoriteValue = NO;
    
    // Creación de los tags
    NSError *error;
    NSArray *tagsName = [[dict objectForKey:TAGS_KEY] componentsSeparatedByString:@","];
    NSMutableSet *bookTags = [[NSMutableSet alloc] init];
    
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[AGTTag entityName]];
    
    for (NSString *tagName in tagsName) {
       
        NSString *trimTag = [tagName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        req.predicate = [NSPredicate predicateWithFormat:@"name = %@", trimTag];
        NSArray *results = [context executeFetchRequest:req
                                                  error:&error
                            ];
        
        if (results.count == 0) {
            AGTTag *tag = [AGTTag tagWithName:trimTag context:context];
            [bookTags addObject:tag];
        } else {
            AGTTag *tagFetched = [results objectAtIndex:0];
            [bookTags addObject:tagFetched];
        }
        
    }
    
    // Añado los tags al libro, por la inversa se añade el libro a los tag
    [book addTags:bookTags];
    
    [book setPdf:[AGTPdf pdfWithString:[dict objectForKey:PDF_URL_KEY]
                               context:context]];
    
    return book;
    
}


@end

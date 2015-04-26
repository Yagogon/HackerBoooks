#import "AGTBook.h"
#import "Constants.h"
#import "AGTTag.h"
#import "AGTPdf.h"
#import "Constants.h"
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

#pragma mark - Life Cycle

-(void) awakeFromInsert {
    
    [super awakeFromInsert];
    
    // Solo se produce una vez en la vida del objeto
    [self setupKVO];
}

-(void) awakeFromFetch {
    
    [super awakeFromFetch];
    
    // Se produce N veces a lo largo de la vida del objeto
    [self setupKVO];
}

-(void) willTurnIntoFault {
    
    [super willTurnIntoFault];
    
    // Se produce cuando el objeto se vacia conviertiéndose en un fault.
    
    // Baja en todas las notificaciones
    [self tearDownKVO];
}


#pragma mark - KVO

-(void) setupKVO {
    
    [self addObserver:self
           forKeyPath:AGTBookAttributes.favorite
              options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld
              context:nil];
    
}

-(void) tearDownKVO {
    
    [self removeObserver:self
              forKeyPath:AGTBookAttributes.favorite];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    NSError *error;
    AGTBook *book = object;
    
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[AGTTag entityName]];
    
    NSString *trimTag = FAVORITE_TAG_KEY;
    req.predicate = [NSPredicate predicateWithFormat:@"name = %@", trimTag];
    NSArray *results = [book.managedObjectContext executeFetchRequest:req
                                                                error:&error
                        ];
    
    if (book.favoriteValue) {
        if (results.count == 0) {
            AGTTag *tag = [AGTTag tagWithName:trimTag context:self.managedObjectContext];
            [tag addBooksObject:book];
            
        } else {
            AGTTag *tagFetched = [results objectAtIndex:0];
            [tagFetched addBooksObject:book];
        }
        
        // Guardar para lanzar métodos delegado fetchcontroller
        if (![book.managedObjectContext save:&error])
        {
            NSLog(@"Error al guardar actualizando tag: %@", error);
        };
        
    } else {
        if (results.count > 0) {
            AGTTag *tag = [results objectAtIndex:0];
            [tag removeBooksObject:book];
            if (tag.booksSet.count == 0) {
                [tag.managedObjectContext deleteObject:tag];
            }
            
            if (![book.managedObjectContext save:&error])
            {
                NSLog(@"Error al guardar actualizando tag: %@", error);
            };
        }
        
        
    }
    
}




@end

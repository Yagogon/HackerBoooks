#import "_AGTAnnotation.h"

@interface AGTAnnotation : _AGTAnnotation {}
// Custom logic goes here.

+(instancetype) annotationWithName: (NSString *) name
                              text: (NSString *) text
                           context: (NSManagedObjectContext *) context;

@end

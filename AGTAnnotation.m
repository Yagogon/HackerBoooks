#import "AGTAnnotation.h"
#import "AGTPhoto.h"

@interface AGTAnnotation ()

// Private interface goes here.

@end

@implementation AGTAnnotation

// Custom logic goes here.

+(instancetype) annotationWithName:(NSString *)name
                              text:(NSString *)text
                           context:(NSManagedObjectContext *)context {
    
    AGTAnnotation *annotation = [self insertInManagedObjectContext:context];
    
    annotation.name = name;
    annotation.text = text;
    
    annotation.modificationData = [NSDate date];
    annotation.createData = [NSDate date];
    
    annotation.photo = [AGTPhoto photoWithData:nil
                                       context:context];
    
    return annotation;
}

@end

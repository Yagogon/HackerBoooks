#import "AGTAnnotation.h"
#import "AGTPhoto.h"
#import "Constants.h"

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

+(NSArray *)observableKeyNames{
    
    return @[@"name", @"text", @"photo.photoData"];
}


#pragma mark - KVO

-(void) setupKVO {
    
    for (NSString *property in [AGTAnnotation observableKeyNames]) {
        [self addObserver:self
               forKeyPath:property
                  options:NSKeyValueObservingOptionNew
                  context:nil];
    }
    
}

-(void) tearDownKVO {
    
    for (NSString *property in [AGTAnnotation observableKeyNames]) {
        [self removeObserver:self
                  forKeyPath:property];
    }

}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context{
    
    [[NSNotificationCenter defaultCenter]postNotificationName:ANNOTATION_CHANGE_NOTIFICATION object:nil];
    
}

@end

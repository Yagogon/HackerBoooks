#import "AGTPhoto.h"

@interface AGTPhoto ()

// Private interface goes here.

@end

@implementation AGTPhoto

// Custom logic goes here.

+(instancetype) photoWithData:(NSData *)data context:(NSManagedObjectContext *)context{
    
    AGTPhoto *photo = [self insertInManagedObjectContext:context];
    
    photo.photoData = data;
    
    return photo;
}

@end

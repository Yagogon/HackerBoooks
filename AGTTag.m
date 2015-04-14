#import "AGTTag.h"

@interface AGTTag ()

// Private interface goes here.

@end

@implementation AGTTag

// Custom logic goes here.
+(instancetype) tagWithName:(NSString *)name context:(NSManagedObjectContext *)context{
    
    AGTTag *tag = [self insertInManagedObjectContext:context];
    tag.name = name;
    
    return tag;
}

@end

#import "AGTTag.h"
#import "Constants.h"

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

-(NSComparisonResult)compare: (AGTTag *) otherTag {
    
    if ([self.name isEqualToString:FAVORITE_TAG_KEY]) {
        return NSOrderedAscending;
    } else if ([otherTag.name isEqualToString:FAVORITE_TAG_KEY]) {
        return NSOrderedDescending;
    } else  if ([self.name isEqualToString:self.name]){
        return NSOrderedSame;
    } else {
        return [self.name compare:otherTag.name];
    }
}

@end

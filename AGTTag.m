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

-(NSComparisonResult)customCompare: (AGTTag *) otherTag {
    
    if ([self.name isEqualToString:FAVORITE_TAG_KEY]) {
        return NSOrderedAscending;
    } else if ([otherTag.name isEqualToString:FAVORITE_TAG_KEY]) {
        return NSOrderedDescending;
    } else {
        return [self.name compare:otherTag.name options:NSCaseInsensitiveSearch];
    }
}

@end

#import "_AGTPhoto.h"

@interface AGTPhoto : _AGTPhoto {}
// Custom logic goes here.

+(instancetype) photoWithData: (NSData *)data context: (NSManagedObjectContext *) context;

@end

#import "_AGTBook.h"

@interface AGTBook : _AGTBook {}
// Custom logic goes here.

+(instancetype) bookWithDict: (NSDictionary *) dict context: (NSManagedObjectContext *) context;

@end

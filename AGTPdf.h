#import "_AGTPdf.h"

@interface AGTPdf : _AGTPdf {}
// Custom logic goes here.

+(instancetype) pdfWithString: (NSString *) url context: (NSManagedObjectContext *) context;

@end

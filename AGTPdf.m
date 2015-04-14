#import "AGTPdf.h"

@interface AGTPdf ()

// Private interface goes here.

@end

@implementation AGTPdf

// Custom logic goes here.

+(instancetype) pdfWithString: (NSString *) url context: (NSManagedObjectContext *) context {
    
    AGTPdf *pdf = [self insertInManagedObjectContext:context];
    pdf.url = url;
    pdf.pdfData = nil;
    
    return pdf;
    
}

@end

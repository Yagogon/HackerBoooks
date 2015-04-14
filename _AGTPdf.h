// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AGTPdf.h instead.

@import CoreData;

extern const struct AGTPdfAttributes {
	__unsafe_unretained NSString *pdfData;
	__unsafe_unretained NSString *url;
} AGTPdfAttributes;

extern const struct AGTPdfRelationships {
	__unsafe_unretained NSString *book;
} AGTPdfRelationships;

@class AGTBook;

@interface AGTPdfID : NSManagedObjectID {}
@end

@interface _AGTPdf : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AGTPdfID* objectID;

@property (nonatomic, strong) NSData* pdfData;

//- (BOOL)validatePdfData:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* url;

//- (BOOL)validateUrl:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) AGTBook *book;

//- (BOOL)validateBook:(id*)value_ error:(NSError**)error_;

@end

@interface _AGTPdf (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitivePdfData;
- (void)setPrimitivePdfData:(NSData*)value;

- (NSString*)primitiveUrl;
- (void)setPrimitiveUrl:(NSString*)value;

- (AGTBook*)primitiveBook;
- (void)setPrimitiveBook:(AGTBook*)value;

@end

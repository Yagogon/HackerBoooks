// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AGTTag.h instead.

@import CoreData;

extern const struct AGTTagAttributes {
	__unsafe_unretained NSString *name;
} AGTTagAttributes;

extern const struct AGTTagRelationships {
	__unsafe_unretained NSString *books;
} AGTTagRelationships;

@class AGTBook;

@interface AGTTagID : NSManagedObjectID {}
@end

@interface _AGTTag : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AGTTagID* objectID;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *books;

- (NSMutableSet*)booksSet;

@end

@interface _AGTTag (BooksCoreDataGeneratedAccessors)
- (void)addBooks:(NSSet*)value_;
- (void)removeBooks:(NSSet*)value_;
- (void)addBooksObject:(AGTBook*)value_;
- (void)removeBooksObject:(AGTBook*)value_;

@end

@interface _AGTTag (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSMutableSet*)primitiveBooks;
- (void)setPrimitiveBooks:(NSMutableSet*)value;

@end

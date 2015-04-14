// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AGTBook.h instead.

@import CoreData;

extern const struct AGTBookAttributes {
	__unsafe_unretained NSString *authors;
	__unsafe_unretained NSString *bookImage;
	__unsafe_unretained NSString *bookUrl;
	__unsafe_unretained NSString *favorite;
	__unsafe_unretained NSString *title;
} AGTBookAttributes;

extern const struct AGTBookRelationships {
	__unsafe_unretained NSString *annotations;
	__unsafe_unretained NSString *pdf;
	__unsafe_unretained NSString *tags;
} AGTBookRelationships;

@class AGTAnnotation;
@class AGTPdf;
@class AGTTag;

@interface AGTBookID : NSManagedObjectID {}
@end

@interface _AGTBook : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AGTBookID* objectID;

@property (nonatomic, strong) NSString* authors;

//- (BOOL)validateAuthors:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSData* bookImage;

//- (BOOL)validateBookImage:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* bookUrl;

//- (BOOL)validateBookUrl:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* favorite;

@property (atomic) BOOL favoriteValue;
- (BOOL)favoriteValue;
- (void)setFavoriteValue:(BOOL)value_;

//- (BOOL)validateFavorite:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* title;

//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *annotations;

- (NSMutableSet*)annotationsSet;

@property (nonatomic, strong) AGTPdf *pdf;

//- (BOOL)validatePdf:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *tags;

- (NSMutableSet*)tagsSet;

@end

@interface _AGTBook (AnnotationsCoreDataGeneratedAccessors)
- (void)addAnnotations:(NSSet*)value_;
- (void)removeAnnotations:(NSSet*)value_;
- (void)addAnnotationsObject:(AGTAnnotation*)value_;
- (void)removeAnnotationsObject:(AGTAnnotation*)value_;

@end

@interface _AGTBook (TagsCoreDataGeneratedAccessors)
- (void)addTags:(NSSet*)value_;
- (void)removeTags:(NSSet*)value_;
- (void)addTagsObject:(AGTTag*)value_;
- (void)removeTagsObject:(AGTTag*)value_;

@end

@interface _AGTBook (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveAuthors;
- (void)setPrimitiveAuthors:(NSString*)value;

- (NSData*)primitiveBookImage;
- (void)setPrimitiveBookImage:(NSData*)value;

- (NSString*)primitiveBookUrl;
- (void)setPrimitiveBookUrl:(NSString*)value;

- (NSNumber*)primitiveFavorite;
- (void)setPrimitiveFavorite:(NSNumber*)value;

- (BOOL)primitiveFavoriteValue;
- (void)setPrimitiveFavoriteValue:(BOOL)value_;

- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;

- (NSMutableSet*)primitiveAnnotations;
- (void)setPrimitiveAnnotations:(NSMutableSet*)value;

- (AGTPdf*)primitivePdf;
- (void)setPrimitivePdf:(AGTPdf*)value;

- (NSMutableSet*)primitiveTags;
- (void)setPrimitiveTags:(NSMutableSet*)value;

@end

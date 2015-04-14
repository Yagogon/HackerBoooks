// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AGTPhoto.h instead.

@import CoreData;

extern const struct AGTPhotoAttributes {
	__unsafe_unretained NSString *photoData;
} AGTPhotoAttributes;

extern const struct AGTPhotoRelationships {
	__unsafe_unretained NSString *annotation;
} AGTPhotoRelationships;

@class AGTAnnotation;

@interface AGTPhotoID : NSManagedObjectID {}
@end

@interface _AGTPhoto : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AGTPhotoID* objectID;

@property (nonatomic, strong) NSData* photoData;

//- (BOOL)validatePhotoData:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) AGTAnnotation *annotation;

//- (BOOL)validateAnnotation:(id*)value_ error:(NSError**)error_;

@end

@interface _AGTPhoto (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitivePhotoData;
- (void)setPrimitivePhotoData:(NSData*)value;

- (AGTAnnotation*)primitiveAnnotation;
- (void)setPrimitiveAnnotation:(AGTAnnotation*)value;

@end

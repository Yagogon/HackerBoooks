// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AGTAnnotation.h instead.

@import CoreData;

extern const struct AGTAnnotationAttributes {
	__unsafe_unretained NSString *createData;
	__unsafe_unretained NSString *modificationData;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *text;
} AGTAnnotationAttributes;

extern const struct AGTAnnotationRelationships {
	__unsafe_unretained NSString *book;
	__unsafe_unretained NSString *location;
	__unsafe_unretained NSString *photo;
} AGTAnnotationRelationships;

@class AGTBook;
@class AGTLocation;
@class AGTPhoto;

@interface AGTAnnotationID : NSManagedObjectID {}
@end

@interface _AGTAnnotation : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) AGTAnnotationID* objectID;

@property (nonatomic, strong) NSDate* createData;

//- (BOOL)validateCreateData:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* modificationData;

//- (BOOL)validateModificationData:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* text;

//- (BOOL)validateText:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) AGTBook *book;

//- (BOOL)validateBook:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) AGTLocation *location;

//- (BOOL)validateLocation:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) AGTPhoto *photo;

//- (BOOL)validatePhoto:(id*)value_ error:(NSError**)error_;

@end

@interface _AGTAnnotation (CoreDataGeneratedPrimitiveAccessors)

- (NSDate*)primitiveCreateData;
- (void)setPrimitiveCreateData:(NSDate*)value;

- (NSDate*)primitiveModificationData;
- (void)setPrimitiveModificationData:(NSDate*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSString*)primitiveText;
- (void)setPrimitiveText:(NSString*)value;

- (AGTBook*)primitiveBook;
- (void)setPrimitiveBook:(AGTBook*)value;

- (AGTLocation*)primitiveLocation;
- (void)setPrimitiveLocation:(AGTLocation*)value;

- (AGTPhoto*)primitivePhoto;
- (void)setPrimitivePhoto:(AGTPhoto*)value;

@end

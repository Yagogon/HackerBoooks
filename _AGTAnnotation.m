// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to AGTAnnotation.m instead.

#import "_AGTAnnotation.h"

const struct AGTAnnotationAttributes AGTAnnotationAttributes = {
	.createData = @"createData",
	.modificationData = @"modificationData",
	.name = @"name",
	.text = @"text",
};

const struct AGTAnnotationRelationships AGTAnnotationRelationships = {
	.book = @"book",
	.location = @"location",
	.photo = @"photo",
};

@implementation AGTAnnotationID
@end

@implementation _AGTAnnotation

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Annotation" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Annotation";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Annotation" inManagedObjectContext:moc_];
}

- (AGTAnnotationID*)objectID {
	return (AGTAnnotationID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic createData;

@dynamic modificationData;

@dynamic name;

@dynamic text;

@dynamic book;

@dynamic location;

@dynamic photo;

@end


// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FJLPhoto.m instead.

#import "_FJLPhoto.h"

@implementation FJLPhotoID
@end

@implementation _FJLPhoto

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Photo" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Photo";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Photo" inManagedObjectContext:moc_];
}

- (FJLPhotoID*)objectID {
	return (FJLPhotoID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic imageData;

@dynamic notes;

- (NSMutableSet<FJLNote*>*)notesSet {
	[self willAccessValueForKey:@"notes"];

	NSMutableSet<FJLNote*> *result = (NSMutableSet<FJLNote*>*)[self mutableSetValueForKey:@"notes"];

	[self didAccessValueForKey:@"notes"];
	return result;
}

@end

@implementation FJLPhotoAttributes 
+ (NSString *)imageData {
	return @"imageData";
}
@end

@implementation FJLPhotoRelationships 
+ (NSString *)notes {
	return @"notes";
}
@end


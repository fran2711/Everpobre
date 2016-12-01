// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FJLNote.m instead.

#import "_FJLNote.h"

@implementation FJLNoteID
@end

@implementation _FJLNote

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Note";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Note" inManagedObjectContext:moc_];
}

- (FJLNoteID*)objectID {
	return (FJLNoteID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic text;

@dynamic location;

@dynamic notebook;

@dynamic photo;

@end

@implementation FJLNoteAttributes 
+ (NSString *)text {
	return @"text";
}
@end

@implementation FJLNoteRelationships 
+ (NSString *)location {
	return @"location";
}
+ (NSString *)notebook {
	return @"notebook";
}
+ (NSString *)photo {
	return @"photo";
}
@end


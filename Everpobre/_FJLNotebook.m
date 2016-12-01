// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FJLNotebook.m instead.

#import "_FJLNotebook.h"

@implementation FJLNotebookID
@end

@implementation _FJLNotebook

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Notebook" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Notebook";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Notebook" inManagedObjectContext:moc_];
}

- (FJLNotebookID*)objectID {
	return (FJLNotebookID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic notes;

- (NSMutableSet<FJLNote*>*)notesSet {
	[self willAccessValueForKey:@"notes"];

	NSMutableSet<FJLNote*> *result = (NSMutableSet<FJLNote*>*)[self mutableSetValueForKey:@"notes"];

	[self didAccessValueForKey:@"notes"];
	return result;
}

@end

@implementation FJLNotebookRelationships 
+ (NSString *)notes {
	return @"notes";
}
@end


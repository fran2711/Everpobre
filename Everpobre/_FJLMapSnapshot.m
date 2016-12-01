// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FJLMapSnapshot.m instead.

#import "_FJLMapSnapshot.h"

@implementation FJLMapSnapshotID
@end

@implementation _FJLMapSnapshot

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"MapSnapshot" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"MapSnapshot";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"MapSnapshot" inManagedObjectContext:moc_];
}

- (FJLMapSnapshotID*)objectID {
	return (FJLMapSnapshotID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic snapshotData;

@dynamic location;

@end

@implementation FJLMapSnapshotAttributes 
+ (NSString *)snapshotData {
	return @"snapshotData";
}
@end

@implementation FJLMapSnapshotRelationships 
+ (NSString *)location {
	return @"location";
}
@end


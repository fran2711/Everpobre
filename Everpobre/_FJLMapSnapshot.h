// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FJLMapSnapshot.h instead.

@import CoreData;

NS_ASSUME_NONNULL_BEGIN

@class FJLLocation;

@interface FJLMapSnapshotID : NSManagedObjectID {}
@end

@interface _FJLMapSnapshot : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) FJLMapSnapshotID*objectID;

@property (nonatomic, strong) NSData* snapshotData;

@property (nonatomic, strong) FJLLocation *location;

@end

@interface _FJLMapSnapshot (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitiveSnapshotData;
- (void)setPrimitiveSnapshotData:(NSData*)value;

- (FJLLocation*)primitiveLocation;
- (void)setPrimitiveLocation:(FJLLocation*)value;

@end

@interface FJLMapSnapshotAttributes: NSObject 
+ (NSString *)snapshotData;
@end

@interface FJLMapSnapshotRelationships: NSObject
+ (NSString *)location;
@end

NS_ASSUME_NONNULL_END

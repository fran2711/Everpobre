// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FJLNamedEntity.h instead.

@import CoreData;

NS_ASSUME_NONNULL_BEGIN

@interface FJLNamedEntityID : NSManagedObjectID {}
@end

@interface _FJLNamedEntity : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) FJLNamedEntityID*objectID;

@property (nonatomic, strong) NSDate* creationDate;

@property (nonatomic, strong) NSDate* modificationDate;

@property (nonatomic, strong) NSString* name;

@end

@interface _FJLNamedEntity (CoreDataGeneratedPrimitiveAccessors)

- (NSDate*)primitiveCreationDate;
- (void)setPrimitiveCreationDate:(NSDate*)value;

- (NSDate*)primitiveModificationDate;
- (void)setPrimitiveModificationDate:(NSDate*)value;

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

@end

@interface FJLNamedEntityAttributes: NSObject 
+ (NSString *)creationDate;
+ (NSString *)modificationDate;
+ (NSString *)name;
@end

NS_ASSUME_NONNULL_END

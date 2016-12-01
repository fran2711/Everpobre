// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FJLLocation.h instead.

@import CoreData;

NS_ASSUME_NONNULL_BEGIN

@class FJLMapSnapshot;
@class FJLNote;

@interface FJLLocationID : NSManagedObjectID {}
@end

@interface _FJLLocation : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) FJLLocationID*objectID;

@property (nonatomic, strong, nullable) NSString* adress;

@property (nonatomic, strong, nullable) NSNumber* latitude;

@property (atomic) double latitudeValue;
- (double)latitudeValue;
- (void)setLatitudeValue:(double)value_;


@property (nonatomic, strong, nullable) NSNumber* longitude;

@property (atomic) double longitudeValue;
- (double)longitudeValue;
- (void)setLongitudeValue:(double)value_;



@property (nonatomic, strong, nullable) FJLMapSnapshot *mapsnapshot;

@property (nonatomic, strong) NSSet<FJLNote*> *notes;

- (NSMutableSet<FJLNote*>*)notesSet;

@end

@interface _FJLLocation (NotesCoreDataGeneratedAccessors)
- (void)addNotes:(NSSet<FJLNote*>*)value_;
- (void)removeNotes:(NSSet<FJLNote*>*)value_;
- (void)addNotesObject:(FJLNote*)value_;
- (void)removeNotesObject:(FJLNote*)value_;

@end

@interface _FJLLocation (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveAdress;
- (void)setPrimitiveAdress:(NSString*)value;

- (NSNumber*)primitiveLatitude;
- (void)setPrimitiveLatitude:(NSNumber*)value;

- (double)primitiveLatitudeValue;
- (void)setPrimitiveLatitudeValue:(double)value_;

- (NSNumber*)primitiveLongitude;
- (void)setPrimitiveLongitude:(NSNumber*)value;

- (double)primitiveLongitudeValue;
- (void)setPrimitiveLongitudeValue:(double)value_;

- (FJLMapSnapshot*)primitiveMapsnapshot;
- (void)setPrimitiveMapsnapshot:(FJLMapSnapshot*)value;

- (NSMutableSet<FJLNote*>*)primitiveNotes;
- (void)setPrimitiveNotes:(NSMutableSet<FJLNote*>*)value;

@end

@interface FJLLocationAttributes: NSObject 
+ (NSString *)adress;
+ (NSString *)latitude;
+ (NSString *)longitude;
@end

@interface FJLLocationRelationships: NSObject
+ (NSString *)mapsnapshot;
+ (NSString *)notes;
@end

NS_ASSUME_NONNULL_END

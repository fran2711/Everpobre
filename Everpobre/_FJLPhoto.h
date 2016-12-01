// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FJLPhoto.h instead.

@import CoreData;

NS_ASSUME_NONNULL_BEGIN

@class FJLNote;

@interface FJLPhotoID : NSManagedObjectID {}
@end

@interface _FJLPhoto : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) FJLPhotoID*objectID;

@property (nonatomic, strong) NSData* imageData;

@property (nonatomic, strong) NSSet<FJLNote*> *notes;
- (NSMutableSet<FJLNote*>*)notesSet;

@end

@interface _FJLPhoto (NotesCoreDataGeneratedAccessors)
- (void)addNotes:(NSSet<FJLNote*>*)value_;
- (void)removeNotes:(NSSet<FJLNote*>*)value_;
- (void)addNotesObject:(FJLNote*)value_;
- (void)removeNotesObject:(FJLNote*)value_;

@end

@interface _FJLPhoto (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitiveImageData;
- (void)setPrimitiveImageData:(NSData*)value;

- (NSMutableSet<FJLNote*>*)primitiveNotes;
- (void)setPrimitiveNotes:(NSMutableSet<FJLNote*>*)value;

@end

@interface FJLPhotoAttributes: NSObject 
+ (NSString *)imageData;
@end

@interface FJLPhotoRelationships: NSObject
+ (NSString *)notes;
@end

NS_ASSUME_NONNULL_END

// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FJLNotebook.h instead.

@import CoreData;

#import "FJLNamedEntity.h"

NS_ASSUME_NONNULL_BEGIN

@class FJLNote;

@interface FJLNotebookID : FJLNamedEntityID {}
@end

@interface _FJLNotebook : FJLNamedEntity
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) FJLNotebookID*objectID;

@property (nonatomic, strong, nullable) NSSet<FJLNote*> *notes;
- (nullable NSMutableSet<FJLNote*>*)notesSet;

@end

@interface _FJLNotebook (NotesCoreDataGeneratedAccessors)
- (void)addNotes:(NSSet<FJLNote*>*)value_;
- (void)removeNotes:(NSSet<FJLNote*>*)value_;
- (void)addNotesObject:(FJLNote*)value_;
- (void)removeNotesObject:(FJLNote*)value_;

@end

@interface _FJLNotebook (CoreDataGeneratedPrimitiveAccessors)

- (NSMutableSet<FJLNote*>*)primitiveNotes;
- (void)setPrimitiveNotes:(NSMutableSet<FJLNote*>*)value;

@end

@interface FJLNotebookRelationships: NSObject
+ (NSString *)notes;
@end

NS_ASSUME_NONNULL_END

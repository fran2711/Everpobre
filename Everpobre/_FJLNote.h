// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FJLNote.h instead.

@import CoreData;

#import "FJLNamedEntity.h"

NS_ASSUME_NONNULL_BEGIN

@class FJLLocation;
@class FJLNotebook;
@class FJLPhoto;

@interface FJLNoteID : FJLNamedEntityID {}
@end

@interface _FJLNote : FJLNamedEntity
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) FJLNoteID*objectID;

@property (nonatomic, strong, nullable) NSString* text;

@property (nonatomic, strong, nullable) FJLLocation *location;

@property (nonatomic, strong) FJLNotebook *notebook;

@property (nonatomic, strong, nullable) FJLPhoto *photo;

@end

@interface _FJLNote (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveText;
- (void)setPrimitiveText:(NSString*)value;

- (FJLLocation*)primitiveLocation;
- (void)setPrimitiveLocation:(FJLLocation*)value;

- (FJLNotebook*)primitiveNotebook;
- (void)setPrimitiveNotebook:(FJLNotebook*)value;

- (FJLPhoto*)primitivePhoto;
- (void)setPrimitivePhoto:(FJLPhoto*)value;

@end

@interface FJLNoteAttributes: NSObject 
+ (NSString *)text;
@end

@interface FJLNoteRelationships: NSObject
+ (NSString *)location;
+ (NSString *)notebook;
+ (NSString *)photo;
@end

NS_ASSUME_NONNULL_END

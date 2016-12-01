#import "_FJLNote.h"

@interface FJLNote : _FJLNote {}
// Custom logic goes here.
@property (nonatomic, readonly) BOOL hasLocation;

+(instancetype) noteWithName: (NSString *) name
                    notebook: (FJLNotebook *) notebook
                     context: (NSManagedObjectContext *) context;


@end

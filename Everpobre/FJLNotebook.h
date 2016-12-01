#import "_FJLNotebook.h"

@interface FJLNotebook : _FJLNotebook {}
// Custom logic goes here.

+(instancetype) notebookWithName: (NSString *) name
                         context: (NSManagedObjectContext *) context;

@end

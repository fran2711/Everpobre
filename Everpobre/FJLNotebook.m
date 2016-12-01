#import "FJLNotebook.h"

@interface FJLNotebook ()

// Private interface goes here.

+(NSArray *) observableKeyNames;

@end

@implementation FJLNotebook

// Custom logic goes here.

+(NSArray *)observableKeyNames{
    return @[@"creationDate", @"name", @"notes"];
}

+(instancetype) notebookWithName:(NSString *)name
                         context:(NSManagedObjectContext *) context{
    
    FJLNotebook *nb = [NSEntityDescription insertNewObjectForEntityForName:[FJLNotebook entityName]
                                                    inManagedObjectContext:context];
    
    nb.name = name;
    nb.creationDate = [NSDate date];
    nb.modificationDate = [NSDate date];
    return nb;
}



@end

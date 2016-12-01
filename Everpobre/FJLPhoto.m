#import "FJLPhoto.h"

@interface FJLPhoto ()

// Private interface goes here.

@end

@implementation FJLPhoto

// Custom logic goes here.
#pragma mark - Properties
-(void) setImage:(UIImage *)image{
    
    //Sincronizar con imageData
    self.imageData = UIImageJPEGRepresentation(image, 0.9);
    
}

//Getter de image
-(UIImage *) image{
    
    //Realizo la carga perezosa
    
       return [UIImage imageWithData:self.imageData];
    
}



#pragma mark - Class Methods

+(instancetype) photoWithImage: (UIImage *) image
                       context: (NSManagedObjectContext *) context{
    
    FJLPhoto *p = [NSEntityDescription insertNewObjectForEntityForName: [FJLPhoto entityName]
                                                inManagedObjectContext: context];
    
    p.imageData = UIImageJPEGRepresentation(image, 0.9);
    
    return p;
}



@end

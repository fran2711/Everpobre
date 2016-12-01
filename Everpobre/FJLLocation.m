#import "FJLLocation.h"
#import "FJLNote.h"
#import "FJLMapSnapshot.h"
#import <CoreLocation/CoreLocation.h>

@import AddressBookUI;

@interface FJLLocation ()

// Private interface goes here.

@end

@implementation FJLLocation

+(instancetype) locationWithCLLocation:(CLLocation*)location forNote:(FJLNote *) note{
    
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[FJLLocation entityName]];
    NSPredicate *latitude = [NSPredicate predicateWithFormat:@"abs(latitude) - abs(%lf) < 0.001",
                             location.coordinate.latitude];
    NSPredicate *longitude = [NSPredicate predicateWithFormat:@"abs(longitude) - abs(%lf) < 0.001",
                              location.coordinate.longitude];
    req.predicate = [NSCompoundPredicate andPredicateWithSubpredicates:@[latitude, longitude]];
    
    NSError *error;
    NSArray *results = [note.managedObjectContext executeFetchRequest:req
                                                                error:&error];
    
    NSAssert(results, @"¡Error al buscar una FJLLocation!");
    
    if ([results count]) {
        
        // Aprovechamos lo encontrado
        FJLLocation *found = [results lastObject];
        [found addNotesObject:note];
        return found;
        
    }else{
        // Creamos uno de cero
        FJLLocation *loc = [self insertInManagedObjectContext:note.managedObjectContext];
        loc.latitudeValue = location.coordinate.latitude;
        loc.longitudeValue = location.coordinate.longitude;
        [loc addNotesObject:note];
        
        // Dirección
        CLGeocoder *coder = [[CLGeocoder alloc]init];
        [coder reverseGeocodeLocation:location
                    completionHandler:^(NSArray *placemarks, NSError *error) {
                        
                        if (error) {
                            NSLog(@"Error while obtaining address!\n%@", error);
                        }else{
                            loc.adress = ABCreateStringWithAddressDictionary([[placemarks lastObject] addressDictionary], YES);
                            
                        }
                    }];
        
        // Snapshot
        loc.mapsnapshot = [FJLMapSnapshot mapSnapshotForLocation:loc];
        
        return loc;
        
    }
    
    
    
}


#pragma mark - MKAnnotation
-(NSString*) title{
    return @"I wrote a note here!";
}

-(NSString *) subtitle{
    NSArray *lines = [self.adress componentsSeparatedByString:@"\n"];
    NSMutableString *concat = [@"" mutableCopy];
    for (NSString *line in lines) {
        [concat appendFormat:@"%@ ", line];
    }
    
    return concat;
}

-(CLLocationCoordinate2D)coordinate{
    
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(self.latitudeValue, self.longitudeValue);
    return coord;
}



@end

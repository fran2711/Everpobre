#import "FJLMapSnapshot.h"
#import "FJLLocation.h"
@import MapKit;

@interface FJLMapSnapshot ()

// Private interface goes here.

@end

@implementation FJLMapSnapshot

// Custom logic goes here.
#pragma mark - Properties

-(UIImage *) image{
    
    return [UIImage imageWithData:self.snapshotData];
}

-(void) setImage:(UIImage *)image{
    
    self.snapshotData = UIImageJPEGRepresentation(image, 0.9);
}

#pragma mark - Class Names

+(instancetype) mapSnapshotForLocation: (FJLLocation *) location{
    
    FJLMapSnapshot *snap = [FJLMapSnapshot insertInManagedObjectContext: location.managedObjectContext];
    
    snap.location = location;
    
    return snap;
    
}



-(void) awakeFromInsert{
    
    //Observo la propiedad location y recalculo la propiedad snapshot
    [super awakeFromInsert];
    
    [self startObserving];
    
    
}

-(void)awakeFromFetch{
    
    //Observo la propiedad location y recalculo la propiedad snapshot
    [super awakeFromFetch];
    
    [self startObserving];
    
}

-(void) willTurnIntoFault{
    
    [super willTurnIntoFault];
    
    [self stopObserving];
    
}



#pragma mark - KVO

-(void) startObserving{
    
    //Empiezo a observar la propiedad location
    [self addObserver: self
           forKeyPath:@"location"
              options: NSKeyValueObservingOptionNew
              context: NULL];
}


-(void) stopObserving{
    
    //Dejo de observar la propiedad loaction
    [self removeObserver: self
              forKeyPath: @"location"];
}


-(void) observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context{
    
    //Recalculo el mapSnapshot
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(self.location.latitudeValue, self.location.longitudeValue);
    
    //Configuro el creador de snapshots
    MKMapSnapshotOptions *options = [MKMapSnapshotOptions new];
    
    options.region = MKCoordinateRegionMakeWithDistance(center, 300, 300);
    
    options.mapType = MKMapTypeHybrid;
    
    options.size = CGSizeMake(150, 150);
    
    MKMapSnapshotter *shotter = [[MKMapSnapshotter alloc] initWithOptions: options];
    
    [shotter startWithCompletionHandler:^(MKMapSnapshot * _Nullable snapshot, NSError * _Nullable error) {
       
        if (!error) {
            
            //Sin error, por lo que guardo el sanpshot
            self.image = snapshot.image;
        }else{
            
            //Si hay error, la existencia del snapshot no tiene sentido
            [self setPrimitiveLocation: nil];
            [self.managedObjectContext deleteObject:self];
            
        }
        
    }];
    
}

@end

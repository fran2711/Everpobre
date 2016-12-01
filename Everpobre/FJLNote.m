#import "FJLNote.h"
#import "FJLLocation.h"

@import CoreLocation;

@interface FJLNote ()<CLLocationManagerDelegate>

+(NSArray *) observableKeyNames;

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation FJLNote

@synthesize locationManager = _locationManager;

-(BOOL)hasLocation{
    return (nil != self.location);
}


+(NSArray *) observableKeyNames{
    return @[@"name", @"creationDate", @"notebook", @"photo", @"location"];
    
}
+(instancetype) noteWithName:(NSString *) name
                    notebook:(FJLNotebook *) notebook
                     context:(NSManagedObjectContext *) context{
    
    FJLNote *note = [NSEntityDescription insertNewObjectForEntityForName:[FJLNote entityName]
                                                  inManagedObjectContext:context];
    
    note.creationDate = [NSDate date];
    note.notebook = notebook;
    note.modificationDate = [NSDate date];
    note.name = name;
    return note;
}


#pragma mark - Init
-(void) awakeFromInsert{
    [super awakeFromInsert];
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    if (((status == kCLAuthorizationStatusAuthorized) || (status == kCLAuthorizationStatusNotDetermined)) && [CLLocationManager locationServicesEnabled]) {
        
        //Tengo localización
        self.locationManager = [CLLocationManager new];
        
        self.locationManager.delegate = self;
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        
        [self.locationManager startUpdatingLocation];
        
        //Solo datos recientes
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self zapLocationManager];
        });
    }
    
}

#pragma mark - CLLocationManagerDelegate

-(void) locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    //Lo paro
    //[self.locationManager stopUpdatingLocation];
    //self.locationManager = nil;
    [self zapLocationManager];
    
    
    if (self.location == nil) {
        //Cojo la ultima localización
        CLLocation *loc = [locations lastObject];
        
        //FJLLocation lo creo
        self.location = [FJLLocation locationWithCLLocation: loc
                                                    forNote: self];
    }else{
        NSLog(@"No deberia llegar nunca!");
    }
    
    
}


-(void) zapLocationManager{
    
    [self.locationManager stopUpdatingLocation];
    self.locationManager.delegate = nil;
    self.locationManager = nil;
}







@end

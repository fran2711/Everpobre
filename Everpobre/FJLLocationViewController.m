//
//  FJLLocationViewController.m
//  Everpobre
//
//  Created by Fran Lucena on 12/04/16.
//  Copyright © 2016 Fran Lucena. All rights reserved.
//

#import "FJLLocationViewController.h"
#import "FJLLocation.h"

@interface FJLLocationViewController ()  <MKMapViewDelegate>

@property (nonatomic, strong) FJLLocation *model;

@end

@implementation FJLLocationViewController


-(id) initWithLocation: (FJLLocation *) location{
    
    if (self = [super initWithNibName: nil
                               bundle: nil]) {
        _model = location;
    }
    
    return self;
    
    
}


-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Pasarlo a la MapView
    [self.mapView addAnnotation:self.model];
    
    
    //Asigno Region Inicial
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance( self.model.coordinate, 2000000, 2000000);
    [self.mapView setRegion: region];
    
}



-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //Asignar region y animar
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance( self.model.coordinate, 500, 500);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self.mapView setRegion: region
                       animated: YES];
        
    });
    
}


#pragma mark - Actions


- (IBAction)standardMap:(id)sender {
    
    self.mapView.mapType = MKMapTypeStandard;
    
}

- (IBAction)satelliteMap:(id)sender {
    
    self.mapView.mapType = MKMapTypeSatellite;
    
}

- (IBAction)hybridMap:(id)sender {
    
    self.mapView.mapType = MKMapTypeHybrid;
    
}





#pragma mark - MKMapViewDelegate

















@end

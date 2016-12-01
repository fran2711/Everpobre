//
//  FJLLocationViewController.h
//  Everpobre
//
//  Created by Fran Lucena on 12/04/16.
//  Copyright © 2016 Fran Lucena. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;
@class FJLLocation;

@interface FJLLocationViewController : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
- (IBAction)standardMap:(id)sender;
- (IBAction)satelliteMap:(id)sender;
- (IBAction)hybridMap:(id)sender;


-(id) initWithLocation: (FJLLocation *) location;

@end

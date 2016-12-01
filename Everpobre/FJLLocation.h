#import "_FJLLocation.h"

@import MapKit;
@import CoreLocation;

@class FJLNote;

@interface FJLLocation : _FJLLocation <MKAnnotation> {}
// Custom logic goes here.

+(instancetype) locationWithCLLocation: (CLLocation *)location forNote: (FJLNote *) note;


@end

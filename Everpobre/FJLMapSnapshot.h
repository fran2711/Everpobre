#import "_FJLMapSnapshot.h"
@import UIKit;

@interface FJLMapSnapshot : _FJLMapSnapshot
// Custom logic goes here.

@property(nonatomic, strong) UIImage *image;


+(instancetype) mapSnapshotForLocation: (FJLLocation *) location;

@end

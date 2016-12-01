#import "_FJLPhoto.h"
@import UIKit;

@interface FJLPhoto : _FJLPhoto {}
// Custom logic goes here.

@property (nonatomic, strong) UIImage *image;


+(instancetype) photoWithImage: (UIImage *) image
                       context: (NSManagedObjectContext *) context;

@end

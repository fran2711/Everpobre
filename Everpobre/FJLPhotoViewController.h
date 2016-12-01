//
//  FJLPhotoViewController.h
//  Everpobre
//
//  Created by Fran Lucena on 25/03/16.
//  Copyright © 2016 Fran Lucena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FJLDetailViewController.h"


@interface FJLPhotoViewController : UIViewController <FJLDetailViewController>

@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityView;

- (IBAction)takePhoto:(id)sender;
- (IBAction)deletePhoto:(id)sender;
- (IBAction)applyVintageEffect:(id)sender;
- (IBAction)zoomToFace:(id)sender;

@end

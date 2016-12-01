//
//  FJLNoteViewController.h
//  Everpobre
//
//  Created by Fran Lucena on 18/03/16.
//  Copyright © 2016 Fran Lucena. All rights reserved.
//

#import <UIKit/UIKit.h>
@import MapKit;
#import "FJLDetailViewController.h"

@class FJLNote;
@class FJLNotebook;

@interface FJLNoteViewController : UIViewController<FJLDetailViewController>

@property (weak, nonatomic) IBOutlet UILabel *modificationDateView;
@property (weak, nonatomic) IBOutlet UITextField *nameView;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UIImageView *mapSnapshotView;

@property (weak, nonatomic) IBOutlet UITextView *textView;


-(id) initForNewNoteInNotebook: (FJLNotebook *) notebook;



@end

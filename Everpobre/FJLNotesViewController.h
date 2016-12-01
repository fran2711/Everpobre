//
//  FJLNotesViewController.h
//  Everpobre
//
//  Created by Fran Lucena on 16/03/16.
//  Copyright © 2016 Fran Lucena. All rights reserved.
//

#import "FJLCoreDataCollectionViewController.h"

@class FJLNotebook;

@interface FJLNotesViewController : FJLCoreDataCollectionViewController

@property (nonatomic, strong) FJLNotebook *notebook;

@end

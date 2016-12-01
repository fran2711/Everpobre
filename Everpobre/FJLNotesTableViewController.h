//
//  FJLNotesTableViewController.h
//  Everpobre
//
//  Created by Fran Lucena on 11/03/16.
//  Copyright © 2016 Fran Lucena. All rights reserved.
//

#import "FJLCoreDataTableViewController.h"

@class FJLNotebook;

@interface FJLNotesTableViewController : FJLCoreDataTableViewController

-(id) initWithNotebook: (FJLNotebook *) notebook;

@end

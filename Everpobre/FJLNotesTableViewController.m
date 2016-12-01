//
//  FJLNotesTableViewController.m
//  Everpobre
//
//  Created by Fran Lucena on 11/03/16.
//  Copyright © 2016 Fran Lucena. All rights reserved.
//

#import "FJLNotesTableViewController.h"
#import "FJLNotebook.h"
#include "FJLNote.h"

@interface FJLNotesTableViewController ()

@property (strong, nonatomic) FJLNotebook *model;

@end

@implementation FJLNotesTableViewController

#pragma mark - Init

-(id)initWithNotebook:(FJLNotebook *)notebook{
    
    //Creo el fetchedResults
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName: [FJLNote entityName]];
    req.predicate = [NSPredicate predicateWithFormat: @"notebook == %@", notebook];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey: FJLNamedEntityAttributes.name
                                                          ascending: YES]];
    
    NSFetchedResultsController *fetched = [[NSFetchedResultsController alloc] initWithFetchRequest: req
                                                                              managedObjectContext: notebook.managedObjectContext
                                                                                sectionNameKeyPath: nil
                                                                                         cacheName: nil];
    
    if (self = [super initWithFetchedResultsController: fetched
                                                 style: UITableViewStylePlain]) {
        
        self.fetchedResultsController = fetched;
        self.model = notebook;
        self.title = notebook.name;
    }
    
    return self;
    
    
    
}

#pragma mark - Data Source

-(UITableViewCell *) tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FJLNote *note = [self.fetchedResultsController objectAtIndexPath: indexPath];
    
    static NSString *cellId = @"NoteCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellId];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault
                                      reuseIdentifier: cellId];
        
    }
    
    cell.textLabel.text = note.name;
    
    return cell;
    
}







@end

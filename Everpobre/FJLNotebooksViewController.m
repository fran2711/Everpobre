//
//  FJLNoteBooksViewController.m
//  Everpobre
//
//  Created by Fran Lucena on 07/03/16.
//  Copyright © 2016 Fran Lucena. All rights reserved.
//

#import "FJLNotebooksViewController.h"
#import "FJLNotebook.h"
#import "FJLNotebookCellView.h"
#import "FJLNotesTableViewController.h"
#import "FJLNote.h"
#import "FJLNotesViewController.h"

@interface FJLNotebooksViewController ()

@end

@implementation FJLNotebooksViewController

#pragma mark - View Lifecycle

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.title = @"Everpobre";
    
    //Crear un botón, con un target y un action
    UIBarButtonItem * addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAdd
                                                                                target: self
                                                                                action: @selector(addNoteBook:)];
    
    //Lo añado a la barra de navegación
    self.navigationItem.rightBarButtonItem = addButton;
    
    //Añado el botón de edición
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    //Alta en notificación de sensor de proximidad
    UIDevice *dev = [UIDevice currentDevice];
    
    if ([self hasProximitySensor]) {
        
        [dev setProximityMonitoringEnabled: YES];
        
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        
        [center addObserver: self
                   selector:@selector(proximityStateDidChange:)
                       name: UIDeviceProximityStateDidChangeNotification
                     object: nil];
        
    }
    
    //Registro el nib
    UINib *cellNib = [UINib nibWithNibName: @"FJLNotebookCellView"
                                    bundle: nil];
    
    [self.tableView registerNib: cellNib
         forCellReuseIdentifier: [FJLNotebookCellView cellId]];
    
}


-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];

    [center removeObserver: self];
    
    
}

#pragma mark - Actions

-(void)addNoteBook: (id) sender{
    
    //Nueva instancia de FJLNotebook
    [FJLNotebook notebookWithName: @"New Notebook"
                          context: self.fetchedResultsController.managedObjectContext];
}

#pragma mark - Data Source

//Metodo para eliminar una celda
-(void)tableView:(UITableView *)tableView
commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        //Averiguar de que libreta me está hablando
        FJLNotebook *del = [self.fetchedResultsController objectAtIndexPath: indexPath];
        
        //Quitar la libreta del modelo
        [self.fetchedResultsController.managedObjectContext deleteObject: del];
        
    }
    
    
}

-(UITableViewCell *) tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //Averiguar el modelo (notebook)
    FJLNotebook *nb = [self.fetchedResultsController objectAtIndexPath: indexPath];
    
    
    /*Crear una celda estandar
    static NSString *cellId = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: cellId];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle
                                      reuseIdentifier: cellId];
    }
    
    
    //Sincronizar libreta con celda
    cell.textLabel.text = nb.name;
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateStyle = NSDateFormatterMediumStyle;
    cell.detailTextLabel.text = [fmt stringFromDate: nb.modificationDate];
    
    
    //Devolver la celda
    return cell;*/
    
    
    
    //Crear una celda personalizada
    FJLNotebookCellView *cell = [tableView dequeueReusableCellWithIdentifier: [FJLNotebookCellView cellId]];
    
    
    //Sincronizar libreta con celda
    cell.nameView.text = nb.name;
    cell.namberOfNotesView.text = [NSString stringWithFormat:@"%lu", (unsigned long)nb.notes.count];
    
    
    //Devolver la celda
    return cell;
    
}


#pragma mark - TableView Delegate

-(CGFloat) tableView:(UITableView *)tableView
estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [FJLNotebookCellView cellHeight];
}

-(void) tableView: (UITableView *) tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
   /* FJLNotebook *nb = [self.fetchedResultsController objectAtIndexPath: indexPath];
    
    FJLNotesTableViewController *notesVC = [[FJLNotesTableViewController alloc] initWithNotebook: nb];
    
    [self.navigationController pushViewController: notesVC
                                         animated: YES];*/
    
    
    //Creo el fetch request
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName: [FJLNote entityName]];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey: FJLNamedEntityAttributes.name
                                                          ascending: YES],
                            [NSSortDescriptor sortDescriptorWithKey: FJLNamedEntityAttributes.modificationDate
                                                          ascending: NO],
                            [NSSortDescriptor sortDescriptorWithKey: FJLNamedEntityAttributes.creationDate
                                                          ascending: NO]];
    
    req.predicate = [NSPredicate predicateWithFormat: @"notebook == %@", [self.fetchedResultsController objectAtIndexPath: indexPath]];
    
    
    //Creo el fetched results controller
    NSFetchedResultsController *fC = [[NSFetchedResultsController alloc]
                                      initWithFetchRequest: req
                                      managedObjectContext: self.fetchedResultsController.managedObjectContext
                                      sectionNameKeyPath: nil
                                      cacheName: nil];
    
    //Layout
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.itemSize = CGSizeMake (140,  150);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    
    //Creo el controlador de notas
    FJLNotesViewController *notesVC = [FJLNotesViewController
                                       coreDataCollectionViewControllerWithFetchedResultsController: fC
                                       layout: layout];
    
    notesVC.notebook = [self.fetchedResultsController objectAtIndexPath: indexPath];
    
    
    //Hago un push
    
    [self.navigationController pushViewController: notesVC
                                         animated: YES];
    
    
}




#pragma mark - Proximity Sensor

-(void)setupProximitySensor{
    
    UIDevice *dec = [UIDevice currentDevice];
    
    if ([self hasProximitySensor]) {
        
        [dec setProximityMonitoringEnabled: YES];
        
        NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
        
        [center addObserver: self
                   selector: @selector(proximityStateDidChange:)
                       name: UIDeviceProximityStateDidChangeNotification
                     object: nil];
    }
}

//Para saber si hay un detector de proximidad
-(BOOL)hasProximitySensor{
    
    UIDevice *dev = [UIDevice currentDevice];
    
    BOOL oldValue = [dev isProximityMonitoringEnabled];
    
    [dev setProximityMonitoringEnabled: !oldValue];
    
    BOOL newValue = [dev isProximityMonitoringEnabled];
    
    [dev setProximityMonitoringEnabled: oldValue];
    
    return (oldValue != newValue);
}



//UIDeviceProximityStateDidChangeNotification
-(void)proximityStateDidChange: (NSNotification *) notification{
    
    [self.fetchedResultsController.managedObjectContext.undoManager undo];
    
}

















@end

//
//  AppDelegate.m
//  Everpobre
//
//  Created by Fran Lucena on 18/02/16.
//  Copyright © 2016 Fran Lucena. All rights reserved.
//

#import "FJLAppDelegate.h"
#import "FJLSimpleCoreDataStack.h"

#import "FJLNote.h"
#import "FJLNotebook.h"
#import "FJLLocation.h"
#import "FJLNotebooksViewController.h"
#import "UIViewController+Navigation.h"


@interface FJLAppDelegate ()

@end

@implementation FJLAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //Creo una instancia del stack de Core Data
    self.model = [FJLSimpleCoreDataStack coreDataStackWithModelName: @"Model"];
    
    [self trastearConDatos];
    
    //Añado datos chorras
    if (ADD_DUMMY_DATA) {
        [self addDummyData];
        [self predicateTest];
    }
    
    //Inicion el inspector de datos
    [self printContextState];
    
    //Inicio el autoguardado
    [self autoSave];
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName: [FJLNotebook entityName]];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey: FJLNamedEntityAttributes.modificationDate
                                                          ascending: NO],
                            [NSSortDescriptor sortDescriptorWithKey: FJLNamedEntityAttributes.name
                                                          ascending: YES]];
    
    NSFetchedResultsController *results = [[NSFetchedResultsController alloc] initWithFetchRequest: req
                                                                              managedObjectContext: self.model.context
                                                                                sectionNameKeyPath: nil
                                                                                         cacheName: nil];
    
    
    FJLNotebooksViewController *nbVC = [[FJLNotebooksViewController alloc] initWithFetchedResultsController: results
                                                                                                      style: UITableViewStylePlain];
    
    
    
    self.window.rootViewController = [nbVC wrappedInNavigation];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    [self save];

}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [self save];

}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


#pragma mark - Utils
-(void) addDummyData{
    
    [self.model zapAllData];
    
    FJLNotebook *novias = [FJLNotebook notebookWithName:@"Ex-novias para el recuerdo"
                                                context:self.model.context];
    
    [FJLNote noteWithName:@"Camila Dávalos"
                 notebook:novias
                  context:self.model.context];
    
    [FJLNote noteWithName:@"Mariana Dávalos"
                 notebook:novias
                  context:self.model.context];
    
    [FJLNote noteWithName:@"Pampita"
                 notebook:novias
                  context:self.model.context];
    
    FJLNotebook *lugares = [FJLNotebook notebookWithName:@"Lugares donde me han pasado cosas raras"
                                                 context:self.model.context];
    
    [FJLNote noteWithName:@"Puerta del Sol"
                 notebook:lugares
                  context:self.model.context];
    [FJLNote noteWithName:@"Tatooine"
                 notebook:lugares
                  context:self.model.context];
    [FJLNote noteWithName:@"Dantooine"
                 notebook:lugares
                  context:self.model.context];
    [FJLNote noteWithName:@"Solaria"
                 notebook:lugares
                  context:self.model.context];
    
    // Guardamos
    [self save];
    
}

-(void) trastearConDatos{
    
    
    FJLNotebook *novias = [FJLNotebook notebookWithName:@"Ex-novias para el recuerdo"
                                                context:self.model.context];
    
    [FJLNote noteWithName:@"Camila Dávalos"
                 notebook:novias
                  context:self.model.context];
    
    FJLNote *pampita = [FJLNote noteWithName:@"Pampita"
                                    notebook:novias
                                     context:self.model.context];
    
    
    // Buscar
    NSFetchRequest *req = [[NSFetchRequest alloc] initWithEntityName:[FJLNote entityName]];
    req.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:FJLNamedEntityAttributes.name
                                                          ascending:YES],
                            [NSSortDescriptor sortDescriptorWithKey:FJLNamedEntityAttributes.modificationDate
                                                          ascending:NO]];
    NSError *error = nil;
    NSArray *results = [self.model.context executeFetchRequest:req
                                                         error:&error];
    
    if (results == nil) {
        NSLog(@"Error al buscar: %@", results);
    }else{
        NSLog(@"Results %@", results);
    }
    
    // Eliminamos
    [self.model.context deleteObject:pampita];
    
    
    
    // Guardamos
    [self save];
    
    
}


-(void)save{
    
    [self.model saveWithErrorBlock:^(NSError *error) {
        NSLog(@"Error al guardar %s \n\n %@", __func__, error);
    }];
}

-(void)autoSave{
    
    if (AUTO_SAVE) {
        NSLog(@"Autoguardando....");
        
        [self save];
        [self performSelector:@selector(autoSave)
                   withObject:nil
                   afterDelay:AUTO_SAVE_DELAY_IN_SECONDS];
        
        
    }
}


#pragma mark - Predicate Playground

-(void) predicateTest{
    
    NSPredicate *novias = [NSPredicate predicateWithFormat:@"notebook.name == [cd] 'Ex-novias para el recuerdo'"];
    
    NSPredicate *davalos = [NSCompoundPredicate andPredicateWithSubpredicates: @[novias, [NSPredicate predicateWithFormat:@"name ENDSWITH[cd] 'davalos'"]]];
    
    NSPredicate *pampita = [NSCompoundPredicate andPredicateWithSubpredicates: @[novias, [NSPredicate predicateWithFormat:@"name CONTAINS[cd] 'pampita'"]]];
    
    //Fetch Request
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[FJLNote entityName]];
    NSArray * results = nil;
    
    
    //Selecciono la nota
    req.predicate = novias;
    results = [self.model executeRequest: req
                               withError:^(NSError *error) {
                                   NSLog(@"Error buscando %@", req);
                               }];
    
    NSLog(@"Results: \n %@", results);
    
    //Davalos
    req.predicate = davalos;
    results = [self.model executeRequest: req
                               withError:^(NSError *error) {
                                   NSLog(@"Error buscando %@", req);
                               }];
    
    NSLog(@"Results: \n %@", results);
    
    
    //Pampita
    req.predicate = pampita;
    results = [self.model executeRequest: req
                               withError:^(NSError *error) {
                                   NSLog(@"Error buscando %@", req);
                               }];
    NSLog(@"Results: \n %@", results);


    
    
}


-(void) printContextState{
    
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName: [FJLNotebook entityName]];
    NSUInteger numNotebooks = [[self.model executeRequest: req withError: nil] count];
    
    req = [NSFetchRequest fetchRequestWithEntityName: [FJLNote entityName]];
    NSUInteger numNotes = [[self.model executeRequest: req withError: nil] count];
    
    req = [NSFetchRequest fetchRequestWithEntityName: [FJLLocation entityName]];
    NSUInteger numLocations = [[self.model executeRequest: req withError: nil] count];
    
    printf("-------------------------------------\n");
    printf("Total number of objects:    %lu\n", (unsigned long) self.model.context.registeredObjects.count);
    printf("Nummber of notebooks:    %lu\n", (unsigned long) numNotebooks);
    printf("Nummber of notes:    %lu\n", (unsigned long) numNotes);
    printf("Nummber of locations:    %lu\n", (unsigned long) numLocations);
    printf("-------------------------------------\n\n\n");
    
    [self performSelector: @selector(printContextState)
               withObject: nil
               afterDelay: 5];


    
}











@end

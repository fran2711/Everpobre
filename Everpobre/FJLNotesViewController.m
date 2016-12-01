//
//  FJLNotesViewController.m
//  Everpobre
//
//  Created by Fran Lucena on 16/03/16.
//  Copyright © 2016 Fran Lucena. All rights reserved.
//

#import "FJLNotesViewController.h"
#import "FJLNote.h"
#import "FJLNoteCellView.h"
#import "FJLPhoto.h"
#import "FJLNoteViewController.h"
#import "FJLNotebook.h"


static NSString *cellId = @"NoteCellId";

@interface FJLNotesViewController ()

@end

@implementation FJLNotesViewController

#pragma mark - View Lifecycle

-(void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self registerNib];
    
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.70
                                                            alpha:1];
    
    self.title = @"Notas";
    
    self.detailViewControllerClassName = NSStringFromClass([FJLNoteViewController class]);
    
    
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAdd
                                                                         target: self
                                                                         action: @selector(addNewNote:)];
    
    self.navigationItem.rightBarButtonItem = add;
    
}


#pragma mark - Xib registration
-(void) registerNib{
    
    UINib *nib = [UINib nibWithNibName: @"FJLNoteCollectionViewCell"
                                bundle: nil];
    
    [self.collectionView registerNib: nib
          forCellWithReuseIdentifier: cellId];
}




#pragma mark - Data Source

-(UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //Obtengo el objeto
    FJLNote *note = [self.fetchedResultsController objectAtIndexPath: indexPath];
    
    //Obtengo la celda
    FJLNoteCellView *cell = [collectionView dequeueReusableCellWithReuseIdentifier: cellId
                                                                      forIndexPath: indexPath];
    
    /*//Configuro la celda
    cell.titleView.text = note.name;
    cell.photoView.image = note.photo.image;
    
    
    NSDateFormatter *fmt = [NSDateFormatter new];
    fmt.dateStyle = NSDateFormatterMediumStyle;
    
    cell.modificationDateView.text = [fmt stringFromDate: note.modificationDate];*/
    
    [cell observeNote: note];
    
    //Devuelvo la celda
    return cell;
    
}


#pragma mark - Utils

-(void) addNewNote: (id) sender{

    FJLNoteViewController *newNoteVC = [[FJLNoteViewController alloc] initForNewNoteInNotebook: self.notebook];
    
    [self.navigationController pushViewController: newNoteVC
                                         animated: YES];
    
    
}








//#pragma mark - Delegate
//
//-(void) collectionView:(UICollectionView *)collectionView
//didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    //Obtengo el objeto
//    FJLNote *note = [self.fetchedResultsController objectAtIndexPath: indexPath];
//    
//    //Crear el controlador
//    FJLNoteViewController *noteVC = [[FJLNoteViewController alloc] initWithModel: note];
//    
//    //Hacer un push
//    [self.navigationController pushViewController: noteVC
//                                         animated: YES];
//    
//}
//





@end

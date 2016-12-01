//
//  FJLNoteViewController.m
//  Everpobre
//
//  Created by Fran Lucena on 18/03/16.
//  Copyright © 2016 Fran Lucena. All rights reserved.
//

#import "FJLNoteViewController.h"
#import "FJLNote.h"
#import "FJLPhoto.h"
#import "FJLNotebook.h"
#import "FJLPhotoViewController.h"
#import "FJLLocation.h"
#import "FJLMapSnapshot.h"
#import "FJLLocationViewController.h"


@interface FJLNoteViewController () <UITextFieldDelegate>

@property (strong, nonatomic) FJLNote *model;

@property (nonatomic) BOOL new;

@property(nonatomic) BOOL deleteCurrentNote;
@end

@implementation FJLNoteViewController

#pragma mark - Init

-(id) initWithModel: (id) model{
    
    if (self = [super initWithNibName: nil bundle: nil]) {
        _model = model;
    }
    
    return self;
    
}

-(id) initForNewNoteInNotebook: (FJLNotebook *) notebook{
   
    FJLNote *newNote = [FJLNote noteWithName: @""
                                    notebook: notebook
                                     context: notebook.managedObjectContext];
    
    _new = YES;
    
    return [self initWithModel: newNote];
    
}



#pragma mark - View Lifecycle

-(void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    //modelo a vista
    NSDateFormatter *fmt = [NSDateFormatter new];
    fmt.dateStyle = NSDateFormatterLongStyle;
    
    self.modificationDateView.text = [fmt stringFromDate:self.model.modificationDate];
    
    self.nameView.text = self.model.name;
    
    self.textView.text = self.model.text;
    

    //Image
    UIImage *image = self.model.photo.image;
    
    if (!image) {
        
        image = [UIImage imageNamed:@"noImage.png"];
        
    }
    
    self.photoView.image = image;
    
    //Snapshot
    image = self.model.location.mapsnapshot.image;
    self.mapSnapshotView.userInteractionEnabled = YES;
    
    if (!image) {
        image = [UIImage imageNamed:@"noSnapshot.png"];
        self.mapSnapshotView.userInteractionEnabled = NO;

    }
    
    self.mapSnapshotView.image = image;
    
    [self startObservingSnapshot];
    
    
    [self startObservingKeyboard];
    
    [self setupInputAccessoryView];
    
    if (self.new) {
        
        //Muestro botón de cancelar
        UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemCancel
                                                                                target: self action: @selector(cancel:)];
        
        self.navigationItem.rightBarButtonItem = cancel;
        
    }
    
    
    //Delegados
    self.nameView.delegate = self;
    
    
    //Añado un gesture recognizer a la foto
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self
                                                                          action: @selector(displayDetailPhoto:)];
    
    
    [self.photoView addGestureRecognizer: tap];
    
    
    //Añado un gesture regcognizer para vista de location
    UITapGestureRecognizer *snapTap = [[UITapGestureRecognizer alloc] initWithTarget: self
                                                                              action:@selector(displayDetailLocation:)];
    
    [self.mapSnapshotView addGestureRecognizer: snapTap];
    
    
    
    //Añado botón de compartir nota
    UIBarButtonItem *share = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemAction
                                                                           target: self
                                                                           action: @selector(displayShareController:)];
    
    self.navigationItem.rightBarButtonItem = share;
    
    
}


-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    if (self.deleteCurrentNote) {
        
        [self.model.managedObjectContext deleteObject: self.model];
        
    }else{
        
        //vista a modelo
        self.model.text = self.textView.text;
        self.model.photo.image = self.photoView.image;
        self.model.name = self.nameView.text;
        
    }
    
    [self stopObservingKeyboard];
    
    [self stopObservingSnapshot];
    
    
}

#pragma mark - Keyboard

-(void) startObservingKeyboard{
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver: self
               selector: @selector(notifyThatKeyboardWillAppear:)
                   name:UIKeyboardWillShowNotification
                 object: nil];
    
    
    [center addObserver: self
               selector:@selector(notifyThatKeyboardWillDisappear:)
                   name: UIKeyboardWillHideNotification
                 object: nil];
    
}

-(void)stopObservingKeyboard{
    
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];

    [center removeObserver: self];
    
}


-(void) notifyThatKeyboardWillAppear: (NSNotification *) notification{
    
    if ([self.textView isFirstResponder]) {
        
        //Extraigo el userInfo (Diccionario)
        NSDictionary *dictionary = notification.userInfo;
        
        //Extraer la duración de la animación
        double duration = [[dictionary objectForKey: UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        
        //Cambiar las propiedades de la caja de texto
        [UIView animateWithDuration: duration
                              delay: 0
                            options: 0
                         animations:^{
                             
                             self.textView.frame = CGRectMake(self.modificationDateView.frame.origin.x, self.modificationDateView.frame.origin.y, self.textView.frame.size.width, self.textView.frame.size.width);
                             
                         }
                         completion: nil];
        
        [UIView animateWithDuration: duration
                         animations:^{
                             self.textView.alpha = 0.8;
                         }];
        
    }
    
    
    
}


-(void)notifyThatKeyboardWillDisappear: (NSNotification *) notification{
    
    if ([self.textView isFirstResponder]) {
        
        //Extraigo el userInfo (Diccionario)
        NSDictionary *dictionary = notification.userInfo;
        
        //Extraer la duración de la animación
        double duration = [[dictionary objectForKey: UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        
        //Cambiar las propiedades de la caja de texto
        [UIView animateWithDuration: duration
                              delay: 0
                            options: 0
                         animations: ^{
                             
                             self.textView.frame = CGRectMake(0, 335, self.textView.frame.size.width, self.textView.frame.size.width);
                             
                         }
                         completion: nil];
        
        [UIView animateWithDuration: duration
                         animations:^{
                             self.textView.alpha = 1;
                         }];
    }
    
}





#pragma mark - TextView

-(void) setupInputAccessoryView{
    
    //Creo una barra
    UIToolbar *textBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    
    UIToolbar *nameBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    
    //Añado botones
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemDone
                                                                          target: self
                                                                          action:@selector(dismissKeyboard:)];
    //Añado botones
    UIBarButtonItem *done2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemDone
                                                                          target: self
                                                                          action:@selector(dismissKeyboard:)];
    
    UIBarButtonItem *sep = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace
                                                                         target:nil
                                                                         action: nil];
    
//    UIBarButtonItem *smile = [[UIBarButtonItem alloc] initWithTitle: @":-) "
//                                                              style:UIBarButtonItemStylePlain
//                                                             target: self
//                                                             action:@selector(insertTitle:)];
    
    
    [textBar setItems:@[sep, done]];
    
    [nameBar setItems:@[sep, done2]];
    
    
    //La asigno como accessoryInputView
    self.textView.inputAccessoryView = textBar;
    self.nameView.inputAccessoryView = nameBar;
    
    
}


-(void)insertTitle: (UIBarButtonItem *) sender{
    
    [self.textView insertText: sender.title];
}


-(void)dismissKeyboard: (id) sender{
    
    [self.view endEditing: YES];
    
}


#pragma mark - Utils

-(void)cancel: (id) sender{
    
    self.deleteCurrentNote = YES;
    
    [self.navigationController popViewControllerAnimated: YES];
    
}




#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    //Podría validar el texto
    [textField resignFirstResponder];
    
    return YES;
    
}


#pragma mark - Actions


-(void)displayDetailLocation: (id) sender{
    
    FJLLocationViewController *locVC = [[FJLLocationViewController alloc] initWithLocation: self.model.location];
    
    [self.navigationController pushViewController: locVC
                                         animated: YES];
    
}


-(void) displayDetailPhoto: (id) sender{

    if (self.model.photo == nil) {
        self.model.photo = [FJLPhoto photoWithImage: nil
                                            context: self.model.managedObjectContext];
    }
    
    FJLPhotoViewController *photoVC = [[FJLPhotoViewController alloc] initWithModel: self.model.photo];
    
    [self.navigationController pushViewController: photoVC
                                         animated: YES];
    
    


}


-(void)displayShareController: (id) sender{
    
    //Creo un UIActivityController
    UIActivityViewController *aVC = [[UIActivityViewController alloc] initWithActivityItems: [self arrayOfItems]
                                                                      applicationActivities: nil];
    
    
    //Lo presento
    [self presentViewController: aVC
                       animated: YES
                     completion: nil];
    
    
}


-(NSArray *)arrayOfItems{
    
    NSMutableArray *items = [NSMutableArray array];
    
    if (self.model.name) {
        [items addObject: self.model.name];
    }
    
    if (self.model.text) {
        [items addObject: self.model.text];
    }

    
    if (self.model.photo.image) {
        [items addObject: self.model.photo.image];
    }
    
    return items;

    
}

#pragma mark - KVO

-(void) startObservingSnapshot{
    
    [self.model addObserver: self
                 forKeyPath: @"location.mapsnapshot.snapshotData"
                    options: NSKeyValueObservingOptionNew
                    context: NULL];
}


-(void) stopObservingSnapshot{
    
    [self.model removeObserver: self
                    forKeyPath: @"location.mapsnapshot.snapshotData"];
    
}

-(void) observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context{
    
    
    UIImage *img = self.model.location.mapsnapshot.image;
    self.mapSnapshotView.userInteractionEnabled = YES;
    
    if (!img) {
        img = [UIImage imageNamed:@"noSnapshot.png"];
        self.mapSnapshotView.userInteractionEnabled = NO;

    }
    
    self.mapSnapshotView.image = img;
    
    
}















@end

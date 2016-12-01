//
//  FJLPhotoViewController.m
//  Everpobre
//
//  Created by Fran Lucena on 25/03/16.
//  Copyright © 2016 Fran Lucena. All rights reserved.
//

#import "FJLPhotoViewController.h"
#import "FJLPhoto.h"

@import CoreImage;


@interface FJLPhotoViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) FJLPhoto *model;

@end

@implementation FJLPhotoViewController

#pragma mark - Init

-(id) initWithModel:(id)model{
    
    NSAssert(model, @"model can´t be nil");
    
    if (self = [super initWithNibName: nil
                               bundle: nil]) {
        
        _model = model;
    }
    
    return self;
}


#pragma mark - View Lifecycle

-(void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    self.photoView.image = self.model.image;
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    self.model.image = self.photoView.image;
    
    
}



#pragma mark - Actions

- (IBAction)takePhoto:(id)sender {
    
    //Creo el ImagePicker
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    //Configurarlo
    if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    picker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    //Asignar el delegado
    picker.delegate = self;
    
    //Mostrar el imagepicker
    [self presentViewController: picker
                       animated: YES
                     completion:^{
                         
                     }];
    
    
}

- (IBAction)deletePhoto:(id)sender {
    
    //Guardo el estado inicial
    CGRect oldBounds = self.photoView.bounds;
    
    
    //Elimino la foto de la vista
    [UIView animateWithDuration: 0.6
                          delay: 0
                        options: 0
                     animations:^{
                         
                         //Esta animación lo que hace es que la imagen se valla por el centro
                         self.photoView.bounds = CGRectZero;
                         self.photoView.alpha = 0;
                     
                     } completion:^(BOOL finished) {
                         
                         self.photoView.image = nil;
                         self.photoView.alpha = 1;
                         self.photoView.bounds = oldBounds;
                         
                     }];
    
    
    //Elimino la foto del modelo
    self.model.image = nil;
 
    
}

- (IBAction)applyVintageEffect:(id)sender {
    
    //Creo un contexto
    CIContext *context = [CIContext contextWithOptions: nil];
    
    //Creo una CIImage de entrada
    CIImage *image = [CIImage imageWithCGImage: self.model.image.CGImage];
    
    //Creo un filtro
    CIFilter *old = [CIFilter filterWithName:@"CIFalseColor"];
    
    [old setDefaults];
    [old setValue: image
       forKeyPath: kCIInputImageKey];
    
    //Creo el vignette
    CIFilter *vignette = [CIFilter filterWithName:@"CIVignette"];
    
    [vignette setDefaults];
    [vignette setValue: @12
            forKeyPath: kCIInputIntensityKey];
    
    //Encadeno los filtros
    [vignette setValue: old.outputImage
            forKeyPath: kCIInputImageKey];
    
    
    //Obtengo imagen de salida
    CIImage *output = vignette.outputImage;
    
    
    //Aplico el filtro y lo paso a segundo plano
    [self.activityView startAnimating];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        CGImageRef res = [context createCGImage: output
                                       fromRect: [output extent]];
       
        dispatch_async(dispatch_get_main_queue(), ^{
             
            [self.activityView stopAnimating];
            
            //Guardo la nueva imagen
            UIImage *img = [UIImage imageWithCGImage: res];
            
            self.photoView.image = img;
            
            //Libero el CGImageRef
            CGImageRelease(res);

            
        });
        
    });
    
    
}

- (IBAction)zoomToFace:(id)sender {
    
    //NSLog(@"%@", [self featuresInImage: self.photoView.image]);
    
    NSArray *features = [self featuresInImage:self.photoView.image];
    
    if (features) {
        
        CIFeature *face = [features lastObject];
        CGRect faceBounds = [face bounds];
        
        CIImage *image = [CIImage imageWithCGImage:self.photoView.image.CGImage];
        CIImage *crop = [image imageByCroppingToRect: faceBounds];
        
        UIImage *newImage = [UIImage imageWithCIImage: crop];
        
        self.photoView.image = newImage;
        
    }
    
    
    
    
    
}


-(NSArray *) featuresInImage: (UIImage *) image{
    
    CIContext *context = [CIContext contextWithOptions: nil];
    
    CIDetector *detector = [CIDetector detectorOfType: CIDetectorTypeFace
                                              context: context
                                              options: @{CIDetectorAccuracy: CIDetectorAccuracyHigh}];
    
    CIImage *img = [CIImage imageWithCGImage: image.CGImage];
    
    NSArray *features = [detector featuresInImage: img];
    
    if ([features count]) {
        
        return features;
        
    }else{
        return nil;
    }
    
}


#pragma mark - UIImagePickerControllerDelegate

-(void) imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *img = [info objectForKey: UIImagePickerControllerOriginalImage];
    
    self.model.image = img;
    
    NSLog(@"Size of image: %@", NSStringFromCGSize(img.size));
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    CGFloat screenScale = [[UIScreen mainScreen] scale];
    
    CGSize screenSize = CGSizeMake(screenBounds.size.width *screenScale, screenBounds.size.height * screenScale);
    
    NSLog(@"Size of screen: %@", NSStringFromCGSize(screenSize));
    
        
    [self dismissViewControllerAnimated: YES
                             completion:^{
                                 
                             }];
    
    
}










@end

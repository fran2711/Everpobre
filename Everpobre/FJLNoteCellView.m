//
//  FJLNoteCellView.m
//  Everpobre
//
//  Created by Fran Lucena on 16/03/16.
//  Copyright © 2016 Fran Lucena. All rights reserved.
//

#import "FJLNoteCellView.h"
#import "FJLNote.h"
#import "FJLPhoto.h"

@interface FJLNoteCellView ()

@property (strong, nonatomic) FJLNote* note;

@end

@implementation FJLNoteCellView

+(NSArray *) keys{
    
    return @[@"title", @"modificationDate", @"photo.image", @"location", @"location.latitude", @"location.longitude", @"location.address"];
    
}

-(void) observeNote: (FJLNote *) note{
    
    //Guardo la nota en la propiedad
    self.note = note;
    
    //Observo ciertas propiedades
    for (NSString *key in [FJLNoteCellView keys]) {
        
        [self.note addObserver: self
                    forKeyPath: key
                       options: NSKeyValueObservingOptionNew
                       context: NULL];
    }
    
    [self syncWithNote];
    
    
}


-(void) syncWithNote{

    //Configuro la celda
    self.titleView.text = self.note.name;
    
    NSDateFormatter *fmt = [NSDateFormatter new];
    fmt.dateStyle = NSDateFormatterMediumStyle;
    
    self.modificationDateView.text = [fmt stringFromDate: self.note.modificationDate];
    
    UIImage *img;
    
    if (self.note.photo.image == nil) {
        
        img = [UIImage imageNamed: @"noImage.png"];
        
    }else{
        
        img = self.note.photo.image;
    }
    
    self.photoView.image = img;

    if (self.note.hasLocation) {
        self.locationView.image = [UIImage imageNamed:@"placemark.png"];
    }else{
        self.locationView.image = nil;
    }
    
}



//Recibo la notificación
-(void) observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context{
    
    
    [self syncWithNote];
}


//Me doy de baja de la notificación
-(void) prepareForReuse{
    
    self.note = nil;
    
    [self syncWithNote];
    
}





@end

//
//  FJLNotebookCellView.m
//  Everpobre
//
//  Created by Fran Lucena on 08/03/16.
//  Copyright © 2016 Fran Lucena. All rights reserved.
//

#import "FJLNotebookCellView.h"

@implementation FJLNotebookCellView

#pragma mark - Class Methods

+(NSString *)cellId{
    
    //Devuelve una cadena a partir de la clase
    return NSStringFromClass(self);
    
}


+(CGFloat)cellHeight{
    
    return 60.0f;
    
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

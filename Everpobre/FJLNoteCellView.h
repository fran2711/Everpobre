//
//  FJLNoteCellView.h
//  Everpobre
//
//  Created by Fran Lucena on 16/03/16.
//  Copyright © 2016 Fran Lucena. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FJLNote;

@interface FJLNoteCellView : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (weak, nonatomic) IBOutlet UILabel *modificationDateView;
@property (weak, nonatomic) IBOutlet UILabel *titleView;

@property (weak, nonatomic) IBOutlet UIImageView *locationView;

-(void) observeNote: (FJLNote *) note;


@end

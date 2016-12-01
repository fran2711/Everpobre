//
//  FJLNotebookCellView.h
//  Everpobre
//
//  Created by Fran Lucena on 08/03/16.
//  Copyright © 2016 Fran Lucena. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FJLNotebookCellView : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *nameView;
@property (nonatomic, strong) IBOutlet UILabel *namberOfNotesView;


+(NSString *)cellId;
+(CGFloat)cellHeight;



@end
